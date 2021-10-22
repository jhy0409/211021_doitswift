//
//  ViewController.swift
//  DatePicker
//
//  Created by inooph on 2021/10/22.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var count = 0
    var alarmTime: String?
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm aaa"
        formatter.locale = Locale(identifier: "ko_KR")
        lblPickerTime.text = "선택시간 : \(formatter.string(from: datePickerView.date))"
        
        alarmTime = formatter.string(from: datePickerView.date)
    }
    @objc func updateTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm aaa"
        formatter.locale = Locale(identifier: "ko_KR")
        lblCurrentTime.text = "현재시간 : \(formatter.string(from: date as Date))"
        
        let currentTime = formatter.string(from: date as Date)
        if(alarmTime == currentTime) {
            view.backgroundColor = UIColor.red
        } else {
            view.backgroundColor = UIColor.white
        }
    }

}

