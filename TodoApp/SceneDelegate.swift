import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        defer { self.window = window }

        window.windowScene = windowScene

        window.rootViewController = UINavigationController(rootViewController: CategoryViewController())
        window.makeKeyAndVisible()
        
        FirebaseApp.configure()

        let firebaseRemoteConfig: FeatureProvider = FirebaseRemoteConfigProvider()

        FeatureService.shared.fetchFeatures(provider: firebaseRemoteConfig) {
            print("Successfully fetched features.")
        }
    }
}
