import Foundation
import Firebase

struct FirebaseRemoteConfigProvider: FeatureProvider {
    
    public func fetchEnabledFeatures(_ completion: @escaping([Feature]?) -> Void) {
        
        let keys = RemoteConfig.remoteConfig().allKeys(from: .remote)
        
        var features: [Feature] = []
        for key in keys {
            if let feature = Feature(rawValue: key) {
                features.append(feature)
            }
        }
        
        completion(features)
    }
}
