//
//  DetailViewController.swift
//  SPAccount
//
//  Created by Sebastien on 29/10/2018.
//  Copyright © 2018 Sebastien. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var entities = try! Realm().objects(Operation.self) {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = self.entities[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = category.name + " / " + category.category
        cell.detailTextLabel?.text = "\(category.amount) €"
        return cell
    }
}
