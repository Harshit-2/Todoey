//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Harshit ‎ on 1/7/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewControllerTableViewController: SwipeTableViewController {

    var realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.systemBlue
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // With a blue background, make the title more readable.
//        navigationItem.standardAppearance = appearance
//        navigationItem.scrollEdgeAppearance = appearance
//        navigationItem.compactAppearance = appearance // For iPhone small navigation bar in landscape.
        
//        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "CategortCell")
        
        tableView.separatorStyle = .none
        loadCategories()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
        }
        navBar.backgroundColor = UIColor(hexString: "1D9BF6")
    }
    
    

    // MARK: - TableView Datasourse Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories?.count ?? 1
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name

            cell.backgroundColor = UIColor(hexString: category.colour)
                   
            guard let categoryColor = UIColor(hexString: category.colour) else {fatalError()}
            
            cell.backgroundColor = categoryColor
            
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)

        }
        
        
        return cell
    }

    
//MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category \(error)")
            }
        }
    }
        
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
   
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // MARK: - Add new Categories
        var textField = UITextField()
                let alert = UIAlertController(title: "Add a New Cateogry", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "Add", style: .default) { (action) in
                    let newCategory = Category()
                    newCategory.name = textField.text!
                    newCategory.colour = UIColor.randomFlat().hexValue()
                    
                    self.save(category: newCategory)
                }
                
                alert.addAction(action)
                alert.addTextField { (field) in
                    textField = field
                    textField.placeholder = "Add a new category"
                }
                present(alert, animated: true, completion: nil)
            }
    
    



    
}

