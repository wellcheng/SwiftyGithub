//
//  GithubAPIService.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Alamofire

class GithubAPIService {
    
    static let sharedInstance = GithubAPIService()
    
    var clientID: String = "6bf89326e90cd2877ad8"
    var clientSecret: String = "4eada6b5da8948428fd795cad047f6355627b29f"
    
    
    func hasAuthorized() -> Bool {
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        return accessToken != nil
    }
    
    func fetchUserToken(completionHandler: @escaping (String?) -> Void) {
        if let token = UserDefaults.standard.string(forKey: "user_token") {
            completionHandler(token)
            return
        }
        
        // start login
        
    }
    
    func getOauthTokenURL() -> URL {
        let scope = "repo,user"
        let authPath:String = "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=\(scope)"
        return NSURL(string: authPath) as! URL
    }
    
    func startOauth2Authorize() {
        
        
    }

}
