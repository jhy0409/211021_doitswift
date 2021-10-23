//
//  ViewController.swift
//  DatePicker
//
//  Created by inooph on 2021/10/22.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblPickerTime: UILabel!
    
    let timeSelector: Selector = #selector(DateViewController.updateTime)
    let interval = 1.0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 1초마다, 해당뷰를, 함수실행(timeSelector, 사용자정보, 반복
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEE HH:mm:ss" // 년-월-일 요일 시:분:초
        formatter.locale = Locale(identifier: "ko_KR")
        lblPickerTime.text = "선택시간 : \(formatter.string(from: datePickerView.date))"
    }
    
    @objc func updateTime() { // 1초마다 변수값을 1증가 -> 라벨 텍스트 내용으로 할당
//        lblCurrentTime.text = String(count)
//        count = count + 1
        
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEE HH:mm:ss"
        formatter.locale = Locale(identifier: "ko_KR")
        lblCurrentTime.text = "현재시간 : \(formatter.string(from: date as Date))"
    }
    
}

