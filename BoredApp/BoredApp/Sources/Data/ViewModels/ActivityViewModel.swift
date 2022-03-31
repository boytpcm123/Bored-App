//
//  ActivityViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import Foundation

struct ActivityViewModel {
    
    private let activityModel: ActivityModel
    
    init(activityModel: ActivityModel) {
        self.activityModel = activityModel
    }
}

// MARK: - SUPPORT FUNCTIONS
extension ActivityViewModel {
    
    func getType() -> String {
        return activityModel.type.lowercased()
    }
    
    func getActivity() -> String {
        return activityModel.activity
    }
    
    func getAccessibility() -> String {
        return "\(activityModel.accessibility)"
    }
    
    func getPrice() -> String {
        return "\(activityModel.price)"
    }
    
    func getParticipants() -> String {
        return "\(activityModel.participants)"
    }
    
    func getLink() -> String {
        return activityModel.link ?? ""
    }
    
}
