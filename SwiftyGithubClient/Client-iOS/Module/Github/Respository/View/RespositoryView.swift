//
//  RespositoryView.swift
//  Client-iOS
//
//  Created by charvel on 2019/2/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class RespositoryView: UIView {
    
    var viewModel: RespositoryViewModel
    
    init(vm viewModel:RespositoryViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
