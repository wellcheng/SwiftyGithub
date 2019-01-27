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

class UserProfileModel {
    
}

class UserProfileViewModel {
    let bag = DisposeBag()
    
    let accountName: BehaviorSubject<String?>
    let avatarURL: BehaviorSubject<String?>
    let signInBtnVisable: BehaviorSubject<Bool>
    
    required init() {
        signInBtnVisable = BehaviorSubject(value: UserServices.sharedInstance.isUserLogin())
        accountName = BehaviorSubject(value: "Non Account")
        avatarURL = BehaviorSubject(value: nil)
        
        UserServices.sharedInstance.userLoginBehaivor.asObserver().subscribe(onNext: { state in
            if state == .login {
                self.requestUserProfile()
            }
        }).disposed(by: bag)
    }
    
    func setUser(_ user: User) {
        accountName.onNext(user.name)
        avatarURL.onNext(user.avatarURL)
        signInBtnVisable.onNext(true)
    }
    
    func requestUserProfile() {
        GithubAPIService.sharedInstance.getCurrentUser { [weak self] responseObj in
            switch responseObj {
            case .success(let user) :
                self?.setUser(user)
            case .failure(let toast):
                print(toast)
            }
        }
    }

}
