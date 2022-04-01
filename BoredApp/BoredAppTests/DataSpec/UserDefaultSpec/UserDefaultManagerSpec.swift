//
//  UserDefaultManagerSpec.swift
//  BoredAppTests
//
//  Created by hungdat1234 on 4/2/22.
//

import Foundation

import Quick
import Nimble

@testable import BoredApp

class UserDefaultManagerSpec: QuickSpec {
    
    override func spec() {
        
        let userDefaults: UserDefaultManagering = UserDefaultManager()
        
        describe("Test nightMode setting") {
            context("Save a state nightMode to userdefaults") {
                
                let isNightMode = true
                beforeEach {
                    userDefaults.setNightModeSetting(value: isNightMode)
                }
                it("should get status equal isNightMode") {
                    let status = userDefaults.getNightModeSetting()
                    expect(status).to(beTrue())
                }
            }
        }
        
        describe("Test selectAll activity type setting") {
            context("Save a state selectAll to userdefaults") {
                
                let isSelectAll = true
                beforeEach {
                    userDefaults.setSelectAllActivitiesSetting(value: isSelectAll)
                }
                it("should get status equal isSelectAll") {
                    let status = userDefaults.getSelectAllActivitiesSetting()
                    expect(status).to(beTrue())
                }
            }
        }
        
        describe("Test get number request activity setting") {
            context("Save a numRequest to userdefaults") {
                
                let numRequest = 6
                beforeEach {
                    userDefaults.setNumberActivitiesSetting(value: numRequest)
                }
                it("should get value equal numRequest") {
                    let numRequestActivity = userDefaults.getNumberActivitiesSetting()
                    expect(numRequestActivity).to(equal(6))
                }
            }
        }
        
        describe("Test get list type activity setting") {
            context("Save a list activity type to userdefaults") {
                
                beforeEach {
                    userDefaults.setListActivitySetting(value: MockData.activityTypeSettingDate)
                }
                it("should get list equal isSelectAll") {
                    let listActivityType = userDefaults.getListActivitySetting()
                    expect(listActivityType).to(beAKindOf([ActivitySettingViewModel].self))
                    expect(listActivityType.isEmpty).to(beFalse())
                }
            }
        }
    }
}
