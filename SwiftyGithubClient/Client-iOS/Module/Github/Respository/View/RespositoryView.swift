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
import SnapKit

class RespositoryView: UIView {
    
    var viewModel: RespositoryViewModel
    var collectionView: UICollectionView
    var repositories: [Repository] = []
    
    init(viewModel vm:RespositoryViewModel) {
        self.viewModel = vm
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: .zero)
        
        self.bindViewModel()
        self.setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RespositoryCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RespositoryCollectionViewCell.self))
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    func bindViewModel() {
        _ = viewModel.repositories.observeOn(MainScheduler.asyncInstance).subscribe(onNext: { [weak self] repositories in
            guard let strongSelf = self else {
                return
            }
            strongSelf.repositories = repositories
            strongSelf.collectionView.reloadData()
        })
    }
}

extension RespositoryView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RespositoryCollectionViewCell.self), for: indexPath)
        return cell
        
    }
    
}
