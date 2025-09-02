import Combine
import Foundation

public final class CancellablesBag {
	
	// MARK: - Stored Properties / Introspection
	
	public var isEmpty: Bool {
		synchronized {
			cancellables.isEmpty
		}
	}
	
	// MARK: - Stored Properties / Tools
	
	private var cancellables: Set<AnyCancellable> = []
	private let lock = NSRecursiveLock()
	
	// MARK: - Life Cycle
	
	public init() {}
	
	deinit {
		cancelAll()
	}
	
}

// MARK: - Controls / Store

public extension CancellablesBag {
	
	func store(_ cancellable: AnyCancellable) {
		synchronized {
			cancellables.insert(cancellable)
		}
	}
	
	func store(_ cancellables: [AnyCancellable]) {
		synchronized {
			self.cancellables.formUnion(cancellables)
		}
	}
	
	func store(_ cancellables: AnyCancellable...) {
		store(cancellables)
	}
	
}

// MARK: - Controls / Remove

public extension CancellablesBag {
	
	func remove(_ cancellable: AnyCancellable) {
		synchronized {
			cancellables.remove(cancellable)
		}
	}
	
	func remove(_ cancellables: [AnyCancellable]) {
		synchronized {
			self.cancellables.subtract(cancellables)
		}
	}
	
}

// MARK: - Controls / Cancel

public extension CancellablesBag {

	func cancelAll() {
		synchronized {
			cancellables.forEach {
				$0.cancel()
			}
			cancellables.removeAll()
		}
	}
	
}

// MARK: - Synchronization

private extension CancellablesBag {
	
	@discardableResult private func synchronized<T>(
		_ execute: () throws -> T
	) rethrows -> T {
		lock.lock()
		defer {
			lock.unlock()
		}
		return try execute()
	}
	
}
