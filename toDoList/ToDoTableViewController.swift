//
//  ToDoTableViewController.swift
//  toDoList
//
//  Created by scholar on 7/30/22.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getToDos()
        
        // storing array we will return with createToDos into var toDos
//        toDos = createToDos()
        
        
        
    }
    
    // so new ToDos will appear as Core Data is updated
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    //create toDos property in our VC to store the array!
    var toDos: [ToDoCD] = []
    
    // create Static To Dos (will create & return array of ToDo objects!)
    // will be replaced later when setting up CoreData
    func createToDos() -> [ToDo] {
        let swift = ToDo()
        swift.name = "Learn Swift"
        swift.important = true
        let dog = ToDo()
        dog.name = "Walk the dog"
        // important set to false by default
        
        return [swift, dog]
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        let toDo = toDos[indexPath.row]
        
        // get toDos to show up & mark as important or not
        if let name = toDo.name {
            if toDo.important {
                cell.textLabel?.text = "❗️" + name
            } else {
                cell.textLabel?.text = toDo.name
            }
        }
        return cell
    }
    
    // move to complete
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // get single ToDo
        let toDo = toDos[indexPath.row]
        
        performSegue(withIdentifier:  "moveToComplete", sender: toDo)
    }
    
    // going to fetch toDos from Core Data
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            //fetch toDos from Core Data, bring back as array of Core Data objects
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                toDos = coreDataToDos
                tableView.reloadData()
            }
        }
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // create a reference to AddToDoViewController
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.previousVC = self
        }
        
        // segues to CompleteToDoViewController
        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
    }
    

}
