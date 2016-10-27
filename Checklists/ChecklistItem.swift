//
//  ChecklistItem.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/14.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import Foundation

class ChecklistItem:NSObject,NSCoding {
    var text = ""
    var checked = false
    
    var dueDate = NSDate()
    var shouldRemind = false
    var itemID: Int?
    
    func toggleChecked() {
        checked = !checked
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
        aCoder.encode(dueDate, forKey: "DueDate")
        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
        aCoder.encode(itemID, forKey: "ItemID")

    }
    required init?(coder aDecoder: NSCoder) {
        
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")

        
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! NSDate
        itemID = aDecoder.decodeInteger(forKey: "ItemID")
        
        super.init()
    }
    
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
}

