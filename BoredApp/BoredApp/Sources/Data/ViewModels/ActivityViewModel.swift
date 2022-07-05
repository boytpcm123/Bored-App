//
//  ActivityViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import Foundation

protocol ActivityViewModelProtocol {

    func getType() -> String
    func getActivity() -> String
    func getAccessibility() -> String
    func getPrice() -> String
    func getParticipants() -> String
    func getLink() -> String
}

struct ActivityViewModel: ActivityViewModelProtocol {
    
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
