import Foundation

typealias FeatureCallback = ([FeatureToggle]?) -> Void

protocol FeatureToggleProvider {
    func fetchEnabledFeatures(_ completion: @escaping FeatureCallback)
}

extension FeatureToggleProvider {
    func getEnabledFeatures(featureToggles: [String: Bool]) -> [FeatureToggle] {
        let enabledFeatures = featureToggles
            .filter { $1 == true }
            .compactMap { FeatureToggle(rawValue: $0.key ) }
        
        return enabledFeatures
    }
}
