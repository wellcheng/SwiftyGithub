//
//  DiscoveryViewController.swift
//  Client-iOS
//
//  Created by charvel on 2019/2/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController {

    lazy var viewModel = DiscoveryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchRepositories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchRepositories()
    }
}
