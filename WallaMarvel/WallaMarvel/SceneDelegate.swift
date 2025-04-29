import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let listHeroesVC = ListHeroesBuilder.build()
        let navController = UINavigationController(rootViewController: listHeroesVC)

        window.rootViewController = navController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

