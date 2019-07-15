//
//  ViewController.swift
//  Todoey
//
//  Created by piyush sharma on 15/07/19.
//  Copyright © 2019 Piyush Sharma. All rights reserved.
//

import UIKit

class TodoList: UITableViewController {

    var data = ["call mike","kill Demogorgon","Close the Gate"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK:- Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    //MARK- Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController.init(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            
            print("Success")
            
            //print(textField.text!)
            self.data.append(textField.text!)
            self.tableView.reloadData()
           
            
        }
        alert.addTextField { (alertTextField) in
            textField.placeholder = "add new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

