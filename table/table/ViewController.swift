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
    
    var array = ["Hello", "world", ",", "let's", "rumble", "!"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My list"
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// Pour ajouter des fonctionnalités au controlleur de base
extension ViewController: UITableViewDelegate { }
extension ViewController: UITableViewDataSource {
    // TableView a besoin de connaître combien de cellules il y a en tout
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    // TableView a besoin d'une méthode pour récupérer la cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellViewController", for: indexPath) as! CellViewController
        cell.label.text = array[indexPath.row]
        return cell
    }
}
