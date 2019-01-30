//
//  UserProfileViewModel.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import RxSwift
import Alamofire
import Octokit
import RxOptional

class UserProfileViewModel {
    let bag = DisposeBag()
    
    let signInBtnVisable: BehaviorSubject<Bool>
    let loginUser: BehaviorSubject<User?> = BehaviorSubject(value: nil)
    
    required init() {
        signInBtnVisable = BehaviorSubject(value: UserServices.sharedInstance.isUserLogin())
        UserServices.sharedInstance.userLoginBehaivor.asObserver().subscribe(onNext: { state in
            if state == .login {
                self.requestUserProfile()
            }
        }).disposed(by: bag)
    }
    /*
     ObjectiveC.NSObject    NSObject
     id    Int    7522857
     login    String?    "wellcheng"    some
     avatarURL    String?    "https://avatars3.githubusercontent.com/u/7522857?v=4"    some
     gravatarID    String?    ""    some
     type    String?    "User"    some
     name    String?    "成伟"    some
     company    String?    "Baidu"    some
     blog    String?    "blog.devcheng.com"    some
     location    String?    "Beijing"    some
     email    String?    "chengwei3269@hotmail.com"    some
     numberOfPublicRepos    Int?    37
     numberOfPublicGists    Int?    19
     numberOfPrivateRepos    Int?    0
     */
    func requestUserProfile() {
        GithubAPIService.sharedInstance.getCurrentUser { [weak self] responseObj in
            switch responseObj {
            case .success(let user) :
                self?.loginUser.onNext(user)
            case .failure(let toast):
                print(toast)
            }
        }
    }

}
