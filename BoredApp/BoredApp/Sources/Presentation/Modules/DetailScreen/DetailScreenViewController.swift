//
//  DetailScreenViewController.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class DetailScreenViewController: BaseViewController {
    
    static func instantiate(activityViewModel: ActivityViewModel) -> BaseViewController {
        let controller = DetailScreenViewController()
        controller.viewModel = DetailScreenViewModel(activityViewModel: activityViewModel)
        return controller
    }
    
    // MARK: - OUTLET
    @IBOutlet private weak var activityLbl: UILabel!
    @IBOutlet private weak var participantLbl: UILabel!
    @IBOutlet private weak var priceLbl: UILabel!
    @IBOutlet private weak var accessibilityLbl: UILabel!
    @IBOutlet private weak var typeLbl: UILabel!
    @IBOutlet private weak var linkLbl: UILabel!
    @IBOutlet private weak var linkBtn: UIButton!
    
    // MARK: - PROPERTIES
    private var viewModel: DetailScreenViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindLinkBtn()
    }
}

// MARK: - SUPPORT FUCTIONS
extension DetailScreenViewController {
    
    fileprivate func setupUI() {
        
        self.title = viewModel.getTitleScreen()
        
        activityLbl.text = viewModel.getActivity()
        participantLbl.text = viewModel.getParticipants()
        priceLbl.text = viewModel.getPrice()
        accessibilityLbl.text = viewModel.getAccessibility()
        typeLbl.text = viewModel.getType()
        linkLbl.text = viewModel.getLink()
    }
    
    fileprivate func bindLinkBtn() {
        linkBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                if let url = self?.viewModel.getURL(), UIApplication.shared.canOpenURL(url) {
                    let safariVC = SFSafariViewController(url: url)
                    safariVC.modalPresentationStyle = .automatic
                    self?.present(safariVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
