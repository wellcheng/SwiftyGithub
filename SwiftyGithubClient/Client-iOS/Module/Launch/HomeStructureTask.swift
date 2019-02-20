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
    
}

extension HomeStructureTask: BootsTask {
    
    func performTaskWithLaunch(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        // setup main window
        let home = HomeStructure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        let rootVC = UITabBarController()
        
        let feature = DiscoveryViewController()
        feature.title = "Discovery"
        feature.tabBarItem.title = "Discovery"
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
        home.tabBarController = rootVC
    }
    
}
