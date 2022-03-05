import Combine

public extension Sequence where Element: Publisher {
	
	var merge: Publishers.MergeMany<Element> {
		Publishers.MergeMany(self)
	}
	
}
