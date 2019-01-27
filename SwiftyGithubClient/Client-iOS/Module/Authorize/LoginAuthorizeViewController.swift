//
//  LoginAuthorizeViewController.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import SnapKit
import RxCocoa
import RxSwift

class LoginAuthorizeViewController: ViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setupUI()
        self.view.backgroundColor = UIColor.lightGray
    }
    
    func setupUI() {
        //
        let loginBtn = UIButton(type: .system)
        loginBtn.setTitle("Login", for: .normal)
        self.view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.leading.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }
        
        let dismissBtn = UIButton(type: .system)
        dismissBtn.setTitle("Dismiss", for: .normal)
        self.view.addSubview(dismissBtn)
        dismissBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
        }
        
        loginBtn.rx.tap.subscribe(onNext: {[weak self] in
            self?.openLoginWeb()
        }).disposed(by: disposeBag)
        
        dismissBtn.rx.tap.subscribe(onNext: {[weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
    }
    
    func openLoginWeb() {
        let authWebView = WKWebView()
        authWebView.navigationDelegate = self
        self.view.addSubview(authWebView)
        authWebView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(140.0)
        }
        
        let authURL = URL(string: "https://github.com/login/oauth/authorize?scope=user:email&client_id=6bf89326e90cd2877ad8")
        let authReq = URLRequest(url: authURL!)
        authWebView.load(authReq)
    }
    
    func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: "user_token")
        let noti = Notification(name: .TokenChanged, object: token, userInfo: nil)
        NotificationCenter.default.post(noti)
    }
    
}

extension Notification.Name {
    static let TokenChanged = Notification.Name("TokenChanged")
}


extension LoginAuthorizeViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("decidePolicyFor navigationAction:\n\(navigationAction)")
        
        if  let reqURL = navigationAction.request.url,
            let components = URLComponents(string: reqURL.absoluteString),
            let host = components.host,
            let queryItems = components.queryItems,
            host == "nsstring.com"
        {
            for queryItem in queryItems {
                if let token = queryItem.value, queryItem.name == "code" {
                    self.saveToken(token: token)
                    decisionHandler(.cancel)
                    return
                }
            }
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("decidePolicyFor navigationResponse:\n\(navigationResponse)")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation:\n\(navigation)")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation:\n\(String(describing: navigation))")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation:\n\(navigation) \nError:\(error)")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish:\n\(navigation)")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail:\n\(navigation) \nwithError:\(error)")
    }
}
