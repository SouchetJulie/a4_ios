//
//  ViewController.swift
//  table
//
//  Created by SOUCHET Julie on 16/05/2022.
//

import UIKit


// Pour controller une cellule
class CellViewController: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

class ViewController: UIViewController {
    
    var data: [DataModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lorem ipsum"
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    func fetchData() {
        Networker<[DataModel]>.fetch(URL(string: "https://jsonplaceholder.typicode.com/posts")!) { data in
            print("Récupéré \(data.count) paragraphes")
            self.data = data            
            DispatchQueue.main.async { // pour que ce soit géré par le thread principal
                self.tableView.reloadData()
            }
        }
    }
    
    // Ouvre une popup de confirmation
    func showPopup(dataModel: DataModel, index: IndexPath) {
        let alert = UIAlertController(title: "Confirmation", message: "Êtes-vous sûr de vouloir supprimer la cellule \"\(dataModel.title)\" ?", preferredStyle: .alert)
        
        // Ajout des boutons
        alert.addAction(UIAlertAction(title: "Oui", style: .destructive, handler: { _ in // (action)
            self.data.remove(at: index.row)
            self.tableView.deleteRows(at: [index], with: .automatic)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Non", style: .cancel, handler: { _ in
        }))
        
        self.present(alert, animated: true)
    }
}

// Pour ajouter des fonctionnalités au controlleur de base
extension ViewController: UITableViewDelegate {
    // Ouvre la vue détaillée lors du press
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detail.data = data[indexPath.row]
        
        navigationController?.pushViewController(detail, animated: true)
    }
    
    // Supprime une cellule lors du swipe
    func deleteAction(dataModel: DataModel, index: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "🗑") { _, _, completion in // (action, view, completion)
            self.showPopup(dataModel: dataModel, index: index)
            completion(true)
        }
        action.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // Swipe vers la gauche (trailing = ajout des boutons d'action à la fin = droite)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.deleteAction(dataModel: data[indexPath.row], index: indexPath)
    }
    // Swipe vers la droite
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.deleteAction(dataModel: data[indexPath.row], index: indexPath)
    }
}
extension ViewController: UITableViewDataSource {
    // TableView a besoin de connaître combien de cellules il y a en tout
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    // TableView a besoin d'une méthode pour récupérer la cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellViewController", for: indexPath) as! CellViewController
        cell.label.text = data[indexPath.row].title
        return cell
    }
}
