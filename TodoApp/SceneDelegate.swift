import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        defer { self.window = window }

        window.windowScene = windowScene
        
        prepareFirebaseRemoteConfig()

        let categoryVC = CategoryViewController(coreDataConnection: .shared, featureToggleService: .shared)
        
        window.rootViewController = UINavigationController(rootViewController: categoryVC)
        window.makeKeyAndVisible()
    }
    
    private func prepareFirebaseRemoteConfig() {
        FirebaseApp.configure()
        
        FeatureToggleService.shared.fetchFeatureToggles(mainProvider: FirebaseRemoteConfigProvider(), fallbackProvider: LocalFeatureToggleProvider()) {
            print("Feature toggles successfully fetched.")
        }
    }
}
