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
    }
    
    func registerDefaults() {
        let dictionary = [ "ChecklistIndex": -1 ]
        UserDefaults.standard.register(defaults: dictionary)
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
                unarchiver.finishDecoding() }
        } }
    
    
}
