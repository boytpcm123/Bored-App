//
//  BaseViewController.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - OUTLET
    
    // MARK: - PROPERTIES
    private var viewModel: BaseViewModel = BaseViewModel()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer)
    -> Bool { true }
}

// MARK: - CONFIG
extension BaseViewController {
    // override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    func updateNightMode() {
        guard let sceneDelegate = UIApplication.shared
                .connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.overrideApplicationThemeStyle(isDarkMode: viewModel.getNightModeSetting())
    }
}

// MARK: - SUPPORT FUCTIONS
extension BaseViewController {
    
    private func setupUI() {
        updateNightMode()
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.tintColor = .gray
        
        self.navigationController?.navigationBar .setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
