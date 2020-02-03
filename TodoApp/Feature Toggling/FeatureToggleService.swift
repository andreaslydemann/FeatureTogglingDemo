import Foundation

final class FeatureToggleService {
    private init() { }
    
    static let shared = FeatureToggleService()
    
    private var featureToggles: [FeatureToggle] = []
    
    public func fetchFeatureToggles(provider: FeatureToggleProvider, completion: @escaping () -> Void) {
        provider.fetchFeatureToggles { [weak self] fetchedFeatureToggles in
            guard let self = self else { return }
            
            if fetchedFeatureToggles.count > 0 {
                self.featureToggles = fetchedFeatureToggles
            } else {
                self.useDefaultFeatureToggles()
            }
            
            completion()
        }
    }
    
    public func isEnabled(_ featureName: Feature) -> Bool {
        let feature = featureToggles.first(where: { $0.name == featureName })
        return feature?.enabled ?? false
    }
    
    private func useDefaultFeatureToggles() {
        let defaultProvider = getDefaultFeatureToggleProvider()
        
        defaultProvider.fetchFeatureToggles { [weak self] featureToggles in
            if let self = self {
                self.featureToggles = featureToggles
            }
        }
    }
    
    private func getDefaultFeatureToggleProvider() -> FeatureToggleProvider {
        return LocalFeatureToggleProvider()
    }
}
