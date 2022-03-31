//
//  HomeScreenViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit
import RxSwift
import Moya

class HomeScreenViewModel {
    
    // MARK: - PROPERTIES
    let title = "Home"
    var listActivityType = ActivityType.allCases
    
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
    
    func getNameType(atSection section: Int) -> String {
        return listActivityType[section].description.capitalized
    }
    
    func fetchActivities() {
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: labelQueue, attributes: .concurrent)
        let dispatchSemaphore = DispatchSemaphore(value: 1)
        
        var listActivityGroup: [ActivityGroupViewModel] = []
        
        for activityType in self.listActivityType {
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
