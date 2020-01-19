import Foundation

final class FeatureService {

    static let shared = FeatureService()
    private let storage = FeatureStorage()
    
    private init() { }
    
    public func fetchFeatures(provider: FeatureProvider, completion: @escaping() -> Void) {
        storage.fetchFeatures(provider, completion: completion)
    }
    
    public func enabled(_ name: Feature) -> Bool {
        let features = storage.features()
        
        return features[name] == true
    }
}
