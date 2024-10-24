//
//  TaskDetayViewModel.swift
//  ToDoApp
//
//  Created by semih bekdaş on 10.10.2024.
//

import Foundation
class TaskDetayViewModel {
    
    var trepo = TaskRepository()
    
    func guncelle(task_id:Int,task_title:String,task_description:String,task_isCompleted:Int){
            
        trepo.guncelle(task_id: task_id, task_title: task_title, task_description: task_description, task_isCompleted: task_isCompleted)
    }
    
    
}
