//
//  HomeStructure.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Swinject

class HomeStructure {
    public var tabBarController: UITabBarController? 
    
    public func setup () {
        DI.container.register(UITopComponent.self) { _ in self }
    }
}

extension HomeStructure: UITopComponent {
    var topViewController: ViewController {
        if let top = tabBarController {
            return top.selectedViewController as! ViewController
        }
        let appDelagate = UIApplication.shared.delegate
        return appDelagate?.window!!.rootViewController as! ViewController
    }
    
}
