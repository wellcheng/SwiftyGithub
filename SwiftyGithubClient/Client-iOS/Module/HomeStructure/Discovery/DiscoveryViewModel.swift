//
//  DiscoveryViewModel.swift
//  Client-iOS
//
//  Created by charvel on 2019/2/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import RxOptional
import RxSwift
import Octokit

class DiscoveryViewModel {
    
    var signInBtnVisable: BehaviorSubject<[Repository]> = BehaviorSubject(value: [])
    
    func fetchRepositories() {
        GithubAPIService.sharedInstance.fetchRepositories()
    }

}
