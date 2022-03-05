import Combine

public extension Collection where Element: Publisher {

	var combineLatest: CombineLatestCollection<Self> {
		CombineLatestCollection(self)
	}
	
}
