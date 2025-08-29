import Combine
import Foundation

public final class CancellablesBag {
	
	// MARK: - Stored Properties / Tools
	
	private var cancellables: Set<AnyCancellable> = []
	private let lock = NSRecursiveLock()
	
	// MARK: - Life Cycle
	
	public init() {}
	
	deinit {
		cancelAll()
	}
	
}

// MARK: - Controls

public extension CancellablesBag {

	func store(_ cancellable: AnyCancellable) {
		lock.lock()
		defer {
			lock.unlock()
		}
		cancellables.insert(cancellable)
	}

	func store(_ cancellables: [AnyCancellable]) {
		lock.lock()
		defer {
			lock.unlock()
		}
		cancellables.forEach {
			self.cancellables.insert($0)
		}
	}

	func cancelAll() {
		lock.lock()
		defer {
			lock.unlock()
		}
		cancellables.removeAll()
	}
	
}
