import Foundation
import Combine

public extension AnyPublisher {

	static var justVoid: AnyPublisher<Void, Failure> {
		Just(()).setFailureType(
			to: Failure.self
		).eraseToAnyPublisher()
	}
	
	static var justTrue: AnyPublisher<Bool, Failure> {
		Just(true).setFailureType(
			to: Failure.self
		).eraseToAnyPublisher()
	}
	
	static var justFalse: AnyPublisher<Bool, Failure> {
		Just(false).setFailureType(
			to: Failure.self
		).eraseToAnyPublisher()
	}
	
}
