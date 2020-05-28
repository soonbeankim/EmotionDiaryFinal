//
//  InsertSQL.swift
//  Calander01
//
//  Created by binybing on 17/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import Foundation
import SQLite3

class InsertSQL{
    var db: OpaquePointer?
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    let insertDateCount = 5
    
    //    var diary_Title:String?
    //    var diary_Contents:String?
    //    var diary_Date:String?
    //    var diary_Open:Int?
    //    var diary_Emotion:Int?
    
    func insertAction(_ diary_Title: String?, _ diary_Contents: String?, _ diary_Date: String?, _ diary_Emotion:Int?){
        
        print("welcome insert Action")
        
        let strQuery = "INSERT INTO Diary (diary_Title, diary_Contents, diary_Date, diary_Emotion) VALUES(?, ?, ?, ?)"
        
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Emoda.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        var stmt: OpaquePointer?
        if sqlite3_prepare(db, strQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert : \(errmsg)")
            return
        }
      
        
        if sqlite3_bind_text(stmt, 1, diary_Title, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name : \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, diary_Contents, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding dept : \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, diary_Date, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding phone : \(errmsg)")
            return
        }
        if sqlite3_bind_int(stmt, 4, Int32(diary_Emotion!) ) != SQLITE_OK{ //id는 인티져!! 따라서 SQLITE_TRANSIENT 필요없음!
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding id : \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting students : \(errmsg)")
            return
        }
    }
    
}
