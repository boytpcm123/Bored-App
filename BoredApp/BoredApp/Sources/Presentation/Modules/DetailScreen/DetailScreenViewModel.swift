//
//  DetailScreenViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import Foundation
import XCoordinator

protocol DetailScreenViewModelProtocol {
    
    func getTitleScreen() -> String
    func getActivity() -> String
    func getParticipants() -> String
    func getPrice() -> String
    func getAccessibility() -> String
    func getType() -> String
    func getLink() -> String
    func getURL() -> URL?
}

struct DetailScreenViewModel: DetailScreenViewModelProtocol {

    private let router: UnownedRouter<AppRoute>
    private let activityViewModel: ActivityViewModelProtocol
    
    init(router: UnownedRouter<AppRoute>,
         activity: ActivityViewModelProtocol) {
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
