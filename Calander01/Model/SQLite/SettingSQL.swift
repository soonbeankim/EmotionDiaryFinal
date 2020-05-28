//
//  SettingSQL.swift
//  Calander01
//
//  Created by binybing on 17/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import Foundation

import SQLite3 //******이렇게 해야 sql명령어 쓸 수 있음!

class SettingSQL {
    
    var db:OpaquePointer? //오파크 포인터를 통해서 데이터 주고받기
    
    func setUp(){
        //print("setUp sql start")
        // SQLite 생성하기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Emoda.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Diary (diary_Seqno INTEGER PRIMARY KEY AUTOINCREMENT, diary_Emotion INTEGER, diary_Title TEXT, diary_Contents TEXT, diary_Date TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            
        }
        
        //내 아이디
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS UserInfo (user_Email TEXT PRIMARY KEY, user_NickName TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating user table: \(errmsg)")
        }
        
    }
}
