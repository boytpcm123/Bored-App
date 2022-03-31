//
//  HomeScreenViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit

struct HomeScreenViewModel {
    
    let title = "Home"
    
    var listActivityType = ActivityType.allCases
    
    func getNameType(atSection section: Int) -> String {
        return listActivityType[section].description.capitalized
    }
}
