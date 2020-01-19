import Foundation

struct DefaultFeatureProvider: FeatureProvider {
    public func fetchEnabledFeatures(_ completion: @escaping([Feature]?) -> Void) {
    
        let features: [Feature] = [
            .addItem
        ]
        
        completion(features)
    }
}
