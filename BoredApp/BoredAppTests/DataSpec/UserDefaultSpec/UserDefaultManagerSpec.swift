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

        var userDefaults: UserDefaultManagerProtocol!
        
        describe("Test nightMode setting") {
            context("Save a state nightMode to userdefaults") {

                beforeEach {
                    userDefaults = MockUserDefaultManager()
                }
                it("should get status equal isNightMode") {
                    let status = userDefaults.getNightModeSetting()
                    expect(status) == true
                }
            }
        }
        
        describe("Test selectAll activity type setting") {
            context("Save a state selectAll to userdefaults") {

                beforeEach {
                    userDefaults = MockUserDefaultManager()
                }
                it("should get status equal isSelectAll") {
                    let status = userDefaults.getSelectAllActivitiesSetting()
                    expect(status) == false
                }
            }
        }
        
        describe("Test get number request activity setting") {
            context("Save a numRequest to userdefaults") {

                beforeEach {
                    userDefaults = MockUserDefaultManager()
                }
                it("should get value equal numRequest") {
                    let numRequestActivity = userDefaults.getNumberActivitiesSetting()
                    expect(numRequestActivity) == 1
                }
            }
        }
        
        describe("Test get list type activity setting") {
            context("Save a list activity type to userdefaults") {
                
                beforeEach {
                    userDefaults = MockUserDefaultManager()
                }
                it("should get list equal isSelectAll") {
                    let listActivityType = userDefaults.getListActivitySetting()
                    expect(listActivityType).to(beAKindOf([ActivitySettingViewModel].self))
                    expect(listActivityType.isEmpty) == true
                }
            }
        }
    }
}
