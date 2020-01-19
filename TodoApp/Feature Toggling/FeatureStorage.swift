import Foundation

typealias FeaturesWithState = [Feature : Bool]

final class FeatureStorage {

    fileprivate var featuresWithState: FeaturesWithState = [:]
    
    public func features() -> FeaturesWithState {
        return featuresWithState
    }
    
    public func setFeatures(_ features: FeaturesWithState) {
        featuresWithState = features
    }
    
    public func updateFeature(_ name: Feature, enabled: Bool) {
        featuresWithState[name] = enabled
    }
    
    public func getFeatures(_ providers: [FeatureProvider], completion: @escaping() -> Void) {
        for provider in providers {
            provider.fetchEnabledFeatures { fetchedFeatures in
                if let loadedFeatures = fetchedFeatures {
                    for feature in Feature.allCases {
                        self.featuresWithState[feature] = loadedFeatures.contains(feature)
                    }
                } else {
                    self.featuresWithState = self.getDefaultFeatures()
                }
                completion()
            }
        }
    }
    
    private func getDefaultFeatures() -> FeaturesWithState {
        return Dictionary(uniqueKeysWithValues: Feature.enabledByDefault.map { ($0, true)})
    }
}
