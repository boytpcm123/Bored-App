//
//  ActivityGroupViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import Foundation

protocol ActivityGroupViewModelProtocol {

    func getTypeActivity() -> String
    func getLengthListActivity() -> Int
    func getActivity(atIndex index: Int) -> ActivityViewModelProtocol
}

struct ActivityGroupViewModel: ActivityGroupViewModelProtocol {
    
    private let activityGroupModel: ActivityGroupModel
    
    init(activityGroupModel: ActivityGroupModel) {
        self.activityGroupModel = activityGroupModel
    }
}

// MARK: - SUPPORT FUNCTIONS
extension ActivityGroupViewModel {
    
    func getTypeActivity() -> String {
        return activityGroupModel.activityType.description.capitalized
    }
    
    func getLengthListActivity() -> Int {
        return activityGroupModel.listActivity.count
    }
    
    func getActivity(atIndex index: Int) -> ActivityViewModelProtocol {
        let activityModel = activityGroupModel.listActivity[index]
        return ActivityViewModel(activityModel: activityModel)
    }
}
