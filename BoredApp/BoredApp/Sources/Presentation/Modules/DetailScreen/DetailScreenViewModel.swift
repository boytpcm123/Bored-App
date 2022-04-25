//
//  DetailScreenViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import Foundation
import XCoordinator

struct DetailScreenViewModel {

    private let router: UnownedRouter<AppRoute>
    private let activityViewModel: ActivityViewModel
    
    init(router: UnownedRouter<AppRoute>,
         activity: ActivityViewModel) {
        self.router = router
        self.activityViewModel = activity
    }
}

// MARK: - PUBLIC FUNCTIONS
extension DetailScreenViewModel {
    
    func getTitleScreen() -> String {
        return self.activityViewModel.getType().capitalized
    }
    
    func getActivity() -> String {
        return self.activityViewModel.getActivity()
    }
    
    func getParticipants() -> String {
        return self.activityViewModel.getParticipants()
    }
    
    func getPrice() -> String {
        return self.activityViewModel.getPrice()
    }
    
    func getAccessibility() -> String {
        return self.activityViewModel.getAccessibility()
    }
    
    func getType() -> String {
        return self.activityViewModel.getType().capitalized
    }
    
    func getLink() -> String {
        let link = self.activityViewModel.getLink()
        return link.isEmpty ? "https://www.google.com" : link
    }
    
    func getURL() -> URL? {
        let url = URL(string: getLink())
        return url
    }
}
