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
        setRootViewController(HomeScreenController())
    }
}

// MARK: - SUPPORT FUCTIONS
extension SceneDelegate {
    
    private func setRootViewController(_ viewController: UIViewController) {
        let navVC: UINavigationController = UINavigationController(rootViewController: viewController)
        navVC.navigationBar.isHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
