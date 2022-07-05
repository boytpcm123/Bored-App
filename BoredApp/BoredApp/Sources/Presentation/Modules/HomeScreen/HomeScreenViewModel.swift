//
//  HomeScreenViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import Foundation
import RxSwift
import RxCocoa
import XCoordinator

protocol HomeScreenViewModelProtocol {
    
    var dataList: BehaviorRelay<[ActivityGroupViewModelProtocol]> { get }
    var showLoading: BehaviorSubject<Bool> { get }

    func getTitleScreen() -> String
    func getNumDataList() -> Int
    func getNumListActivity(at section: Int) -> Int
    func getNameType(at section: Int) -> String
    func getActivity(at indexPath: IndexPath) -> ActivityViewModelProtocol
    func fetchActivities()
    func showSetting(settingChanged: @escaping SettingChanged)
    func showDetailActivity(at indexPath: IndexPath)
}

struct HomeScreenViewModel: HomeScreenViewModelProtocol {
    
    // MARK: - PROPERTIES
    private let router: UnownedRouter<AppRoute>
    private let userDefaults: UserDefaultManagerProtocol
    private let disposeBag = DisposeBag()
    private let boredNetworkManager: BoredNetworkManagerProtocol
    private let labelQueue = "com.thong.BoredApp.queue"
    
    var dataList = BehaviorRelay(value: [ActivityGroupViewModelProtocol]())
    let showLoading = BehaviorSubject<Bool>(value: true)
    
    init(router: UnownedRouter<AppRoute>,
         boredNetworkManager: BoredNetworkManagerProtocol = BoredNetworkManager(),
         userDefaults: UserDefaultManagerProtocol = UserDefaultManager()) {
        self.router = router
        self.boredNetworkManager = boredNetworkManager
        self.userDefaults = userDefaults
    }
}

// MARK: - PUBLIC FUNCTIONS
extension HomeScreenViewModel {
    
    func getTitleScreen() -> String {
        return "Are you bored?"
    }

    func getNumDataList() -> Int {
        return dataList.value.count
    }

    func getNumListActivity(at section: Int) -> Int {
        let activityGroup = dataList.value[section]
        return activityGroup.getLengthListActivity()
    }
    
    func getNameType(at section: Int) -> String {
        let activityGroup = dataList.value[section]
        return activityGroup.getTypeActivity()
    }
    
    func getActivity(at indexPath: IndexPath) -> ActivityViewModelProtocol {
        
        let activityGroup = dataList.value[indexPath.section]
        let activity = activityGroup.getActivity(atIndex: indexPath.row)
        return activity
    }
    
    func fetchActivities() {
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: labelQueue, attributes: .concurrent)
        let dispatchSemaphore = DispatchSemaphore(value: 1)
        
        var listActivityGroup: [ActivityGroupViewModelProtocol] = []
        let maxActivities: Int = getSettingNumActivities()
        let listActivityType: [ActivityType] = getActivityType()
        
        self.showLoading.onNext(!listActivityType.isEmpty)
        
        for activityType in listActivityType {
            dispatchGroup.enter()
            var setActivity: [ActivityModel] = []
            
            dispatchQueue.async {
                // print("Check calling ", activityType)
                for index in 0..<maxActivities {
                    self.boredNetworkManager
                        .getActivity(withType: activityType)
                        .subscribe( onSuccess: {
                            setActivity.append($0)
                            if setActivity.count == maxActivities {
                                let activityGroupViewModel = self.convertSetList(activityType: activityType,
                                                                                 setActivity: setActivity)
                                listActivityGroup.append(activityGroupViewModel)
                                dispatchGroup.leave()
                            }
                        }, onFailure: { error in
                            print("error ", error.localizedDescription, activityType)
                            // Check prevent error when some activity change type
                            if index < maxActivities {
                                dispatchGroup.leave()
                            }
                        }, onDisposed: {
                            dispatchSemaphore.signal()
                        })
                        .disposed(by: self.disposeBag)
                    dispatchSemaphore.wait()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Finished ", listActivityGroup.count)
            self.dataList.accept(listActivityGroup)
            self.showLoading.onNext(false)
        }
    }

    func showSetting(settingChanged: @escaping SettingChanged) {
        self.router.trigger(.setting(settingChanged))
    }

    func showDetailActivity(at indexPath: IndexPath) {
        let activity = getActivity(at: indexPath)
        self.router.trigger(.detail(activity))
    }
}

// MARK: - SUPPORT FUNCTIONS
extension HomeScreenViewModel {
    
    private func convertSetList(activityType: ActivityType, setActivity: [ActivityModel]) -> ActivityGroupViewModelProtocol {
        
        let listActivity = setActivity.sorted { $0.accessibility < $1.accessibility }
        let activityGroupModel = ActivityGroupModel(
            activityType: activityType, listActivity: listActivity)
        let activityGroupViewModel = ActivityGroupViewModel(activityGroupModel: activityGroupModel)
        return activityGroupViewModel
    }
    
    private func getSettingNumActivities() -> Int {
        return userDefaults.getNumberActivitiesSetting()
    }
    
    private func getActivityType() -> [ActivityType] {
        let listSettingType: [ActivitySettingViewModel] = userDefaults.getListActivitySetting()
        let listActivityType: [ActivityType] = listSettingType
            .filter { $0.getStateSelected() }
            .map { $0.getActivityType() }
        return listActivityType
    }
}
