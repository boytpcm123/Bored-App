//
//  SceneDelegate.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var assembler: Assembler!
    internal let container = Container()

    var window: UIWindow?
    private var router: AppCoordinator = AppCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)

        // setup di
        assembler = Assembler([
            GeneralAssembly()
        ], container: container)

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

    private func setupCoordinator() {

    }
}
