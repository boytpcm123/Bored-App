//
//  ActivityModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import Foundation

enum ActivityType: String, Codable, CaseIterable {
    
    case education
    case recreational
    case social
    case diy
    case charity
    case cooking
    case relaxation
    case music
    case busyWork
    
    var description: String { self.rawValue.lowercased() }
}

struct ActivityModel: Decodable {
    
    let activity: String
    let type: String
    let participants: Int
    let price: Double
    let link: String?
    let key: String?
    let accessibility: Double
}
