//
//  UserServices.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Swinject
import RxSwift

public enum ResponseObj<T> {
    case success(T)
    case failure(String)
}

class DI {
    static let container = Container()
}

protocol UITopComponent {
    var topViewController: ViewController {get}
}

class UserServices {
    static let sharedInstance = UserServices()
    
    enum UserLoginState {
        case login
        case logout
    }
    
    var userLoginBehaivor: BehaviorSubject<UserLoginState> = BehaviorSubject(value: .logout)
    
    func isUserLogin() -> Bool {
        return GithubAPIService.sharedInstance.hasAuthorized()
    }
    
    func startLogin() {
        let loginPage = LoginAuthorizeViewController()
        let presenting = DI.container.resolve(UITopComponent.self)?.topViewController
        presenting?.present(loginPage, animated: true, completion: nil)
    }
    
}
