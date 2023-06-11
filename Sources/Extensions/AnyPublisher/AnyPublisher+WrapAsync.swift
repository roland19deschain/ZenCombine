import Foundation
import Combine

public extension AnyPublisher {
	
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
