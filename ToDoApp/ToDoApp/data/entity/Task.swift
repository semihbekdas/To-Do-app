//
//  Task.swift
//  ToDoApp
//
//  Created by semih bekdaş on 10.10.2024.
//

import Foundation

class Task {
    var task_id: Int?
    var task_title: String?
    var task_description: String?
    var task_isCompleted: Int?
    
    init(){
        
    }
    
    init(task_id: Int, task_title: String, task_description: String, task_isCompleted: Int) {
        self.task_id = task_id
        self.task_title = task_title
        self.task_description = task_description
        self.task_isCompleted = task_isCompleted
    }
}
