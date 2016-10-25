//
//  AllListsViewController.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/20.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    var lists: [Checklist]
    
    required init?(coder aDecoder: NSCoder) {
        lists = [Checklist]()
        
        super.init(coder: aDecoder)
        
        var list =  Checklist(name: "Birthday")
        lists.append(list)
        
        list = Checklist(name: "Groceries")
        lists.append(list)
        
        list = Checklist(name: "Cool Apps")
        lists.append(list)
        
        list = Checklist(name: "To Do")
        lists.append(list)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }
//MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = cellForTableView(tableView)
        cell.textLabel!.text = "List \(indexPath.row)"
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
 
    func cellForTableView(_ tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell =
            tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default,
                                   reuseIdentifier: cellIdentifier)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "ListDetailNavigationController") as! UINavigationController
        
        let controller = navigationController.topViewController as! ListDetailViewController
        controller.delegate = self
        let checklist = lists[indexPath.row]
        controller.checklistToEdit = checklist
        present(navigationController, animated: true, completion: nil)
    }
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }

    
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist) {
        let newRowIndex = lists.count
        lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        dismiss(animated: true, completion: nil)
        
    }
    

    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist){
        
        if let index = lists.index(of: checklist){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                cell.textLabel!.text = checklist.name
                
            }
            
        }
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destination as! CheckListViewController
            controller.checklist = sender as! Checklist 
        } else if segue.identifier == "AddChecklist" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = nil
            
            
        }
    }
 
}
