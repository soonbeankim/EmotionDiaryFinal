//
//  BarChartViewController.swift
//  Calander01
//
//  Created by binybing on 26/05/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class BarChartViewController: UIViewController {

    @IBOutlet weak var imageViewEmotion: UIImageView!
    @IBOutlet weak var basicBarChart: BasicBarChart!
    
    // chart 항목의 수
       private let numEntry = emotionStatisticsTemp.count
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
       override func viewDidAppear(_ animated: Bool) {
            let dataEntries = generateDataEntries()
            basicBarChart.updateDataEntries(dataEntries: dataEntries, animated: false)
        }
        
        // 데이터를 받아 화면 만들어주는 기능
        func generateDataEntries() -> [DataEntry] {
            // Custom Color : #Color Literal
            let colors = [#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.9981295466, green: 0.721668601, blue: 0.6307073236, alpha: 1), #colorLiteral(red: 0.6650223136, green: 0.7216776013, blue: 0.7302500606, alpha: 1),#colorLiteral(red: 0.3729856312, green: 0.5851404071, blue: 0.577994585, alpha: 1), #colorLiteral(red: 0.7624815106, green: 0.8439856172, blue: 0.8153397441, alpha: 1), #colorLiteral(red: 0.964186132, green: 0.8198686838, blue: 0.7684211135, alpha: 1) ]
            var result: [DataEntry] = []
            var max = 0
            for i in 0..<numEntry {
                // value를 받아 높이를 만듦
                let value = emotionStatisticsTemp[i]
                let height: Float = Float(value) / 30
                
                if i > 0{
                    if emotionStatisticsTemp[max] < emotionStatisticsTemp[i]{
                        max = i

                    }
                }
//                else {
//                }
                let emotionTitle = ["awkward","happy","angry","sad","gloomy","so so"]
                
                result.append(DataEntry(color: colors[i], height: height, textValue: "\(value)", title: emotionTitle[i]))
                
                
            }
            imageViewEmotion.image = UIImage(named: "\(imageTitle[max])")
            return result
        }
    

        
    }

