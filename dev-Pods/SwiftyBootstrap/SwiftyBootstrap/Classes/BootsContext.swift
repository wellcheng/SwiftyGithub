//
//  BootsContext.swift
//  Pods
//
//  Created by charvel on 2019/1/26.
//

import Foundation


public class BootsContext {
    
    static let instance: BootsContext = BootsContext()
    public class func shared() -> BootsContext {
        return instance
    }
    
    public var taskContainer = BootsTaskContainer()
}
