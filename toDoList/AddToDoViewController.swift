//
//  AddToDoViewController.swift
//  toDoList
//
//  Created by scholar on 8/1/22.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    var previousVC = ToDoTableViewController()

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addTapped(_ sender: Any) {
        
//        let toDo = ToDo()
//        if let titleText = titleTextField.text {
//            toDo.name = titleText
//            toDo.important = importantSwitch.isOn
//        }
//        // adds new toDo to ToDoTableViewController
//        previousVC.toDos.append(toDo)
//        previousVC.tableView.reloadData()
//
//        // pops back to previous view after user hits add
//        navigationController?.popViewController(animated:true)
        
        /* Using ToDoCD object with Core Data instead!!!*/
        // grab this view context to be able to work w core data
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            // create a new ToDoCD object, named toDo
            let toDo = ToDoCD(entity: ToDoCD.entity(), insertInto: context)
            
            // if the titleTextField has text, will call that text titleText
            if let titleText = titleTextField.text {
                // take titleText & assign it to toDo.name and assign importance
                toDo.name = titleText
                toDo.important = importantSwitch.isOn
            }
            
            try? context.save()
            navigationController?.popViewController(animated:true)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
