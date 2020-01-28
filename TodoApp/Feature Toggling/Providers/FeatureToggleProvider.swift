import Foundation

typealias FeatureCallback = ([FeatureToggle]?) -> Void

protocol FeatureToggleProvider {
    func fetchEnabledFeatures(_ completion: @escaping FeatureCallback)
}

extension FeatureToggleProvider {
    func getEnabledFeatures(byKeys keys: [String]) -> [FeatureToggle] {
        var features: [FeatureToggle] = []
        
        for key in keys {
            if let feature = FeatureToggle(rawValue: key) {
                features.append(feature)
            }
        }
        
        return features
    }
}
