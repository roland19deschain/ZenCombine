import Foundation
import Combine

public extension AnyCancellable {

	func store(in bag: CancellablesBag) {
		bag.store(self)
	}

	func store(in bag: CancellablesBag?) {
		bag?.store(self)
	}

}
