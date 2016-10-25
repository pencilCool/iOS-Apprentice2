//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/25.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
    func iconPicker(picker: IconPickerViewController,
                                                                   didPickIcon iconName: String)
}


class IconPickerViewController: UITableViewController {
    
    let icons = [
                  "No Icon",
                  "Appointments",
                  "Birthdays",
                  "Chores",
                  "Drinks",
                  "Folder",
                  "Groceries",
                  "Inbox",
                  "Photos",
                  "Trips"
                ]
    
    weak var delegate: IconPickerViewControllerDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {  // 这都行
            let iconName = icons[indexPath.row]
            delegate.iconPicker(picker: self, didPickIcon: iconName)
        }
    }
}
