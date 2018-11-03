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
    var categories = try! Realm().objects(Category.self) {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let category = self.categories[section]
        
        // Mois
        let monthExpenses = category.getCurrentMonthOperation().map {$0.amount}.reduce(0, +)
        let monthPercent = String(Int(CGFloat(monthExpenses) / CGFloat(category.cap) * 100))
        
        // YTD
        let monthCount = 2
        let YTDExpenses = category.operations.map {$0.amount}.reduce(0, +)
        let YTDPercent = String(Int(CGFloat(YTDExpenses) / CGFloat(category.cap * monthCount) * 100))
        
        return "\(category.name)  \(category.cap - monthExpenses)€ \(monthPercent)% | \(category.cap * monthCount - YTDExpenses)€ \(YTDPercent)%"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories[section].getCurrentMonthOperation().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let operation = self.categories[indexPath.section].getCurrentMonthOperation()[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = operation.name
        cell.detailTextLabel?.text = "\(operation.amount)€" + " - " + operation.creationDate.toString()
        return cell
    }
}
