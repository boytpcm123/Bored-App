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
        
        updateNightMode()
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
        overrideUserInterfaceStyle = viewModel.getNightModeSetting() ? .dark : .light
    }
}

// MARK: - SUPPORT FUCTIONS
extension BaseViewController {
    
}
