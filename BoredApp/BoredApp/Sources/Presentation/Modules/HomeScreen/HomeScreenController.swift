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
    
    // MARK: - PROPERTIES
    private var viewModel: HomeScreenViewModel!
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
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

    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

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
    
    private func setupUI() {
        
        self.title = viewModel.getTitleScreen()
        self.emptyTextLbl.text = "Oop! You don't like any activity, right? :((\nPlease try one more time !!!"
        
        tableView.refreshControl = refreshControl
    }
    
    private func bindData() {
        
        refreshControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.fetchActivities()
                HUD.toggleLoading(isLoading: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.showLoading
            .subscribe(onNext: { [weak self] isLoading in
                HUD.toggleLoading(isLoading: isLoading)
                if !isLoading {
                    self?.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.dataList
            .catchAndReturn([])
            .skip(1) // Ignore init empty dataList
            .subscribe(onNext: { [weak self] dataList in
                guard let self = self else { return }
                
                self.tableView.reloadData()
                self.tableView.alpha = dataList.isEmpty ? 0 : 1
            })
            .disposed(by: disposeBag)
        
    }
    
    private func fetchActivities() {
        viewModel.fetchActivities()
    }
    
    private func bindSettingBtn() {
        settingBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }

                let settingChanged: SettingChanged = { settingChanged in
                    guard settingChanged else { return }
                    self.tableView.alpha = 1
                    self.viewModel.fetchActivities()
                }

                self.viewModel.showSetting(settingChanged: settingChanged)
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UITableViewDataSource
extension HomeScreenController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumDataList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumListActivity(at: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 51
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let activityHeaderCellView =
                tableView.dequeueReusableHeaderView(headerNib: ActivityHeaderCellView.self) else {
                    return UIView()
                }
        
        let nameType = viewModel.getNameType(at: section)
        activityHeaderCellView.bindData(nameType)
        return activityHeaderCellView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusable(cellNib: ActivityCell.self, indexPath: indexPath)
        else {
            return UITableViewCell()
        }
        
        let activityViewModel = viewModel.getActivity(at: indexPath)
        cell.bindData(activityViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeScreenController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        viewModel.showDetailActivity(at: indexPath)
    }
}
