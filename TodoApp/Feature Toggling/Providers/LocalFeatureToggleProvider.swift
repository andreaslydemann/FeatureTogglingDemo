import Foundation

struct LocalFeatureToggleProvider: FeatureToggleProvider {
    public func fetchEnabledFeatures(_ completion: @escaping FeatureCallback) {
        let enabledFeatures: [FeatureToggle] = [
            .addItem
        ]
        
        completion(enabledFeatures)
    }
}
