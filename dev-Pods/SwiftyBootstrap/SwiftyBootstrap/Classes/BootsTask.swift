//
//  BootsTask.swift
//  Pods
//
//  Created by charvel on 2019/1/26.
//

import Foundation

public protocol BootsTask {
    func performTaskWithLaunch(launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    
}

public class BootsTaskContainer {
    
    var tasks = [BootsTask]()
    
    public func didFinishLaunchingWithOptions(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        for task in tasks {
            task.performTaskWithLaunch(launchOptions: launchOptions)
        }
    }
    
    public func scheduleTask(task: BootsTask) {
        tasks.append(task)
    }
}
