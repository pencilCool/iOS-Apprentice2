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
    
    func toggleChecked() {
        checked = !checked
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")

    }
    required init?(coder aDecoder: NSCoder) {
        
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
}

