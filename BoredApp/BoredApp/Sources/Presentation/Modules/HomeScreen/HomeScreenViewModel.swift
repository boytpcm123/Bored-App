//
//  HomeScreenViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import Foundation
import RxSwift

struct HomeScreenViewModel {
    
    // MARK: - PROPERTIES
    private let disposeBag = DisposeBag()
    private let boredNetworkManager: BoredNetworkManagerProtocol
    private let labelQueue = "com.thong.BoredApp.queue"
    
    let publishListActivityGroup = PublishSubject<[ActivityGroupViewModel]>()
    let showLoading = BehaviorSubject<Bool>(value: true)
    
    init(boredNetworkManager: BoredNetworkManagerProtocol = BoredNetworkManager()) {
        self.boredNetworkManager = boredNetworkManager
    }
}

// MARK: - PUBLIC FUNCTIONS
extension HomeScreenViewModel {
    
    func getTitleScreen() -> String {
        return "Are you bored?"
    }
    
    func getNameType(with listActivityGroup: [ActivityGroupViewModel], atSection section: Int) -> String {
        let activityGroupViewModel = listActivityGroup[section]
        return activityGroupViewModel.getTypeActivity()
    }
    
    func getActivityViewModel(with listActivityGroup: [ActivityGroupViewModel],
                              indexPath: IndexPath) -> ActivityViewModel {
        
        let activityGroupViewModel = listActivityGroup[indexPath.section]
        let activityViewModel = activityGroupViewModel.getActivity(atIndex: indexPath.row)
        return activityViewModel
    }
    
    func fetchActivities() {
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: labelQueue, attributes: .concurrent)
        let dispatchSemaphore = DispatchSemaphore(value: 1)
        
        let listActivityType = ActivityType.allCases
        var listActivityGroup: [ActivityGroupViewModel] = []
        
        for activityType in listActivityType {
            dispatchGroup.enter()
            var setActivity: [ActivityModel] = []
            
            dispatchQueue.async {
                // print("Check calling ", activityType)
                for index in 0..<Constants.limitActivity {
                    self.boredNetworkManager
                        .getActivity(withType: activityType)
                        .subscribe( onSuccess: {
                            setActivity.append($0)
                            if setActivity.count == Constants.limitActivity {
                                let activityGroupViewModel = self.convertSetList(activityType: activityType,
                                                                                 setActivity: setActivity)
                                listActivityGroup.append(activityGroupViewModel)
                                dispatchGroup.leave()
                            }
                        }, onFailure: { error in
                            print("error ", error.localizedDescription, activityType)
                            // Check prevent error when some activity change type
                            if index == Constants.limitActivity - 1 {
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
            self.publishListActivityGroup.onNext(listActivityGroup)
            self.showLoading.onNext(false)
        }
    }
}

// MARK: - SUPPORT FUNCTIONS
extension HomeScreenViewModel {
    
    fileprivate func convertSetList(activityType: ActivityType, setActivity: [ActivityModel]) -> ActivityGroupViewModel {
        
        // var listActivity: [ActivityModel] = Array(setActivity)
        let listActivity = setActivity.sorted { $0.accessibility < $1.accessibility }
        let activityGroupModel = ActivityGroupModel(
            activityType: activityType, listActivity: listActivity)
        let activityGroupViewModel = ActivityGroupViewModel(activityGroupModel: activityGroupModel)
        return activityGroupViewModel
    }
}
