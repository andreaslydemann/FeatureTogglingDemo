import Foundation

final class FeatureService {

    static let shared = FeatureService()
    private let storage = FeatureStorage()
    
    private init() { }
    
    public func getFeatures(providers: [FeatureProvider], completion: @escaping() -> Void) {
        storage.getFeatures(providers, completion: completion)
    }
    
    public func enabled(_ name: Feature) -> Bool {
        let features = storage.features()
        
        return features[name] == true
    }
}

extension FeatureService {
    public func updateFeature(_ name: Feature, enabled: Bool) {
        storage.updateFeature(name, enabled: enabled)
    }
}
