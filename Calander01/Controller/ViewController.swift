//
//  ViewController.swift
//  Calander01
//
//  Created by binybing on 16/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import FSCalendar
var insertDate = ""
var diaryEmotion:Int?
var diaryTitle:String?
var diaryContent:String?
var diaryOpen:Int?
var diarySeqno:Int = 0
// 통계 페이지로 넘길 값
var emotionStatisticsTemp = [0]
let imageTitle = [1,2,3,4,5,6]

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var btnStatics: UIButton!
    var selectDate : [Date] = []
    var intDate = [Int]()
    var emodaDiary = [Emoda_diary]()
    var emotionAndDate : [(date:Date, emotion:Int)] = []
    var index = 0
    
    let insertViewController = InsertViewController.self
    
    //그림 표시 위한 변수 선언
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCalendar()
        
        readValues()
        
        setupSQL()
        // 버튼 라운드
        btnStatics.layer.cornerRadius = 4
 
        
    }
    
    
    
    func checkLogin()->Int{
        let selectSQL = SelectSQL()
        let checkNum = selectSQL.checkId()
        
        return checkNum
    }
    
    
    
    func setupSQL(){
        let settingSQL = SettingSQL()
        settingSQL.setUp()
    }
    
    
    
    func setCalendar(){
        calendar.allowsMultipleSelection = false //여러날짜를 동시에 선택할 수 있도록
        calendar.clipsToBounds = true //달력 구분 선 제거
        
        calendar.delegate = self
        calendar.dataSource = self
        
        //calendar.scrollDirection = .vertical// 수직으로 스크롤
    }
    
    func readValues(){
        selectDate.removeAll()
        emotionAndDate.removeAll()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectSQL = SelectSQL()
        //print(emodaDiary.count, "callData-view controller")
        emodaDiary = selectSQL.SelectAllAction()
        for i in 0 ..< emodaDiary.count {
            selectDate.append(dateFormatter.date(from: emodaDiary[i].diary_Date!)!)
            emotionAndDate.append((dateFormatter.date(from:emodaDiary[i].diary_Date!)!,emodaDiary[i].diary_Emotion!))
            //print(emotionAndDate[i])
        }
        self.calendar.reloadData()
        statisticsOfEmotion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        index = 0
        readValues()
        
        diaryEmotion = 0
        diaryTitle = ""
        diaryContent = ""
        diaryOpen = 0
        diarySeqno = 0
        
    }
    
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        //print(dateFormatter.string(from: date))
        insertDate = dateFormatter.string(from: date)
        checkDetail()
            insertView()
    }
    
    func checkDetail(){
        let selectSQL = SelectSQL()
        let checkData = selectSQL.checkDetail(date: insertDate)
        print(insertDate)
        print(checkData.diary_Seqno )
        if checkData.diary_Seqno != 0{
            diaryEmotion = checkData.diary_Emotion!
            diaryTitle = checkData.diary_Title!
            diaryContent = checkData.diary_Contents!
            diarySeqno = checkData.diary_Seqno
        }
        
    }
    
    // return 값 만큼 도트를 찍는다.
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    
    
    // 달력 생성 시 이미지를 설정한다.
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        //let day: Int! = self.gregorian.component(.day, from: date)
        //return emotionAndDate.contains(where: date) ? UIImage(named: "\(emotionAndDate[2].emotion)") : nil
        var imgInt = 0
        for i in 0 ..< emodaDiary.count{
            if emotionAndDate[i].date == date{
                imgInt = emotionAndDate[i].emotion
            }
        }
        return UIImage(named: "\(imgInt)")
        //return selectDate.contains(date) ? UIImage(named: "\(emotionAndDate[0].emotion)") : nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return selectDate.contains(date) ? CGPoint.init(x: 0.0, y: 5.0) : CGPoint.init(x: 0.0, y: 0.0)
    }
    
    
    func insertView(){
        // StoryBoard를 통해 두번째 화면의 StoryBoard ID를 참조하여 뷰 컨트롤러를 가져옵니다.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "insertBoard") else{
            return
        }
        
        //화면 전환 애니메이션을 설정합니다.
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        uvc.modalPresentationStyle = .fullScreen
        
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
        self.present(uvc, animated: true)
        
    }

    
    // 조회된 데이터 중 diary_Emotion만 별도로 변수에 저장 후 통계 페이지에서 사용
       func statisticsOfEmotion() {
           emotionStatisticsTemp.removeAll()
           var emotionStatistics = [0,0,0,0,0,0]
           for i in 0 ..< emodaDiary.count {
               switch emodaDiary[i].diary_Emotion {
               case 1:
                   emotionStatistics[0] += 1
                   break
               case 2:
                   emotionStatistics[1] += 1
                   break
               case 3:
                   emotionStatistics[2] += 1
                   break
               case 4:
                   emotionStatistics[3] += 1
                   break
               case 5:
                   emotionStatistics[4] += 1
                   break
               case 6:
                   emotionStatistics[5] += 1
                   break
               default:
                   break
               }
           }
           emotionStatisticsTemp = emotionStatistics
      
       }
    
    
    
    @IBAction func btnPushPressed(_ sender: UIBarButtonItem) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "pushAlertView") else{
            return
        }
        
        //화면 전환 애니메이션을 설정합니다.
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        uvc.modalPresentationStyle = .fullScreen
        
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
        self.present(uvc, animated: true)
    }
    
}

