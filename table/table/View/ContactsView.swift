//
//  ContactsView.swift
//  table
//
//  Created by SOUCHET Julie on 17/05/2022.
//

import Foundation
import UIKit

// Controlleur pour une cellule
class ContactsCellViewController: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
}

// Controlleur pour la page entière
class ContactsViewController: UIViewController {
    var contacts: [ContactModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mes contacts"
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    func fetchData() {
        Networker<Results>.fetch(URL(string: "https://randomuser.me/api?results=10")!) { data in
            print("Récupéré \(data.results.count) contacts")
            self.contacts = data.results
            DispatchQueue.main.async { // pour que ce soit géré par le thread principal
                self.tableView.reloadData()
            }
        }
    }
    
}

// Pour ajouter des fonctionnalités au controlleur de base
extension ContactsViewController: UITableViewDelegate {
}
extension ContactsViewController: UITableViewDataSource {
    // TableView a besoin de connaître combien de cellules il y a en tout
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    // TableView a besoin d'une méthode pour remplir la cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCellViewController", for: indexPath) as! ContactsCellViewController
        
        // Remplit la cellule
        cell.nameLabel.text = "\(contacts[indexPath.row].name.title) \(contacts[indexPath.row].name.first) \(contacts[indexPath.row].name.last)"
        cell.emailLabel.text = contacts[indexPath.row].email
        
        // Charge l'image depuis l'url
        if let url = URL(string: contacts[indexPath.row].picture.large) {
            DispatchQueue.global().async {
              if let data = try? Data(contentsOf:url) {
                DispatchQueue.main.async {
                  cell.imageOutlet.image = UIImage(data:data)
                }
              }
           }
        }
        
        return cell
    }
}
