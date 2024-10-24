//
//  TaskRepository.swift
//  ToDoApp
//
//  Created by semih bekdaş on 10.10.2024.
//

import Foundation
import RxSwift

class TaskRepository {
    
    // table adı taks oldu unutma!!
    var taskListe = BehaviorSubject<[Task]>(value: [Task]())
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("task.sqlite")
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    
    
    
    func kaydet(task_title:String,task_description:String){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO taks (task_title,task_description,task_isCompeted) VALUES (?,?,?)", values: [task_title,task_description,0])
        
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    
    func sil(task_id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM taks WHERE task_id = ?", values: [task_id])
        
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func guncelle(task_id:Int,task_title:String,task_description:String,task_isCompleted:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE taks Set task_title = ?, task_description = ?, task_isCompeted = ? Where task_id= ?", values: [task_title,task_description,task_isCompleted,task_id])
        
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    
    
    
    
    
    
    
    func ara(aramaKelimesi:String){
        
        db?.open()
        
        do{
            var liste = [Task]()
            
            let rs = try db!.executeQuery("SELECT * FROM taks WHERE task_title like '%\(aramaKelimesi)%'", values: nil)
            
            while rs.next() {
                let task_id = Int(rs.string(forColumn: "task_id"))
                let task_title = rs.string(forColumn: "task_title")
                let task_description = rs.string(forColumn: "task_description")
                let task_isCompleted = Int(rs.string(forColumn: "task_isCompeted"))
                let task = Task(task_id: task_id!, task_title: task_title!, task_description: task_description!, task_isCompleted: task_isCompleted!)
                
                liste.append(task)
            }
            
            taskListe.onNext(liste)//Tetikleme
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    func yapilacaklariYukle(){
        db?.open()
        
        do{
            var liste = [Task]()
            
            let rs = try db!.executeQuery("SELECT * FROM taks", values: nil)
            
            while rs.next() {
                let task_id = Int(rs.string(forColumn: "task_id"))
                let task_title = rs.string(forColumn: "task_title")
                let task_description = rs.string(forColumn: "task_description")
                let task_isCompleted = Int(rs.string(forColumn: "task_isCompeted"))
                let task = Task(task_id: task_id!, task_title: task_title!, task_description: task_description!, task_isCompleted: task_isCompleted!)
                
                liste.append(task)
                
                
            }
            
            taskListe.onNext(liste)//Tetikleme
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
}
