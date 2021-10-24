//
//  EditViewController.swift
//  Navigation
//
//  Created by inooph on 2021/10/23.
//

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
}

class EditViewController: UIViewController {
    var textWayValue: String = ""
    var textMessage: String = ""
    var isOn = false
    var delegate: EditDelegate?
    
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var lblWay: UILabel!
    @IBOutlet weak var swIsOn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        lblWay.text = textWayValue
        txtMessage.text = textMessage
        swIsOn.isOn = isOn
    }
    
    @IBAction func btnDone(_ sender: UIButton) { 
        if delegate != nil { // 뷰컨 prepare에서 할당되어 들어옴, 에딧뷰컨 & 텍스트필드 내용 재할당
            delegate?.didMessageEditDone(self, message: txtMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
        }
        navigationController?.popViewController(animated: true) // 메인화면으로 이동
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        } 
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */ 
}
