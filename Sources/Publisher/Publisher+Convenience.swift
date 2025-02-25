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

public extension Publisher {
	
	func sink(
		receiveValue: @escaping ((Output) -> Void),
		receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void)
	) -> AnyCancellable {
		sink(
			receiveCompletion: receiveCompletion,
			receiveValue: receiveValue
		)
	}
	
}

public extension Publisher where Output == Void {
	
	func sink(
		receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void
	) -> AnyCancellable {
		sink(
			receiveCompletion: receiveCompletion,
			receiveValue: {}
		)
	}
	
}

public extension Publisher where Failure == Never {
	
	/// Changes the failure type to the value required in the context.
	func promoteError<T>() -> AnyPublisher<Output, T> where T: Error {
		setFailureType(to: T.self).eraseToAnyPublisher()
	}

}
