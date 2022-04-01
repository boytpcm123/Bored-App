//
//  SettingScreenController.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import UIKit
import RxSwift
import RxCocoa

class SettingScreenController: BaseViewController {
    
    static func instantiate() -> BaseViewController {
        let controller = SettingScreenController()
        controller.viewModel = SettingScreenViewModel()
        return controller
    }
    
    // MARK: - OUTLET
    @IBOutlet private weak var nightModeSwitch: UISwitch!
    @IBOutlet private weak var numActivitiesLbl: UILabel!
    @IBOutlet private weak var sliderActivities: UISlider!
    @IBOutlet private weak var selectAllTypeSwitch: UISwitch!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.registerReusedCell(cellNib: SettingActivityCell.self, bundle: nil)
            self.tableView.tableFooterView = UIView()
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    @IBOutlet private weak var applyChangeBtn: UIButton! {
        didSet {
            self.applyChangeBtn.layer.cornerRadius = 16.0
            self.applyChangeBtn.clipsToBounds = true
        }
    }
    @IBOutlet private weak var closeSettingBtn: UIButton!
    
    // MARK: - PROPERTIES
    private var viewModel: SettingScreenViewModel!
    private let disposeBag = DisposeBag()
    private var listSettingType: [ActivitySettingViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindData()
        bindAction()
    }
    
}

// MARK: - SUPPORT FUCTIONS
extension SettingScreenController {
    
    fileprivate func setupUI() {
        
        self.isModalInPresentation = true
        
        self.title = viewModel.getTitleScreen()
        
        nightModeSwitch.rx.value.onNext(viewModel.getNightModeSetting())
        sliderActivities.rx.value.onNext(viewModel.getNumberActivities())
        viewModel.getStateSelectAll()
    }
    
    fileprivate func bindData() {
        
        viewModel.publishIsSelectAll
            .bind(to: selectAllTypeSwitch.rx.value)
            .disposed(by: disposeBag)
        
        viewModel.publishListSettingType
            .subscribe(onNext: {
                self.listSettingType = $0
            })
            .disposed(by: disposeBag)
        
        viewModel.publishListSettingType
            .catchAndReturn([])
            .bind(to:
                    tableView.rx.items(
                        cellIdentifier: SettingActivityCell.dequeueIdentifier,
                        cellType: SettingActivityCell.self)) { _, activitySettingViewModel, cell in
                            cell.bindData(activitySettingViewModel)
                        }
                        .disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.modelSelected(ActivitySettingViewModel.self),
                       tableView.rx.itemSelected)
            .bind { [weak self] _, indexPath in
                guard let self = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: true)
                self.viewModel.updateStateSelect(atIndex: indexPath.row, data: self.listSettingType)
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindAction() {
        bindNightModeSwitch()
        bindSliderActivities()
        bindSelectAllTypeSwitch()
        bindApplyChangeBtn()
        bindCloseBtn()
    }
}

// MARK: - SUPPORT FUCTIONS
extension SettingScreenController {
    
    fileprivate func bindNightModeSwitch() {
        nightModeSwitch.rx.value
            .changed.subscribe(onNext: { value in
                print("night mode ", value ? "true" : "false")
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindSliderActivities() {
        sliderActivities.rx.value
            .subscribe(onNext: { value in
                let roundValue = round(value)
                self.numActivitiesLbl.text = "\(Int(roundValue))"
                self.sliderActivities.value = roundValue
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindSelectAllTypeSwitch() {
        selectAllTypeSwitch.rx.value
            .changed.subscribe(onNext: { [weak self] value in
                self?.viewModel.updateSelectAllActivityType(value)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindCloseBtn() {
        applyChangeBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.saveAllSetting(nightModeState: self.nightModeSwitch.isOn,
                                              selectAllState: self.selectAllTypeSwitch.isOn,
                                              numberActivities: self.sliderActivities.value)
                
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindApplyChangeBtn() {
        closeSettingBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
