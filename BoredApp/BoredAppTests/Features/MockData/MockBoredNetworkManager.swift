//
//  MockBoredNetworkManager.swift
//  BoredAppTests
//
//  Created by hungdat1234 on 4/7/22.
//

import Foundation
import RxSwift
@testable import BoredApp

struct MockBoredNetworkManager: BoredNetworkManagerProtocol {
    
    let disposeBag = DisposeBag()
    
    func getActivity(withType type: ActivityType) -> Single<ActivityModel> {
        
        return Single.create { single in
            single(.success(MockData.activity))
            return Disposables.create()
        }
    }
}
