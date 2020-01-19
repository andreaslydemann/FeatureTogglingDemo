import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        defer { self.window = window }

        window.windowScene = windowScene

        window.rootViewController = UINavigationController(rootViewController: CategoryViewController())
        window.makeKeyAndVisible()

        let providers: [FeatureProvider] = [DefaultFeatureProvider()]
        
        FeatureService.shared.getFeatures(providers: providers) {
            print("Successfully fetched features.")
        }
    }
}
