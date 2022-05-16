//
//  ViewController.swift
//  app
//
//  Created by SOUCHET Julie on 16/05/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titre: UILabel! // link to the title element
    
    var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titre.text = "Count: \(count)"
    }
    
    @IBAction func increaseButton(_ sender: Any) { // callback executed when button is clicked
        count += 1
        titre.text = "Count: \(count)"
    }
    
    @IBAction func resetButton(_ sender: Any) {
        count = 0
        titre.text = "Count: \(count)"
    }
    
    @IBAction func nextView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // storyboard = groupe de vues
        let nextView = storyboard.instantiateViewController(withIdentifier: "ViewController_2") as! ViewController_2 // objet liée à l'autre vue
        nextView.count = self.count // envoie la donnée au 2ème controlleur
        
        navigationController?.pushViewController(nextView, animated: true)
    }
}

