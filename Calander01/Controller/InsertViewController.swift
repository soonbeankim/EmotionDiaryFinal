//
//  InsertViewController.swift
//  Calander01
//
//  Created by binybing on 17/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate {
    
    var imageArray = [UIImage?]()

    var emodaDiary = [Emoda_diary]()
    
    //insert할 내용
    var diary_Emotion = 0
    var diary_Title = ""
    var diary_Content = ""
//    var diary_Open = 0
    var diary_Seqno = 0
    
    var cnt = 0
    
    @IBOutlet weak var pickerImage: UIPickerView!
    
    @IBOutlet weak var delOutlet: UIButton!
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var lblTitle: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImgArray()
        
        if diarySeqno != 0 {
           
            //delOutlet.isHidden = false
            updateView()
                pickerImage.selectRow((diaryEmotion!-1), inComponent: 0, animated: false)
               
        }else{
        delOutlet.isHidden = true
        }
        viewStart()
        
        // 버튼 라운드
        btnDone.layer.cornerRadius = 4
        btnDelete.layer.cornerRadius = 4
        
    }
    
    func viewStart(){
        label.text = insertDate
        //textview place holder
    }
    
    func updateView(){
        lblTitle.text = diaryTitle
        contents.text = diaryContent

        let diaryE = diaryEmotion! - 1
        imageView.image = imageArray[diaryE]
    }
    
    
    
    //pickerView
    
    func setImgArray(){
        for i in 1..<7{
            let image = UIImage(named: "\(i)")
            imageArray.append(image)
        }
        imageView.image = imageArray[0]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        imageArray.count
    }
    
    //선택된 파일명을 레이블 및 이미지뷰에 출력
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //lblImage.text = imageFileName[row]
        imageView.image = imageArray[row]
    }

    
    // Title(파일 이름/이미지)
      func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
          let pickerImageView = UIImageView(image: UIImage(named: String(imageTitle[row])))
              pickerImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
         diary_Emotion = imageTitle[row]

          return pickerImageView
      }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        let pickerHeight: CGFloat = 40
        return pickerHeight
    }
    
    
    @IBAction func btnBackPressed(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnInsert(_ sender: UIButton) {
     
        diary_Title = lblTitle.text!
        diary_Content = contents.text!
        

        
        if diarySeqno != 0 {
            updateDiary(title: diary_Title, contents: diary_Content)
        }else{
        insertDiary(title: diary_Title, contents: diary_Content)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnDelete(_ sender: UIButton) {
        
        let deleteSQL = DeleteSQL(dataId: 3)
        deleteSQL.deleteDiary(seqno: diarySeqno)
    }
    
    
    
    
    func insertDiary(title:String, contents:String){
        
        let insertSQL = InsertSQL()
        insertSQL.insertAction(title, contents, insertDate, diary_Emotion)
    }
    
    func updateDiary(title:String, contents:String){
        
        let updateSQL = UpdateSQL()
        updateSQL.update(title, contents, insertDate, diary_Emotion, diarySeqno)
        
    }
    
    
    
    //키보드 숨기기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
    
}
