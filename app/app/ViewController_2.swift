//
//  ViewController_2.swift
//  app
//
//  Created by SOUCHET Julie on 16/05/2022.
//

import UIKit

class ViewController_2: UIViewController {
    @IBOutlet weak var titre: UILabel!
    
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titre.text = "Count: \(count)"
    }
    
    
}
