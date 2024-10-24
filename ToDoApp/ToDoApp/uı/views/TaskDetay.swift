//
//  TaskDetay.swift
//  ToDoApp
//
//  Created by semih bekdaş on 10.10.2024.
//

import UIKit

class TaskDetay: UIViewController {

    @IBOutlet weak var textFieldTitle: UITextField!
    
    @IBOutlet weak var textViewTask: UITextView!
    
    @IBOutlet weak var isComplated: UIButton!
    var task: Task?
    
    var viewModel = TaskDetayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let t = task {
            textFieldTitle.text = t.task_title
            textViewTask.text = t.task_description
            updateButtonUI(IsCompleted: t.task_isCompleted==1)
            
        }

    }
    
    @IBAction func buttonGuncelle(_ sender: Any) {
        
        if let t = task, let task_title = textFieldTitle.text, let task_description = textViewTask.text {
            viewModel.guncelle(task_id: t.task_id!, task_title: task_title, task_description: task_description, task_isCompleted: t.task_isCompleted!)
        }
        
    }
    
   
    @IBAction func buttonisCompleted(_ sender: Any) {
        task!.task_isCompleted = task!.task_isCompleted == 0 ? 1 : 0
        
        let isCompleted = task!.task_isCompleted == 1
           updateButtonUI(IsCompleted: isCompleted)
        
    }
    
    func updateButtonUI(IsCompleted: Bool) {
        if IsCompleted {
            // Görev tamamlandı, checkmark simgesini ekle
            isComplated.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            // Görev tamamlanmadı, boş çember simgesini ekle
            isComplated.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    
}
