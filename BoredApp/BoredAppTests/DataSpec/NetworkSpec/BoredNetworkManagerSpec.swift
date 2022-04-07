//
//  BoredNetworkManagerSpec.swift
//  BoredAppTests
//
//  Created by hungdat1234 on 4/2/22.
//

import Foundation
import Quick
import Nimble
import RxSwift

@testable import BoredApp

class BoredNetworkManagerSpec: QuickSpec {
    
    override func spec() {

        let boredNetworkManager: BoredNetworkManagerProtocol = BoredNetworkManager()
        let disposeBag = DisposeBag()
        
        describe("Get single activity") {
            context("and the network is established") {
                beforeEach {}
                it("should get the single ActivityModel") {
                    waitUntil { done in
                        boredNetworkManager
                            .getActivity(withType: ActivityType.relaxation)
                            .subscribe( onSuccess: {
                                expect($0).to(beAKindOf(ActivityModel.self))
                            }, onFailure: { error in
                                expect(error)
                                    .to(raiseException(),
                                        description: "Fetch activity fail and call API error, need check again")
                            }, onDisposed: {
                                done()
                            })
                            .disposed(by: disposeBag)
                    }
                }
            }
        }
    }
}
