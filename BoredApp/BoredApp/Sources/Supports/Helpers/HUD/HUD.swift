//
//  HUD.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/25/22.
//

import ProgressHUD

enum HUD {
    static func toggleLoading(isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                ProgressHUD.show()
            } else {
                ProgressHUD.dismiss()
            }
        }
    }
}
