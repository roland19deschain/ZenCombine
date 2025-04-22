import Foundation
import Combine

public extension AnyPublisher {
	
	var asyncStream: AsyncStream<Output> {
		AsyncStream { continuation in
			let cancellable = sink(
				receiveCompletion: { _ in continuation.finish() },
				receiveValue: { continuation.yield($0) }
			)
			continuation.onTermination = { _ in
				cancellable.cancel()
			}
		}
	}
	
}

public extension AsyncStream {
	
	var publisher: AnyPublisher<Element, Never> {
		let subject = PassthroughSubject<Element, Never>()
		Task {
			for await value in self {
				subject.send(value)
			}
			subject.send(completion: .finished)
		}
		return subject.eraseToAnyPublisher()
	}
	
}
