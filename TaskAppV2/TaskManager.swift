//
//  TaskManager.swift
//  TaskAppV2
//
//  Created by Ryan Rudzitis on 2015-05-07.
//  Copyright (c) 2015 Ryan Rudzitis. All rights reserved.
//

import UIKit

var taskMgr :TaskManager = TaskManager()

struct taskStruct {
    var name = "Unnamed name"
    var desc = "Unnamed desc"
}


class TaskManager: NSObject {
    var tasksArray = [taskStruct]()
    
    func addTask(name: String, desc: String) {
        tasksArray.append(taskStruct(name: name, desc: desc))
    }
   
}
