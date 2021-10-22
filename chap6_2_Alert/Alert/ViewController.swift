//
//  ViewController.swift
//  Alert
//
//  Created by inooph on 2021/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblPickerTime: UILabel!
    var count = 0
    let selectorUpdate: Selector = #selector(updateTime)
    let interval = 1.0
    var alarmTime: String?
    var alertFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: selectorUpdate, userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "hh:mm:ss aaa"
        lblCurrentTime.text = "현재시간 : \(formatter.string(from: date as Date))"
        
        formatter.dateFormat = "hh:mm aaa"
        let currentTime = formatter.string(from: date as Date)
        
        
        if currentTime == alarmTime {
            if !alertFlag {
                let alarmAlert = UIAlertController(title: "알림", message: "설저된 시간입니다.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "네 알겠습니다.", style: .default, handler: nil)
                
                alarmAlert.addAction(okAction)
                present(alarmAlert, animated: true, completion: nil)
                alertFlag = true
            }
        } else {
            alertFlag = false
        }
    }

    @IBAction func dateSelected(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm aaa"
        formatter.locale = Locale(identifier: "ko_KR")
        alarmTime = formatter.string(from: sender.date)
        lblPickerTime.text = "선택시간 : \(formatter.string(from: sender.date))"
    }
    
}

