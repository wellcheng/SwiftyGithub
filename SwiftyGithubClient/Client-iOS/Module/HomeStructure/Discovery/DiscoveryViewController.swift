
//
//  DiscoveryViewController.swift
//  Client-iOS
//
//  Created by charvel on 2019/2/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Octokit
import SnapKit

class DiscoveryViewController: UIViewController {

    lazy var viewModel = DiscoveryViewModel()
    
    // Respository
    var respositoryView: RespositoryView?
    var respositoryViewModel: RespositoryViewModel?
    
    // Models
    var repositories:[Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRespositoryView()
        self.bindModels()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchRepositories()
    }
    
    func setupRespositoryView() {
        respositoryViewModel = RespositoryViewModel()
        guard let vm = respositoryViewModel else {
            return
        }
        respositoryView = RespositoryView(viewModel: vm)
        guard let respositoryView = respositoryView else {
            return
        }
        view.addSubview(respositoryView)
        respositoryView.backgroundColor = .gray
        respositoryView.snp.makeConstraints { (make) in
            make.leading.top.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            make.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-8)
        }

    }
    
    func bindModels() {
        _ = viewModel.repositories.subscribe(onNext: { [weak self] repositories in
            self?.updateRespositoryViewWith(res: repositories)
        }, onError: { error in
            
        }, onCompleted: nil, onDisposed: nil)
    }
    
    func updateRespositoryViewWith(res repositories:[Repository]) {
        self.respositoryViewModel?.updateRespositoryViewWith(repositories: repositories)
    }
}
