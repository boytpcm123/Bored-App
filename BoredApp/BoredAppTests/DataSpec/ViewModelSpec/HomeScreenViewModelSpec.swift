//
//  HomeScreenViewModelSpec.swift
//  BoredAppTests
//
//  Created by hungdat1234 on 4/7/22.
//

import Foundation

import Quick
import Nimble
import RxSwift

@testable import BoredApp

class HomeScreenViewModelSpec: QuickSpec {

    override func spec() {

        let viewModel = HomeScreenViewModel(
            router: AppCoordinator().unownedRouter,
            boredNetworkManager: MockBoredNetworkManager())
        let disposeBag = DisposeBag()

        describe("Text fetch activities") {
            context("test acctivities") {
                beforeEach {}
                it("should get the list activies") {
                    viewModel.dataList
                        .catchAndReturn([])
                        .subscribe(onNext: { listActivityGroup in
                            print(listActivityGroup)
                            expect(listActivityGroup.isEmpty).to(beFalse(), description: "Should have false value")
                        })
                        .disposed(by: disposeBag)
                    viewModel.fetchActivities()
                }
            }
        }
    }
}
