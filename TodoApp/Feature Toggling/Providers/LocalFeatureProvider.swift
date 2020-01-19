import Foundation

struct LocalFeatureProvider: FeatureProvider {
    public func fetchEnabledFeatures(_ completion: @escaping([Feature]?) -> Void) {
    
        let features: [Feature] = [
            .addItem
        ]
        
        completion(features)
    }
}
