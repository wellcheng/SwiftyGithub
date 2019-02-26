//
//  RespositoryView.swift
//  Client-iOS
//
//  Created by charvel on 2019/2/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import Octokit

class RespositoryView: UIView {
    
    var viewModel: RespositoryViewModel
    var collectionView: UICollectionView?
    var repositories: [Repository] = []
    
    init(vm viewModel:RespositoryViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.bindViewModel()
        self.setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.dataSource = self as! UICollectionViewDataSource
        collectionView?.delegate = self as! UICollectionViewDelegate
    }
    
    func bindViewModel() {
        viewModel.repositories.subscribeOn(MainScheduler.instance).subscribe(onNext: { [weak self] repositories in
            self?.repositories = repositories
            self?.collectionView?.reloadData()
        })
    }
    
    
}
