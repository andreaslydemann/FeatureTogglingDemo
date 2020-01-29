import Foundation
import Firebase

struct FirebaseRemoteConfigProvider: FeatureToggleProvider {
    public func fetchEnabledFeatures(_ completion: @escaping FeatureCallback) {
        let remoteConfig = RemoteConfig.remoteConfig()
        let keys = remoteConfig.allKeys(from: .remote)
        let featureToggles = Dictionary(uniqueKeysWithValues: keys.map { ($0, remoteConfig[$0].boolValue) })
        let enabledFeatures = getEnabledFeatures(featureToggles: featureToggles)
        
        completion(enabledFeatures)
    }
}
