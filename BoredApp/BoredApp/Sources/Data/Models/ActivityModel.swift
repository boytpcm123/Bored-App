//
//  ActivityModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import Foundation

enum ActivityType: String, Decodable {
    
    case education
    case recreational
    case social
    case diy
    case charity
    case cooking
    case relaxation
    case music
    case busyWork
}

struct ActivityModel: Decodable {
    
    let activity: String
    let type: ActivityType
    let participants: Int
    let price: Double
    let link: String?
    let key: String?
    let accessibility: Double
}
