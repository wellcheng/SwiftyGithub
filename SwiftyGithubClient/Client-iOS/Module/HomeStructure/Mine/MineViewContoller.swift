//
//  MineViewContoller.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift

class MineViewContoller: ViewController {
    
    let bag = DisposeBag()
    lazy var profileHeader = UserProfileHeaderView()
    
    override func viewDidLoad() {
        
        self.view.addSubview(profileHeader)
        profileHeader.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        profileHeader.signInBtn.rx.tap.asObservable().subscribe(onNext: { [weak self] (event) in
            self?.signIn()
        }).disposed(by: profileHeader.bag)
    }
    
    func signIn() {
        if (!UserServices.sharedInstance.isUserLogin()) {
            UserServices.sharedInstance.startLogin()
        }
    }
    
}
