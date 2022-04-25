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
    
    // MARK: - PROPERTIES
    private var viewModel: SettingScreenViewModel!
    private var onApplySaveSetting: SettingChanged!
    private let disposeBag = DisposeBag()
    private var listSettingType: [ActivitySettingViewModel] = []
    private var isSettingChanged: Bool = false
    
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
    
    static func instantiate(viewModel: SettingScreenViewModel,
                            onApplySaveSetting: @escaping SettingChanged) -> BaseViewController {
        let controller = SettingScreenController()
        controller.viewModel = viewModel
        controller.onApplySaveSetting = onApplySaveSetting
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindData()
        bindAction()
    }
    
}

// MARK: - SUPPORT FUCTIONS
extension SettingScreenController {
    
    private func setupUI() {
        
        self.isModalInPresentation = true
        
        self.title = viewModel.getTitleScreen()
        
        nightModeSwitch.rx.value.onNext(viewModel.getNightModeSetting())
        sliderActivities.rx.value.onNext(viewModel.getNumberActivities())
        viewModel.getStateSelectAll()
    }
    
    private func bindData() {
        
        viewModel.publishIsSettingChanged
            .subscribe(onNext: {
                self.isSettingChanged = $0
            })
            .disposed(by: disposeBag)
        
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
                        cellType: SettingActivityCell.self
                    )
            ) { _, activitySettingViewModel, cell in
                cell.bindData(activitySettingViewModel)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.modelSelected(ActivitySettingViewModel.self),
                       tableView.rx.itemSelected)
            .bind { [weak self] _, indexPath in
                guard let self = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: true)
                self.viewModel.updateStateSelect(atIndex: indexPath.row, withData: self.listSettingType)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        bindNightModeSwitch()
        bindSliderActivities()
        bindSelectAllTypeSwitch()
        bindApplyChangeBtn()
        bindCloseBtn()
    }
}

// MARK: - SUPPORT FUCTIONS
extension SettingScreenController {
    
    private func bindNightModeSwitch() {
        nightModeSwitch.rx.value
            .changed.subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                
                self.viewModel.saveNightModeValue(withState: value)
                self.updateNightMode()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSliderActivities() {
        sliderActivities.rx.value
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                
                let roundValue = round(value)
                self.numActivitiesLbl.text = "\(Int(roundValue))"
                self.sliderActivities.value = roundValue
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSelectAllTypeSwitch() {
        selectAllTypeSwitch.rx.value
            .changed.subscribe(onNext: { [weak self] value in
                self?.viewModel.updateSelectAllActivityType(value)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindCloseBtn() {
        applyChangeBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.viewModel.saveAllSetting(selectAllState: self.selectAllTypeSwitch.isOn,
                                              numberActivities: self.sliderActivities.value,
                                              listSettingType: self.listSettingType)
                
                self.dismiss(animated: true) {
                    self.onApplySaveSetting(self.isSettingChanged)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindApplyChangeBtn() {
        closeSettingBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
