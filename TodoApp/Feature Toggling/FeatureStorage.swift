import Foundation

typealias FeaturesWithState = [Feature : Bool]

final class FeatureStorage {

    fileprivate var featuresWithState: FeaturesWithState = [:]
    
    public func features() -> FeaturesWithState {
        return featuresWithState
    }
    
    public func fetchFeatures(_ provider: FeatureProvider, completion: @escaping() -> Void) {
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
    
    private func getDefaultFeatures() -> FeaturesWithState {
        return Dictionary(uniqueKeysWithValues: Feature.enabledByDefault.map { ($0, true)})
    }
}
