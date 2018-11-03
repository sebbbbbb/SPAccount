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
    
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = DetailViewModel(categories: categories.compactMap {$0})
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel?.categoryViewModel[section].titleForHeader
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.categoryViewModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.categoryViewModel[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let operationViewModel = self.viewModel?.categoryViewModel[indexPath.section].items[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = operationViewModel?.mainText
        cell.detailTextLabel?.text = operationViewModel?.subText
        return cell
    }
}
