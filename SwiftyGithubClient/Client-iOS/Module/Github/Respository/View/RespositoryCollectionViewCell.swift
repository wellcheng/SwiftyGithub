//
//  RespositoryCollectionViewCell.swift
//  Client-iOS
//
//  Created by charvel on 2019/2/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class RespositoryCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
