//
//  GorevKayitViewController.swift
//  ToDoApp
//
//  Created by semih bekdaş on 10.10.2024.
//

import UIKit

class GorevKayit: UIViewController , UITextViewDelegate{
    
    @IBOutlet weak var textFieldTitle: UITextField!
    
    @IBOutlet weak var textViewİcerig: UITextView!
    let placeholderText = "İçeriği Giriniz.."
    
    var viewModel = GorevKayitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewİcerig.delegate = self
        textViewİcerig.text = placeholderText
        textViewİcerig.textColor = .lightGray

    }
    
    @IBAction func buttonEkle(_ sender: Any) {
        
        if let task_title = textFieldTitle.text,let task_description = textViewİcerig.text {
            viewModel.kaydet(task_title: task_title, task_description: task_description)
        }
        
    }
    func textViewDidChange(_ textViewİcerig: UITextView) {
        if textViewİcerig.text.isEmpty {
            textViewİcerig.text = placeholderText
            textViewİcerig.textColor = .lightGray
        } else if textViewİcerig.text == placeholderText {
            textViewİcerig.text = ""
            textViewİcerig.textColor = .black
        }
    }

    // UITextView'ye dokunulduğunda çağrılır
    func textViewDidBeginEditing(_ textViewİcerig: UITextView) {
        if textViewİcerig.text == placeholderText {
            textViewİcerig.text = ""
            textViewİcerig.textColor = .black
        }
    }

    // UITextView'den çıkıldığında çağrılır
    func textViewDidEndEditing(_ textViewİcerig: UITextView) {
        if textViewİcerig.text.isEmpty {
            textViewİcerig.text = placeholderText
            textViewİcerig.textColor = .lightGray
        }
    }
    
  

}
