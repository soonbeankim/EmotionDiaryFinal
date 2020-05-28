//
//  SelectSQL.swift
//  Calander01
//
//  Created by binybing on 17/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import Foundation
import SQLite3

class SelectSQL{
    
    var db: OpaquePointer?
    
    
    func checkId() -> Int {
        
        var returnNum = 0
        var userEmail = "none"
        var userNickName = "none"
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Emoda.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        var stmt: OpaquePointer?
        let strQuery = "SELECT * FROM UserInfo"
        
        if sqlite3_prepare(db, strQuery, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return returnNum
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            userEmail = String(cString: sqlite3_column_text(stmt, 0))
            userNickName = String(cString: sqlite3_column_text(stmt, 1))
           
            print(userEmail,userNickName)
            returnNum = 1
        }
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure check user id: \(errmsg)")
        }
        
        return returnNum
    }
    
    
    
    
    func SelectAllAction() -> [Emoda_diary]{
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Emoda.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        var stmt: OpaquePointer?
        let strQuery = "SELECT * FROM Diary"
        
        var returnList = [Emoda_diary]()
        
        if sqlite3_prepare(db, strQuery, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return returnList
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let diary_Seqno = sqlite3_column_int(stmt, 0)
            let diary_Emotion = sqlite3_column_int(stmt, 1)
            let diary_Title = String(cString: sqlite3_column_text(stmt, 2))
            let diary_Contents: String = String(cString: sqlite3_column_text(stmt, 3))
            
            let diary_Date = String(cString: sqlite3_column_text(stmt, 4))
            
            
            returnList.append(Emoda_diary(diary_Seqno: Int(diary_Seqno), diary_Emotion: Int(diary_Emotion), diary_Title: diary_Title, diary_Contents: diary_Contents, diary_Date: diary_Date))
            
            //print(diary_Date,diary_Emotion,diary_Title,diary_Contents,diary_Seqno,"selectSQL")
        }
        
        return returnList
    }
    
    
    func checkDetail(date:String) -> Emoda_diary{
        print("1")
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Emoda.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        var stmt: OpaquePointer?
        let strQuery = "SELECT * FROM Diary where diary_Date = '\(date)'"
        // print(date, "in checkDetail")
        
        if sqlite3_prepare(db, strQuery, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            
        }
        
        var returnList = Emoda_diary(diary_Seqno: 0)
        
        print("2")
        while (sqlite3_step(stmt) == SQLITE_ROW){
            print("3")
            let diary_Seqno = sqlite3_column_int(stmt, 0)
            let diary_Emotion = sqlite3_column_int(stmt, 1)
            let diary_Title = String(cString: sqlite3_column_text(stmt, 2))
            let diary_Contents: String = String(cString: sqlite3_column_text(stmt, 3))
            
            let diary_Date = String(cString: sqlite3_column_text(stmt, 4))
           
            
            let List = Emoda_diary(diary_Seqno: Int(diary_Seqno), diary_Emotion: Int(diary_Emotion), diary_Title: diary_Title, diary_Contents: diary_Contents, diary_Date: diary_Date)
            //print("test : " ,returnList)
            
            returnList = List
            //            return returnList
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure sellect Diary : \(errmsg)")
            
        }
        
        return returnList
    }
    
}



