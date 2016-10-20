//
//  ViewController.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/12.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var items: [ChecklistItem]
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        super.init(coder:aDecoder)
        loadChecklistItems()
//        
//        let row0item = ChecklistItem()
//        row0item.text = "Walk the dog"
//        row0item.checked = false
//        items.append(row0item)
//        
//        let row1item = ChecklistItem()
//        row1item.text = "Brush my teeth"
//        row1item.checked = true
//        items.append(row1item)
//        
//        let row2item = ChecklistItem()
//        row2item.text = "Learn iOS development"
//        row2item.checked = true
//        items.append(row2item)
//        
//        let row3item = ChecklistItem()
//        row3item.text = "Soccer practice"
//        row3item.checked = false
//        items.append(row3item)
//        
//        let row4item = ChecklistItem()
//        row4item.text = "Eat ice cream"
//        row4item.checked = true
//        items.append(row4item)
//        
//        super.init(coder: aDecoder)
//        
//        print("Documents folder is \(documentsDirectory())")
//        print("Data file path is \(dataFilePath())")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureCheckmark(for: cell, withChecklistItem: item)
        configureText(for:cell, withChecklistItem: item)
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, withChecklistItem: item)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveChecklistItems()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
    }
    
    func configureCheckmark(for cell: UITableViewCell, withChecklistItem item: ChecklistItem) {

        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    
    }
    
    func configureText(for cell: UITableViewCell,
                              withChecklistItem item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
 //MARK: ItemDetailViewControllerDelegate
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
        saveChecklistItems()
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
    

        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, withChecklistItem: item)
            }
        }
        dismiss(animated: true, completion: nil)
        saveChecklistItems()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier ==  "EditItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = items[indexPath.row]
            }
            
        }
        
        
    }
    
    func documentsDirectory() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return path[0]
    }
    func dataFilePath()->String {
        return (documentsDirectory() as NSString).appendingPathComponent("Checklist.plist")
    }
    
    func saveChecklistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    func loadChecklistItems() { // 1
        let path = dataFilePath()
        // 2
        if FileManager.default.fileExists(atPath: path) {
            // 3
            if let data = NSData(contentsOfFile: path) {
                
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
                items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [ChecklistItem]
                unarchiver.finishDecoding() }
        } }
    
}

