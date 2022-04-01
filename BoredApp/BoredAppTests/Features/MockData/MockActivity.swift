//
//  MockActivity.swift
//  BoredAppTests
//
//  Created by hungdat1234 on 4/1/22.
//

import Foundation

@testable import BoredApp

struct MockActivityJSON {
    static var data: [[String: Any?]?] {
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
}
