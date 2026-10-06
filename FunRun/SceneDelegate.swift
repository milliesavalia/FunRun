import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create the main window and view controllers
        let mainWindow = UIWindow(windowScene: windowScene)
        let rootViewController = ViewController()
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)

        // Setup the navigation bar appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]

        rootNavigationController.navigationBar.standardAppearance = navBarAppearance
        rootNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        rootNavigationController.navigationBar.tintColor = UIColor.black

        mainWindow.rootViewController = rootNavigationController
        mainWindow.makeKeyAndVisible()

        window = mainWindow
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

