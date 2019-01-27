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
        window.backgroundColor = UIColor.white
        let rootVC = UITabBarController()
        
        let feature = UIViewController()
        feature.title = "feature"
        feature.tabBarItem.title = "feature"
        feature.view.backgroundColor = UIColor.gray
        
        let github = UIViewController()
        github.title = "github"
        github.tabBarItem.title = "github"
        github.view.backgroundColor = UIColor.yellow
        
        let Mine = MineViewContoller()
        Mine.title = "Mine"
        Mine.tabBarItem.title = "Mine"
        
        rootVC.viewControllers = [feature, github, Mine]
        rootVC.selectedIndex = 2
        
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = window
        
        home.setup()
    }
    
}
