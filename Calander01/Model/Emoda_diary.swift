//
//  Emoda.swift
//  Calander01
//
//  Created by binybing on 17/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import Foundation

class Emoda_diary{
    var diary_Seqno : Int
    var diary_Emotion : Int?
    var diary_Title : String?
    var diary_Contents : String?
    var diary_Date : String?

    
    init(diary_Seqno: Int){
        self.diary_Seqno = diary_Seqno
    }
    
    init(diary_Seqno: Int, diary_Emotion:Int?, diary_Title:String?, diary_Contents:String?, diary_Date:String?) {
        // DB에 있는걸 받아와서 배열에 어펜드로 넣어야함!!!
        
        self.diary_Seqno = diary_Seqno
        self.diary_Emotion = diary_Emotion
        self.diary_Title = diary_Title
        self.diary_Contents = diary_Contents
        self.diary_Date = diary_Date
        
    }
}
