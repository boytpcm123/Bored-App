//
//  MockData.swift
//  BoredAppTests
//
//  Created by hungdat1234 on 4/1/22.
//

import Foundation

@testable import BoredApp

enum MockData {
    
    static var JSONData: [[String: Any?]?] {
        let JSONData: [[String: Any?]?] = [
            [
                "activity": "Visit a nearby museum",
                "type": "recreational",
                "participants": 1,
                "price": 0.2,
                "link": "",
                "key": "5490351",
                "accessibility": 0.7
            ]
        ]
        
        return JSONData
    }
    
    static var activityData: [ActivityModel] {
        let activity1 = ActivityModel(activity: "Activity 1",
                                      type: "Type 1",
                                      participants: 1,
                                      price: 1.0,
                                      link: "Link 1",
                                      key: "Key 1",
                                      accessibility: 1.0)
        
        let activity2 = ActivityModel(activity: "Activity 2",
                                      type: "Type 2",
                                      participants: 2,
                                      price: 2.0,
                                      link: "Link 2",
                                      key: "Key 2",
                                      accessibility: 2.0)
        
        let activity3 = ActivityModel(activity: "Activity 3",
                                      type: "Type 3",
                                      participants: 3,
                                      price: 3.0,
                                      link: "Link 3",
                                      key: "Key 3",
                                      accessibility: 3.0)
        
        return [activity1, activity2, activity3]
    }
    
    static var activityTypeSettingDate: [ActivitySettingViewModel] {
        ActivityType.allCases.map {
            ActivitySettingViewModel(activityType: $0)
        }
    }
}
