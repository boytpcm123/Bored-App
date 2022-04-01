//
//  SceneDelegate.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        setRootViewController()
    }
}

// MARK: - PUBLIC FUCTIONS
extension SceneDelegate {
    
    func overrideApplicationThemeStyle(isDarkMode: Bool) {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}

// MARK: - SUPPORT FUCTIONS
extension SceneDelegate {
    
    private func setRootViewController() {
        let controller = HomeScreenController.instantiate()
        let navVC: UINavigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
