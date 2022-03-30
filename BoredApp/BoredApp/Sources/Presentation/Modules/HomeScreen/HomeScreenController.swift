//
//  HomeScreenController.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeScreenController: BaseViewController {
    
    // MARK: - OUTLET
    
    // MARK: - PROPERTIES
    private var viewModel = HomeScreenViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - SUPPORT FUCTIONS
extension HomeScreenController {
    
}
