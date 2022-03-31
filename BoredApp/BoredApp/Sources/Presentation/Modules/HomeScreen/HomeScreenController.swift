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
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - SUPPORT FUCTIONS
extension HomeScreenController {
    
    func setupUI() {
        
        self.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

// MARK: - UITableViewDataSource
extension HomeScreenController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.listActivityType.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
        
        let activityModel = ActivityModel(activity: "Conquer one of your fears",
                                          type: ActivityType.recreational,
                                          participants: 1,
                                          price: 0.1,
                                          link: "",
                                          key: "8344539",
                                          accessibility: 0.1)
        let activityViewModel = ActivityViewModel(activityModel: activityModel)
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
