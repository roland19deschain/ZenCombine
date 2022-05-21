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

public extension AnyPublisher where Output: ExpressibleByNilLiteral {
	
	static var justNil: AnyPublisher<Output, Failure> {
		Just(nil).setFailureType(to: Failure.self).eraseToAnyPublisher()
	}
	
}
