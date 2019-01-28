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
import Octokit
import SVProgressHUD

class LoginAuthorizeViewController: ViewController {
    
    let disposeBag = DisposeBag()
    var authWebView: WKWebView?
    
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
            self?.dismissSelf()
        }).disposed(by: disposeBag)
    }
    
    func openLoginWeb() {
        let webview = WKWebView()
        webview.navigationDelegate = self
        self.view.addSubview(webview)
        webview.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(140.0)
        }
        if let oauthStep1URL = GithubAPIService.sharedInstance.config.authenticate() {
            let authReq = URLRequest(url: oauthStep1URL)
            webview.load(authReq)
        }
        self.authWebView = webview
    }
    
    func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveToken(token: String, callbackURL: URL) {
        SVProgressHUD.show()
        UserDefaults.standard.set(token, forKey: "user_token")
        self.authWebView?.removeFromSuperview()
        self.authWebView = nil
        GithubAPIService.sharedInstance.handleGithubCallbackURL(callbackURL) { [weak self] in
            SVProgressHUD.dismiss()
            self?.dismissSelf()
        }
    }
    
}

extension LoginAuthorizeViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if  let reqURL = navigationAction.request.url,
            let components = URLComponents(string: reqURL.absoluteString),
            let host = components.host,
            let queryItems = components.queryItems,
            host == "nsstring.com"
        {
            for queryItem in queryItems {
                if let token = queryItem.value, queryItem.name == "code" {
                    self.saveToken(token: token, callbackURL: reqURL)
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
    
}
