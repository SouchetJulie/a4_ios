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
    
    var array: [DataModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My list"
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    func fetchData() {
        Networker.fetch(URL(string: "https://jsonplaceholder.typicode.com/posts")!) { data in
            print("Fetched \(data.count) elements")
            
            self.array = data
            
            DispatchQueue.main.async { // pour que ce soit géré par le thread principal
                self.tableView.reloadData()
            }
        }
    }
}

// Pour ajouter des fonctionnalités au controlleur de base
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detail.data = array[indexPath.row]
        
        navigationController?.pushViewController(detail, animated: true)
    }
}
extension ViewController: UITableViewDataSource {
    // TableView a besoin de connaître combien de cellules il y a en tout
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    // TableView a besoin d'une méthode pour récupérer la cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellViewController", for: indexPath) as! CellViewController
        cell.label.text = array[indexPath.row].title
        return cell
    }
}
