import Foundation
import Combine

public struct CombineLatestCollection<Publishers> where
Publishers: Collection,
Publishers.Element: Publisher
{
	// MARK: - Type Definition
	
	public typealias Output = [Publishers.Element.Output]
	public typealias Failure = Publishers.Element.Failure
	
	// MARK: - Stored Properties
	
	private let publishers: Publishers
	
	// MARK: - Life Cycle
	
	public init(_ publishers: Publishers) {
		self.publishers = publishers
	}
	
}

// MARK: - Publisher

extension CombineLatestCollection: Publisher {
	
	public func receive<S>(subscriber: S) where
	S: Subscriber,
	S.Failure == Failure,
	S.Input == Output {
		let subscription = Subscription(
			publishers: publishers,
			subscriber: subscriber
		)
		subscriber.receive(subscription: subscription)
	}
}

// MARK: - Subscription

extension CombineLatestCollection {
	
	public final class Subscription<Subscriber>: Combine.Subscription
	where
	Subscriber: Combine.Subscriber,
	Subscriber.Failure == Failure,
	Subscriber.Input == Output
	{
		private let subscribers: [AnyCancellable]
		
		fileprivate init(publishers: Publishers, subscriber: Subscriber) {
			var values: [Publishers.Element.Output?] = Array(
				repeating: nil,
				count: publishers.count
			)
			var completions = 0
			var hasCompleted = false
			var lock = pthread_mutex_t()
			subscribers = publishers.enumerated().map { index, publisher in
				publisher.sink { completion in
					pthread_mutex_lock(&lock)
					defer {
						pthread_mutex_unlock(&lock)
					}
					guard case .finished = completion else {
						// One failure in any of the publishers cause a
						// failure for this subscription.
						subscriber.receive(completion: completion)
						hasCompleted = true
						return
					}
					
					completions += 1
					
					if completions == publishers.count {
						subscriber.receive(completion: completion)
						hasCompleted = true
					}
					
				} receiveValue: { value in
					pthread_mutex_lock(&lock)
					defer {
						pthread_mutex_unlock(&lock)
					}
					guard !hasCompleted else {
						return
					}
					values[index] = value
					
					// Get non-optional array of values and make sure we
					// have a full array of values.
					let current = values.compactMap { $0 }
					if current.count == publishers.count {
						_ = subscriber.receive(current)
					}
				}
			}
		}
		
		public func request(_ demand: Subscribers.Demand) {}
		
		public func cancel() {
			subscribers.forEach { $0.cancel() }
		}
		
	}
	
}
