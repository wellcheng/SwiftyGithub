//
//  UserProfileHeader.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SwiftyGithub

internal class UserProfileHeaderView: UIView {
    
    let bag = DisposeBag()
    lazy var viewModel = UserProfileViewModel()
    
    lazy var avatarImage = UIImageView()
    lazy var nameLabel = UILabel()
    lazy var nickNameLabel = UILabel()
    lazy var statusTextView = UITextView()
    
    // details
    lazy var companyItemView = UIButton()
    lazy var locationItemView = UIButton()
    lazy var emailItemView = UIButton()
    lazy var personSiteItemView = UIButton()
    
    lazy var signInBtn = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        //
        self.addSubview(avatarImage)
        avatarImage.backgroundColor = UIColor.yellow
        avatarImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 110, height: 110))
            make.leading.top.equalToSuperview().offset(16)
        }
        
        self.addSubview(nameLabel)
        nameLabel.text = "name label"
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImage.snp.top)
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
        }
        
        
        self.addSubview(signInBtn)
//        signInBtn.setTitleColor(UIColor.blue, for: .normal)
        signInBtn.setTitle("Sign In", for: .normal)
        signInBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        
        viewModel.accountName.bind(to: nameLabel.rx.text).disposed(by: bag)
        
        viewModel.userToken.subscribe({ [weak self] event in
            let token = event.element ?? ""
            print("token:\(token)")
            self?.signInBtn.isHidden = token!.count > 0
        }).disposed(by: bag)
    }
    
    
}
