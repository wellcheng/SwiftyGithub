//
//  GithubAPIService.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Alamofire
import Octokit

class GithubAPIService {
    
    static let sharedInstance = GithubAPIService()
    
    var config: OAuthConfiguration
    var accessTokenConf: TokenConfiguration
    var clientID: String = "6bf89326e90cd2877ad8"
    var clientSecret: String = "4eada6b5da8948428fd795cad047f6355627b29f"
    
    init() {
        
        config = OAuthConfiguration(token: clientID, secret: clientSecret, scopes: ["repo", "user"])
        
        let accessToken = UserDefaults.standard.string(forKey: "accessToken")
        if let apiEndpoint = UserDefaults.standard.string(forKey: "apiEndpoint") {
            accessTokenConf = TokenConfiguration(accessToken, url: apiEndpoint)
        } else {
            accessTokenConf = TokenConfiguration(accessToken)
        }
        if let _ = accessToken {
            UserServices.sharedInstance.userLoginBehaivor.onNext(.login)
        } else {
            UserServices.sharedInstance.userLoginBehaivor.onNext(.logout)
        }
    }
    
    func hasAuthorized() -> Bool {
        return accessTokenConf.accessToken != nil
    }
    
    func handleGithubCallbackURL(_ callbackURL: URL, completion:@escaping (() -> Void)) {
        config.handleOpenURL(url: callbackURL) { accessToken in
            UserDefaults.standard.set(accessToken.apiEndpoint, forKey: "apiEndpoint")
            UserDefaults.standard.set(accessToken.accessToken, forKey: "accessToken")
            self.accessTokenConf = accessToken
            UserServices.sharedInstance.userLoginBehaivor.onNext(.login)
            completion()
        }

    }
    
    //
    func getCurrentUser(completion: @escaping (_ response: ResponseObj<User>) -> Void) {
        Octokit(accessTokenConf).me { response in
            switch response {
            case .success(let user):
                print(user)
                completion(ResponseObj.success(user))
            case .failure(let error):
                print(error)
                completion(ResponseObj.failure(error.localizedDescription))
            }
        }?.resume()
    }
    
    
    func fetchRepositories() {
        Octokit(accessTokenConf).repositories { response in
            print(response)
        }
    }

}
