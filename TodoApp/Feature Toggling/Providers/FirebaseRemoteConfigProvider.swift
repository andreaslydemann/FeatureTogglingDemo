import Foundation
import Firebase

struct FirebaseRemoteConfigProvider: FeatureToggleProvider {
    public func fetchEnabledFeatures(_ completion: @escaping FeatureCallback) {
        let keys = RemoteConfig.remoteConfig().allKeys(from: .remote)
        let features = getEnabledFeatures(byKeys: keys)
        
        completion(features)
    }
}
