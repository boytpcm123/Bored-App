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
    
    // MARK: - OUTLET
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.registerReusedCell(cellNib: ActivityCell.self, bundle: nil)
            self.tableView.registerReusedHeaderView(headerNib: ActivityHeaderCellView.self, bundle: nil)
            self.tableView.tableFooterView = UIView()
            self.tableView.contentInsetAdjustmentBehavior = .never
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    // MARK: - PROPERTIES
    private var viewModel = HomeScreenViewModel()
    private let disposeBag = DisposeBag()
    private var listActivityGroup: [ActivityGroupViewModel] = []
    private let refreshControl = UIRefreshControl()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
        
        self.title = viewModel.title
        
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
                self?.listActivityGroup = listActivityGroup
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
    
    fileprivate func fetchActivities() {
        viewModel.fetchActivities()
    }
    
}

// MARK: - UITableViewDataSource
extension HomeScreenController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listActivityGroup.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listActivityGroup.isEmpty {
            return 0
        }
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
        
        let nameType = viewModel.getNameType(atSection: section)
        activityHeaderCellView.bindData(nameType)
        return activityHeaderCellView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusable(cellNib: ActivityCell.self, indexPath: indexPath)
        else {
            return UITableViewCell()
        }
        
        let activityGroupViewModel = listActivityGroup[indexPath.section]
        let activityViewModel = activityGroupViewModel.getActivity(atIndex: indexPath.row)
        cell.bindData(activityViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeScreenController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected at index: ", indexPath.row)
    }
}
