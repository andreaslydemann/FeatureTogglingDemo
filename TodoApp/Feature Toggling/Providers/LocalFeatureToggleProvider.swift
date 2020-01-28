import Foundation

struct LocalFeatureToggleProvider: FeatureToggleProvider {
    public func fetchEnabledFeatures(_ completion: @escaping FeatureCallback) {
        let features: [FeatureToggle] = [
            .addItem
        ]
        
        completion(features)
    }
}
