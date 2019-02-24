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
import RequestKit

class DiscoveryViewModel {
    
    // read only properties
    
    var repositories: BehaviorSubject<[Repository]> = BehaviorSubject(value:[])
    
    func fetchRepositories() {
        GithubAPIService.sharedInstance.fetchRepositories { [weak self] response in
            switch response {
            case .success(let repositories):
                self?.repositories.onNext(repositories)
            case .failure(let error):
                self?.repositories.onError(error)
            }
        }
    }

}
