import Foundation

typealias FeatureTogglesWithValue = [FeatureToggle : Bool]

final class FeatureToggleService {
    
    private init() { }
    
    private var featureToggles: FeatureTogglesWithValue = [:]
    static let shared = FeatureToggleService()
    
    public func fetchFeatureToggles(provider: FeatureToggleProvider, completion: @escaping () -> Void) {
        provider.fetchEnabledFeatures { fetchedFeatureToggles in
            if let fetchedFeatureToggles = fetchedFeatureToggles {
                for feature in FeatureToggle.allCases {
                    self.featureToggles[feature] = fetchedFeatureToggles.contains(feature)
                }
            } else {
                self.featureToggles = self.getDefaultFeatureToggles()
            }
            
            completion()
        }
    }
    
    public func isEnabled(_ name: FeatureToggle) -> Bool {
        return featureToggles[name] == true
    }
    
    private func getDefaultFeatureToggles() -> FeatureTogglesWithValue {
        return Dictionary(uniqueKeysWithValues: FeatureToggle.enabledByDefault.map { ($0, true) })
    }
}
