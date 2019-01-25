//
//  HomeStructureTask.swift
//  Client-iOS
//
//  Created by charvel on 2019/1/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyBootstrap

class HomeStructureTask {
    public func setup () {
        
    }
}

extension HomeStructureTask: BootsTask {
    
    func performTaskWithLaunch(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        // setup main window
        let home = HomeStructureTask()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = UITabBarController()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = window
        
        home.setup()
    }
    
}
