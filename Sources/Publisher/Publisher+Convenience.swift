import Combine

public extension Publisher {
	
	/// Catches the errors and immediately completes the publishes instead.
	var dropError: AnyPublisher<Output, Never> {
		`catch` { _ in
			Empty<Output, Never>()
		}.eraseToAnyPublisher()
	}
	
	/// Maps the value to `Void`.
	func mapToVoid() -> Publishers.Map<Self, Void> {
		map { _ in () }
	}
	
}
