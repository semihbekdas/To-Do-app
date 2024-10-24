//
//  ViewController.swift
//  ToDoApp
//
//  Created by semih bekdaş on 10.10.2024.
//

import UIKit

class Anasayfa: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    var taskListesi = [Task]()
    
    var viewModel = AnasayfaViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar.delegate = self
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        
        _ = viewModel.taskListesi.subscribe(onNext: { liste in
            self.taskListesi = liste
            self.tasksTableView.reloadData()
        })
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.taskYukle()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            
            if let task = sender as? Task {
                let gidilecekVC = segue.destination as! TaskDetay
                gidilecekVC.task = task
            }
            
        }
    }
    


}

extension Anasayfa : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.ara(aramaKelimesi: searchText)
        
    }
}

extension Anasayfa : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  taskListesi.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskHucre", for: indexPath) as! TaskHucre
        
        let task = taskListesi[indexPath.row]
        
        cell.labelTitle.text = task.task_title
        cell.labelDescription.text = task.task_description
        
        
        if task.task_isCompleted == 1{
            
            cell.buttonCheck.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            
        }else {
            cell.buttonCheck.setImage(UIImage(systemName: "checkmark.square"), for: .normal)

            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: task)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ contextualAction,view,bool in
            let task = self.taskListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(task.task_title!) silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.sil(task_id: task.task_id!)
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}

