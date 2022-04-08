//
//  HomeScreenController.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class HomeScreenController: BaseViewController {
    
    static func instantiate() -> BaseViewController {
        let controller = HomeScreenController()
        controller.viewModel = HomeScreenViewModel()
        return controller
    }
    
    // MARK: - OUTLET
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.registerReusedCell(cellNib: ActivityCell.self, bundle: nil)
            self.tableView.registerReusedHeaderView(headerNib: ActivityHeaderCellView.self, bundle: nil)
            self.tableView.tableFooterView = UIView()
            self.tableView.contentInsetAdjustmentBehavior = .never
            self.tableView.delegate = self
            self.tableView.dataSource = self
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            }
        }
    }
    @IBOutlet private weak var settingBtn: UIButton!
    @IBOutlet private weak var emptyTextLbl: UILabel!
    
    // MARK: - PROPERTIES
    private var viewModel: HomeScreenViewModel!
    private let disposeBag = DisposeBag()
    private var listActivityGroup: [ActivityGroupViewModel] = []
    private let refreshControl = UIRefreshControl()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindSettingBtn()
        bindData()
        fetchActivities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - SUPPORT FUCTIONS
extension HomeScreenController {
    
    fileprivate func setupUI() {
        
        self.title = viewModel.getTitleScreen()
        self.emptyTextLbl.text = "Oop! You don't like any activity, right? :((\nPlease try one more time !!!"
        
        tableView.refreshControl = refreshControl
    }
    
    fileprivate func bindData() {
        
        refreshControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.fetchActivities()
                ProgressHUD.show()
            })
            .disposed(by: disposeBag)
        
        viewModel.showLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? ProgressHUD.show() : ProgressHUD.dismiss()
                if !isLoading {
                    self?.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.publishListActivityGroup
            .catchAndReturn([])
            .subscribe(onNext: { [weak self] listActivityGroup in
                guard let self = self else { return }
                
                self.listActivityGroup = listActivityGroup
                self.tableView.reloadData()
                self.tableView.alpha = self.listActivityGroup.isEmpty ? 0 : 1
            })
            .disposed(by: disposeBag)
        
    }
    
    fileprivate func fetchActivities() {
        viewModel.fetchActivities()
    }
    
    fileprivate func bindSettingBtn() {
        settingBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                let controller = SettingScreenController.instantiate { settingChanged in
                    guard settingChanged else { return }
                    
                    self.tableView.alpha = 1
                    self.viewModel.fetchActivities()
                }
                
                let navVC: UINavigationController = UINavigationController(rootViewController: controller)
                navVC.modalPresentationStyle = .automatic
                self.present(navVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UITableViewDataSource
extension HomeScreenController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listActivityGroup.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let activityGroupViewModel = listActivityGroup[section]
        return activityGroupViewModel.getLengthListActivity()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 51
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let activityHeaderCellView =
                tableView.dequeueReusableHeaderView(headerNib: ActivityHeaderCellView.self) else {
                    return UIView()
                }
        
        let nameType = viewModel.getNameType(with: listActivityGroup, atSection: section)
        activityHeaderCellView.bindData(nameType)
        return activityHeaderCellView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusable(cellNib: ActivityCell.self, indexPath: indexPath)
        else {
            return UITableViewCell()
        }
        
        let activityViewModel = viewModel.getActivityViewModel(with: listActivityGroup, indexPath: indexPath)
        cell.bindData(activityViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeScreenController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let activityViewModel = viewModel.getActivityViewModel(with: listActivityGroup, indexPath: indexPath)
        let controller = DetailScreenViewController.instantiate(activityViewModel: activityViewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
