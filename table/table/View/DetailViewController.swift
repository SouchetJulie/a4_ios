//
//  DetailViewController.swift
//  table
//
//  Created by SOUCHET Julie on 16/05/2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var data: DataModel? = nil
    
    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleContent.text = data?.title
        userId.text = data?.userId.description
        id.text = data?.id.description
        body.text = data?.body
    }
}
