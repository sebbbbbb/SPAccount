import UIKit
import RealmSwift

struct Category {
    let amount: Int
    let name: String
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelCount: UILabel!
    
    var categories = [Category]()
    var entities = try! Realm().objects(Operation.self) {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var cpt = 0 {
        didSet {
            self.labelCount.text = "\(cpt) €"
        }
    }
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Accueil"
        self.buildCategories()
    }
    
    private func buildCategories() {
        
        let categoryNames = Set(self.entities.map {$0.category})
        var cat = [Category]()
        categoryNames.forEach { category in
            
            let amount = self.entities.filter {$0.category == category }
                .map {$0.amount}
                .reduce(0, +)
            
            cat.append(Category(amount: amount, name: category))
        }
        
        self.categories = cat
        self.tableView.reloadData()
    }
    
    
    
    
    //MARK : Actions
    
    @IBAction func addOperation() {
        self.cpt += 10
    }
    
    @IBAction func addOperation2() {
        self.cpt += 1
    }
    
    @IBAction func accountDetail() {
        self.navigationController?.pushViewController(DetailViewController(nibName: "DetailViewController", bundle: nil), animated: true)
    }
    
    @IBAction func addOperationX() {
        
        // Fun par défaut
        let category = self.category(from: (self.tableView.indexPathForSelectedRow?.row) ?? -1)
        let operation = Operation()
        operation.amount = cpt
        operation.name = self.textField.text ?? ""
        operation.category = category
        
        try! self.realm.write {
            realm.add(operation)
        }
        
        self.cpt = 0
        self.buildCategories()
    }
    
    private func category(from index: Int) -> String {
        return self.categories[index].name
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = self.categories[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = category.name
        cell.detailTextLabel?.text = "\(category.amount) €"
        return cell
    }
}

