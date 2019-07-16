//
//  ViewController.swift
//  Todoey
//
//  Created by piyush sharma on 15/07/19.
//  Copyright © 2019 Piyush Sharma. All rights reserved.
//

import UIKit
import CoreData

class TodoList: UITableViewController {
    
    var data = [Items]()
    //let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //var data = ["call mike","kill Demogorgon","Close the Gate"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItem()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        let newItem = Items
//        newItem.item = "eat momos"
//        data.append(newItem)
        
//        if let coreData = defaults.array(forKey: "toDoListArray") as? [Items] {
//            data = coreData
//        }
        
    }

    //MARK:- Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = item.item

        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    //MARK- Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        context.delete(data[indexPath.row])
        data.remove(at: indexPath.row)
        
//        if data[indexPath.row].done == true {
//            data[indexPath.row].done = false
//        }else{
//            data[indexPath.row].done = true
//        }
        saveData()
        tableView.reloadData()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
    }
    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController.init(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
        
            print("Success")
            
            //print(textField.text!)
            let newitem = Items(context: self.context)
            newitem.item = textField.text!
            newitem.done = false
            
            self.data.append(newitem)
            self.saveData()
          //  self.defaults.set(self.data, forKey: "toDoListArray")
            self.tableView.reloadData()
           
            
        }
        alert.addTextField { (alertTextField) in
            textField.placeholder = "add new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveData() {
        do {
            try context.save()
        } catch  {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItem() {
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        do {
        data = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
    

}

extension TodoList: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        let predicate = NSPredicate(format: "item CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "item", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do{
            data = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}

