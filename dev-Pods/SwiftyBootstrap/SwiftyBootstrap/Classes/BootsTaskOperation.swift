//
//  BootsTaskOperation.swift
//  Pods
//
//  Created by charvel on 2019/1/26.
//

import Foundation

class BootsTaskOperation: Operation {
    
    var lanuchTasks = [BootsTask]()
    
//    - (instancetype)initWithTask:(Class<IESTask>)task launchContext:(IESLaunchContext *)launchContext;
    public init(tasks: [BootsTask]) {
        lanuchTasks = tasks
    }
}
