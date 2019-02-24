//
//  RespositoryViewModel.swift
//  Client-iOS
//
//  Created by charvel on 2019/2/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import Octokit

class RespositoryViewModel: UIView {
    
    var repositories: BehaviorSubject<[Repository]> = BehaviorSubject(value:[])

    func updateRespositoryViewWith(repositories res:[Repository]) {
        self.repositories.onNext(res)
    }
}
