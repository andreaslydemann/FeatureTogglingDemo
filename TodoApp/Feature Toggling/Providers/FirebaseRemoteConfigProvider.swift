import Foundation
import Firebase

struct FirebaseRemoteConfigProvider: FeatureToggleProvider {
    public func fetchFeatureToggles(_ completion: @escaping FeatureToggleCallback) {
        let remoteConfig = RemoteConfig.remoteConfig()
        let keys = remoteConfig.allKeys(from: .remote)
        let featureToggles = keys.map { FeatureToggle(name: Feature(rawValue: $0), enabled: remoteConfig[$0].boolValue) }
        
        completion(featureToggles)
    }
}
