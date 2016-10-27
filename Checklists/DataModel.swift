//
//  DataModel.swift
//  Checklists
//
//  Created by tangyuhua on 2016/10/25.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

import Foundation
class DataModel {
    var lists = [Checklist]()
    
    init(){
        loadChecklists()
        registerDefaults()
        handleFirsTime()
    }
    
    func registerDefaults() {
        let dictionary = ["ChecklistIndex": -1,
                          "FirstTime": true,
                          "ChecklistItemID": 0] as [String : Any] //还要加这么个东西呀
 
        UserDefaults.standard.register(defaults: dictionary)
        
    }
    
    func handleFirsTime() {
        let userDefault = UserDefaults.standard
        let first = userDefault.bool(forKey: "FirstTime")
        if first {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            indexOfSelectedChecklist = 0
            userDefault.set(false, forKey: "FirstTime")
            userDefault.synchronize()
        }
    }
    
    func documentsDirectory() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return path[0]
    }
    func dataFilePath()->String {
        return (documentsDirectory() as NSString).appendingPathComponent("Checklist.plist")
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    func loadChecklists() { // 1
        let path = dataFilePath()
        // 2
        if FileManager.default.fileExists(atPath: path) {
            // 3
            if let data = NSData(contentsOfFile: path) {
                
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
                lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
                unarchiver.finishDecoding()
                sortChecklists()
                
            }
        }
    }
    
    var indexOfSelectedChecklist: Int{
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
     func sortChecklists() {
        lists.sort(by: { checklist1, checklist2 in return
            checklist1.name.localizedStandardCompare(checklist2.name) == .orderedAscending })
    }
    
    // 创建新的item的时候会提供一个唯一的标识符
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
}
