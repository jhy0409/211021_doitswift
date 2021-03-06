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
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate?
    var isOn = false
    var isZoom = false
    
    @IBOutlet weak var lblWay: UILabel!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var swIsOn: UISwitch!
    @IBOutlet weak var btnZoom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        lblWay.text = textWayValue
        txtMessage.text = textMessage
        swIsOn.isOn = isOn
        
        if isZoom {
            btnZoom.setTitle("์ถ์", for: UIControl.State())
        } else {
            btnZoom.setTitle("ํ๋", for: UIControl.State())
        }
        print("๐ด viewDidLoad - isZoom : \(isZoom)")
    }
    
    @IBAction func btnDone(_ sender: UIButton) { 
        if delegate != nil { // ๋ทฐ์ปจ prepare์์ ํ ๋น๋์ด ๋ค์ด์ด, ์๋ง๋ทฐ์ปจ & ํ์คํธํ๋ ๋ด์ฉ ์ฌํ ๋น
            delegate?.didMessageEditDone(self, message: txtMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
            print("๐  func btnDone - isZoom : \(isZoom)")
        }
        navigationController?.popViewController(animated: true) // ๋ฉ์ธํ๋ฉด์ผ๋ก ์ด๋
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        } 
    }
    
    @IBAction func btnImageZoom(_ sender: UIButton) {
        if isZoom {
            isZoom = false
            btnZoom.setTitle("ํ๋", for: UIControl.State())
        } else {
            isZoom = true
            btnZoom.setTitle("์ถ์", for: UIControl.State())
        }
        print("๐ก btnImageZoom - isZoom : \(isZoom) ")
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
