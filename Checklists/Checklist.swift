//
//  Checklist.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/20.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import UIKit

class Checklist: NSObject,NSCoding {
    var name = ""
    var items = [ChecklistItem]()
    var iconName: String
    
    init(name:String){
        self.name = name;
        iconName = "No Icon"
        super.init()
    }
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        iconName = aDecoder.decodeObject(forKey: "IconName") as! String
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(iconName, forKey: "IconName")
        
        
    }
    
    
    func countUncheckedItems() -> Int {
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
}
