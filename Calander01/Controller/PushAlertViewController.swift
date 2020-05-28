//
//  PushAlertViewController.swift
//  Calander01
//
//  Created by binybing on 26/05/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class PushAlertViewController: UIViewController {
    var hour: String?
    var minute: String?
    @IBOutlet weak var btnPush: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        
        // 버튼 라운드
        btnPush.layer.cornerRadius = 4
        
        // MARK: option에 원하는 옵션 / 마크 신기, 강조된다
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert], completionHandler: {(didAllow, Error) in
            print("Authorization : \(didAllow)") // 권한 여부
        })
        
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        
        
    }
    
    
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
        let pickedDate = sender // 별도의 변수에 저장 받아야 하단부 기능이 정상 작동
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        let strTime = (formatter.string(from: pickedDate.date).split(separator: ":"))

        hour = String(strTime[0])
        minute = String(strTime[1])
        
        
    }
    
    

    @IBAction func btnBackPressed(_ sender: UIBarButtonItem) {
        
           self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnPushPressed(_ sender: UIButton) {
        
                // Setting content of the notification
                let content = UNMutableNotificationContent()
                content.title = "Emoda"
                content.subtitle = "How was your day?"
                content.body = "Do write about your emotion!"

                // Setting time for notification trigger
                var dateComponents = DateComponents()
                dateComponents.hour = Int(hour!)
                dateComponents.minute = Int(minute!)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        /*
                Trigger의 두 유형에 대해 필요 시 조사
                1. Use UNCalendarNotificationTrigger // 이번에 사용한 방법
                2. Use TimeIntervalNotificationTrigger
            
                Apple은 블로그 내용에 따르면 총 4개의 트리거를 제공
        */
                // Adding Request
                // identifier는 알람이 많아질 경우 식별하기 위해 사용하는 것으로 보임
                let request = UNNotificationRequest(identifier: "done", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }


}




extension ViewController: UNUserNotificationCenterDelegate {
    // To display notifications when app is running inforeground
    // viewDidLoad()에 UNUserNotificationCenter.current().delegate = self 추가
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
    }
   
}
