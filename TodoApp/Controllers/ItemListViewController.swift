import UIKit
import CoreData

final class ItemListViewController: UITableViewController, UISearchResultsUpdating {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items = [Item]()
    var searchResults = [Item]()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self)
        tableView.backgroundColor = UIColor(named: "Secondary")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 65
    }
    
    func setupNavigationBar() {
        navigationItem.title = selectedCategory?.title
        navigationItem.searchController = searchController

        if FeatureService.shared.enabled(.addItem) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                target: self,
                                                                action: #selector(addButtonPressed))
        }

        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Active")!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor(named: "Primary")
        navigationController?.navigationBar.tintColor = UIColor(named: "Action")
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
    
// MARK: - TableView DataSource Methods

extension ItemListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchController.searchBar.text!.isEmpty {
            return searchResults.count
        } else {
            return items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        let item = !searchController.searchBar.text!.isEmpty ? searchResults[indexPath.row] : items[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        cell.selectionStyle = .none
        cell.tintColor = UIColor(named: "Action")
        cell.backgroundColor = UIColor(named: "Primary")
        
        return cell
    }
}

// MARK: - TableView Delegate Methods

extension ItemListViewController {
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (contextualAction, view, boolValue) in
            guard let self = self else { return }
            
            self.context.delete(self.items[indexPath.row])
            self.items.remove(at: indexPath.row)
            self.saveItems()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return UISwipeActionsConfiguration(actions: [contextItem])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].done = !items[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
}

// MARK: - Add New Items
    
extension ItemListViewController {
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alertController = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (alertTextField) in
            alertTextField.placeholder = "Some item"
            textField = alertTextField
        }
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.items.append(newItem)
            
            self.saveItems()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Data Manipulation Methods

extension ItemListViewController {
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)
        
        if let additionsPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionsPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            items = try context.fetch(request)
        } catch{
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}

// MARK: - Search Bar Methods

extension ItemListViewController {
    func updateSearchResults(for searchController: UISearchController) {
        let searchPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchController.searchBar.text!)
        searchResults = (items as NSArray).filtered(using: searchPredicate) as! [Item]

        tableView.reloadData()
    }
}
