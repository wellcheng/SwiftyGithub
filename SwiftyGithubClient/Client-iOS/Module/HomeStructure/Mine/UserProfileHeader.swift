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
import Kingfisher

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
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        //
        self.addSubview(avatarImage)
        avatarImage.backgroundColor = UIColor.yellow
        avatarImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 110, height: 110))
            make.leading.top.equalToSuperview().offset(16)
        }
        
        self.addSubview(nameLabel)
        nameLabel.text = "name label"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImage.snp.top)
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
        }
        
        self.addSubview(nickNameLabel)
        nickNameLabel.text = "nickNameLabel"
        nickNameLabel.font = UIFont.systemFont(ofSize: 14)
        nickNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
        }
        
        self.addSubview(signInBtn)
        signInBtn.setTitle("Sign In", for: .normal)
        signInBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        // detail stack view
        let detailViews = [companyItemView, locationItemView, emailItemView, personSiteItemView]
        let _ = detailViews.map {
            $0.setTitleColor(UIColor(red: 36/255.0, green: 41/255.0, blue: 46/255.0, alpha: 1.0), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        let stackView = UIStackView(arrangedSubviews: detailViews)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nickNameLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(4*20+3*8)
        }
        
    }
    
    func bindViewModel() {
        viewModel.signInBtnVisable.bind(to: signInBtn.rx.isHidden).disposed(by: bag)
        
        viewModel.loginUser.observeOn(MainScheduler.instance).filterNil().subscribe(onNext: { [weak self] (user) in
            self?.nameLabel.text = user.name
            self?.nickNameLabel.text = user.login
            self?.companyItemView.setTitle(user.company, for: .normal)
            self?.locationItemView.setTitle(user.location, for: .normal)
            self?.emailItemView.setTitle(user.email, for: .normal)
            self?.personSiteItemView.setTitle(user.blog, for: .normal)
            
            if let url = user.avatarURL, let imageURL = URL(string: url) {
                self?.avatarImage.kf.setImage(with: imageURL)
            }
        }).disposed(by: bag)
    }
    
    
}
