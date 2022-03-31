//
//  SettingScreenController.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import UIKit

class SettingScreenController: BaseViewController {
    
    static func instantiate() -> BaseViewController {
        let controller = SettingScreenController()
        controller.viewModel = SettingScreenViewModel()
        return controller
    }
    
    // MARK: - OUTLET
    
    // MARK: - PROPERTIES
    private var viewModel: SettingScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

// MARK: - SUPPORT FUCTIONS
extension SettingScreenController {
    
    fileprivate func setupUI() {
        self.title = viewModel.getTitleScreen()
    }
}
