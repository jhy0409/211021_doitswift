//
//  ViewController.swift
//  Navigation
//
//  Created by inooph on 2021/10/23.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    
    var isOn = true
    var isZoom = false
    var orgZoom = false
    
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }
    
    // MARK: - 세그웨이 이용해 화면 전환
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        if segue.identifier == "editButton" { // 버튼 클릭
            editViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" { // 바 버튼 클릭
            editViewController.textWayValue = "segue : use Bar button"
        }
        // MARK: - 수정화면으로 텍스트메시지, 전구상태 전달
        editViewController.textMessage = txtMessage.text!
        editViewController.isOn = isOn
        editViewController.isZoom = orgZoom
        editViewController.delegate = self
    }
    
    // MARK: - 메시지 값을 텍스트 필드에 표시
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txtMessage.text = message // 뷰컨 텍스트필드에 할당
    }
    
    // MARK: - 아래 수정버튼
    @IBAction func btnGoEdit(_ sender: UIButton) {
        let editViewController = self.storyboard?.instantiateViewController(identifier: "View2") as! EditViewController
        self.navigationController?.pushViewController(editViewController, animated: true)
        editViewController.textWayValue = "use Storyboard ID"
    }
    
    // MARK: - 전구 이미지 값 세팅
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        
        if isZoom {
            if orgZoom {
                
            } else {
                self.isZoom = false
                self.orgZoom = true
                newWidth = imgView.frame.width * scale
                newHeight = imgView.frame.height * scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            }
            print("Zoom: true")
        } else {
            if orgZoom {
                self.isZoom = true
                self.orgZoom = false
                newWidth = imgView.frame.width / scale
                newHeight = imgView.frame.height / scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            } else {
                
            }
            print("Zoom: false")
        }
        print("🟢 isZoom : \(isZoom) \nVC self.isZoom : \(self.isZoom) / self.orgZoom : \(self.orgZoom)")
    }
}

