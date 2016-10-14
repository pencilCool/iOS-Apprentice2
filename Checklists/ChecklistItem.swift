//
//  ChecklistItem.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/14.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
