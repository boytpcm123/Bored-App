//
//  AppDelegate.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let container = Container()
    var assembler: Assembler!
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // setup di
        assembler = Assembler([
            GeneralAssembly()
        ], container: AppDelegate.container)
        
        return true
    }
}
