//
//  AnasayfaViewModel.swift
//  ToDoApp
//
//  Created by semih bekdaş on 10.10.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    
    var trepo = TaskRepository()
    
    var taskListesi = BehaviorSubject<[Task]>(value: [Task]())

    
    init(){
        veritabaniKopyala()
        taskYukle()
        taskListesi = trepo.taskListe
    }
    
    
    
    func sil(task_id:Int){
        trepo.sil(task_id: task_id)
        taskYukle()
    }
    
    func ara(aramaKelimesi:String){
        trepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func taskYukle(){
        trepo.yapilacaklariYukle()
    }
    
    
    
    
    func veritabaniKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "task", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("task.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}


