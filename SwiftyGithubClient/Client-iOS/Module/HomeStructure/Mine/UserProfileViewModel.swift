//
//  UserProfileViewModel.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import RxSwift
import Alamofire

class UserProfileModel {
    
}

class UserProfileViewModel {
    
    let accountName: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    let avatarURL: BehaviorSubject<URL?> = BehaviorSubject(value: nil)
    let userToken: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    
    required init() {
        
        userToken.onNext(UserDefaults.standard.object(forKey: "user_token") as? String)
        accountName.onNext("Non Account")
        
        NotificationCenter.default.addObserver(self, selector: #selector(tokenChanged(_:)), name: .TokenChanged, object: nil)
    }
    
    @objc func tokenChanged(_ notification: Notification) {
        let token = notification.object as? String
        userToken.onNext(token)
        if let token = token {
            self.requestUserProfileWith(token)
        }
    }
    
    func requestUserProfileWith(_ token:String) {
        

    }

}
