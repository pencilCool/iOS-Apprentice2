//
//   AddItemViewController.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/14.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func done () {
        print("Contents of the text field: \(textField.text!)")
        dismiss(animated: true, completion: nil)
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
