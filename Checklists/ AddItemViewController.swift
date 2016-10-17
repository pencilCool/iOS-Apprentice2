//
//   AddItemViewController.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/14.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate{
    var itemToEdit: ChecklistItem?
    
    weak var delegate: AddItemViewControllerDelegate?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
        delegate?.addItemViewControllerDidCancel(controller: self)
    }
    @IBAction func done () {
        
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.addItemViewController(controller: self, didFinishEditingItem: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            delegate?.addItemViewController(controller: self, didFinishAddingItem: item)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true;
        }
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText: NSString = textField.text! as NSString
        let newText: NSString = oldText.replacingCharacters(
            in: range, with: string) as NSString
     
        doneBarButton.isEnabled = (newText.length > 0)
        return true
        
    }
}
