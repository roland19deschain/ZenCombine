import Foundation
import Combine

public extension AnyPublisher {
	
	static func wrap(_ result: Output) -> Self {
		Deferred {
			Future { promise in
				promise(.success(result))
			}
		}.eraseToAnyPublisher()
	}
	
	static func wrapAsync(
		qos: DispatchQoS.QoSClass = .default,
		_ result: @autoclosure @escaping () -> Output
	) -> Self {
		Deferred {
			Future { promise in
				DispatchQueue.global(qos: qos).async {
					promise(.success(result()))
				}
			}
		}.eraseToAnyPublisher()
	}
	
}
