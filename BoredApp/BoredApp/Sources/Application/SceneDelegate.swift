//
//  SceneDelegate.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let router = AppCoordinator().strongRouter

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        router.setRoot(for: window)
        self.window = window
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
    
}
