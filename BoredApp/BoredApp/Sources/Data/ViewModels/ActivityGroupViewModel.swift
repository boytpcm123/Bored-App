//
//  ActivityGroupViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import Foundation

struct ActivityGroupViewModel {
    
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
    
    func getActivity(atIndex index: Int) -> ActivityViewModel {
        let activityModel = activityGroupModel.listActivity[index]
        return ActivityViewModel(activityModel: activityModel)
    }
}
