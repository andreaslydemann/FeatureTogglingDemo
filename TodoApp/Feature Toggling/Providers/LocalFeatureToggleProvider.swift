import Foundation

struct LocalFeatureToggleProvider: FeatureToggleProvider {
    public func fetchFeatureToggles(_ completion: @escaping FeatureToggleCallback) {
        let configuration = LocalFeatureToggleProvider.loadConfiguration() ?? []
        
        completion(configuration)
    }
}
