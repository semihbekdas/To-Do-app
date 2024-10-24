//
//  GorevKayitViewModel.swift
//  ToDoApp
//
//  Created by semih bekdaş on 10.10.2024.
//

import Foundation

class GorevKayitViewModel{
    
    var trepo = TaskRepository()
    
    func kaydet(task_title:String,task_description:String){
        trepo.kaydet(task_title: task_title, task_description: task_description)
    }

    
    
}
