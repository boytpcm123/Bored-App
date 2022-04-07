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

        let viewModel = HomeScreenViewModel(boredNetworkManager: MockBoredNetworkManager())
        let disposeBag = DisposeBag()

        describe("Text fetch activities") {
            context("test acctivities") {
                beforeEach {}
                it("should get the list activies") {
                    viewModel.publishListActivityGroup
                        .catchAndReturn([])
                        .subscribe(onNext: { listActivityGroup in
                            print(listActivityGroup)
                            expect(listActivityGroup.isEmpty).to(beFalse())
                        })
                        .disposed(by: disposeBag)
                    viewModel.fetchActivities()
                }
            }
        }
    }
}
