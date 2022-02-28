import Foundation
import Combine

public extension AnyPublisher {

	static func wrap(_ result: @autoclosure @escaping () -> Output) -> Self {
		Deferred {
			Future { promise in
				DispatchQueue.global().async {
					promise(.success(result()))
				}
			}
		}.eraseToAnyPublisher()
	}

}
