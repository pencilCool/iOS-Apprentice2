//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/24.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate:class {
    
    func listDetailViewControllerDidCancel(controller:ListDetailViewController)
    
    func listDetailViewController(controller:ListDetailViewController, didFinishAddingChecklist checklist:Checklist)
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)
    
    
}

class ListDetailViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDetailViewControllerDelegate?
    var checklistToEdit: Checklist?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func  tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text! as NSString
        let newText: NSString = oldText.replacingCharacters( in: range, with: string) as NSString
        doneBarButton.isEnabled = (newText.length > 0)
        return true
    }
    
  
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(controller: self)
    }
    
    @IBAction func done() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            delegate?.listDetailViewController(controller: self, didFinishAddingChecklist: checklist)
        } else {
            let checklist = Checklist(name: textField.text!)
            delegate?.listDetailViewController(controller: self, didFinishAddingChecklist: checklist)
         
        }
    }
}
































