import Foundation
import Combine

public extension AnyPublisher where Failure == Error {

	static var justVoid: AnyPublisher<Void, Error> {
		Just(()).setFailureType(
			to: Error.self
		).eraseToAnyPublisher()
	}
	
}
