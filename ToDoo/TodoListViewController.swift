//
//  ViewController.swift
//  ToDoo
//
//  Created by Razvan Armeanu on 01/11/2018.
//  Copyright © 2018 Razz. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemsArray = ["Basina", "Part", "Flatulatie"]
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = userDefaults.array(forKey: "ToDoListArray") as? [String]{
            itemsArray = items
        }
    }

    //MARK: UITableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        cell.textLabel?.text = itemsArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }

    //MARK: Tableview Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add Button
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textFieldToObtainValueFrom = UITextField()
        
        let alert = UIAlertController(title: "Add a ToDoo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add a new item", style: .default) { (action) in
            
            if let tf = textFieldToObtainValueFrom.text{
                self.itemsArray.append(tf)
            }
            
            self.userDefaults.set(self.itemsArray, forKey: "ToDoListArray")
            self.tableView.reloadData()//reload
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new item here"
            textFieldToObtainValueFrom = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

