//
//  ToDo_Delete.swift
//  Project_ToDoList
//
//  Created by 박성주 on 2020/03/11.
//  Copyright © 2020 박성주. All rights reserved.
//

import Foundation
import SQLite3

class DeleteSQL {
    
    var db: OpaquePointer?
    var dataId: Int

    init(dataId: Int) {
        self.dataId = dataId
    }
    
    func deleteDiary(seqno:Int) {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Emoda.sqlite")
    
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
    
        var stmt: OpaquePointer?
        let queryString = "DELETE from Diary where diary_Seqno = \(seqno)"
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
           let errmsg = String(cString: sqlite3_errmsg(db)!)
           print("error preparing insert : \(errmsg)")
           return
        }
        if sqlite3_step(stmt) != SQLITE_DONE{
           let errmsg = String(cString: sqlite3_errmsg(db)!)
           print("failure delete students : \(errmsg)")
           return
        }
        print("delete!!")
    }
    
    func tableDropAction(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Emoda.sqlite")
        
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
                print("error opening database")
            }
        
            var stmt: OpaquePointer?
            let queryString = "DROP TABLE Diary"
            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
               let errmsg = String(cString: sqlite3_errmsg(db)!)
               print("error preparing insert : \(errmsg)")
               return
            }
            if sqlite3_step(stmt) != SQLITE_DONE{
               let errmsg = String(cString: sqlite3_errmsg(db)!)
               print("failure delete students : \(errmsg)")
               return
            }
    }
    
    func deleteAction() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Emoda.sqlite")
    
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let deleteDate = formatter.string(from: date as Date)
        
        var stmt: OpaquePointer?
        let queryString = "UPDATE dataInfo SET iDeleteDate = \(deleteDate) where iDataId = \(dataId)"
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
           let errmsg = String(cString: sqlite3_errmsg(db)!)
           print("error preparing insert : \(errmsg)")
           return
        }
        if sqlite3_step(stmt) != SQLITE_DONE{
           let errmsg = String(cString: sqlite3_errmsg(db)!)
           print("failure delete students : \(errmsg)")
           return
        }
    }
    
}
