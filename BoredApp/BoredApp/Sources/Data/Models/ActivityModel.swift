//
//  ActivityModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import Foundation

enum ActivityType: String, Decodable, CaseIterable {
    
    case education
    case recreational
    case social
    case diy
    case charity
    case cooking
    case relaxation
    case music
    case busywork
    
    var description: String { self.rawValue }
}

struct ActivityModel: Decodable, Hashable {
    
    let activity: String
    let type: String
    let participants: Int
    let price: Double
    let link: String?
    let key: String?
    let accessibility: Double
}
