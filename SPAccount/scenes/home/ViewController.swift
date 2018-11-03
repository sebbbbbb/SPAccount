import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelCount: UILabel!
    
    var categories = try! Realm().objects(Category.self) {
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
        
        
        if categories.isEmpty {
            
            try! self.realm.write {
                let category1 = Category()
                category1.name = "Bouffe"
                category1.cap = 400
                
                let category2 = Category()
                category2.name = "Fun"
                category2.cap = 220
                
                let category3 = Category()
                category3.name = "Maison"
                category3.cap = 70
                
                let category4 = Category()
                category4.name = "Sappe"
                category4.cap = 55
            
                self.realm.add(category1)
                self.realm.add(category2)
                self.realm.add(category3)
                self.realm.add(category4)
                
                
            }
            
            
        }
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
        let category = self.category(from: (self.tableView.indexPathForSelectedRow?.row) ?? 0)
        let operation = Operation()
        operation.amount = cpt
        operation.name = self.textField.text ?? ""
        
        
        try! self.realm.write {
            category.operations.append(operation)
        }
        
        self.cpt = 0
    }
    
    private func category(from index: Int) -> Category {
        return self.categories[index]
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
        return cell
    }
}

