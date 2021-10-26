//
//  ViewController.swift
//  PinchGesture
//
//  Created by inooph on 2021/10/25.
//

import UIKit

class ViewController: UIViewController {

    var initialFontSize: CGFloat! // 글자크기 저장변수
    @IBOutlet weak var txtPinch: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UIPinchGestureRecognizer 클래스 상수 pinch 선언
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch) // 핀치 제스처 등록
    }

    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        if(pinch.state == UIPinchGestureRecognizer.State.began) { // 핀치시작
            initialFontSize = txtPinch.font.pointSize // 라벨의 폰트크기 저장
            print("\ninitialFontSize : \(initialFontSize!)")
        } else { // 핀치 종료
            txtPinch.font = txtPinch.font.withSize(initialFontSize * pinch.scale) // 라벨 폰트크기 = 기존 값 * 확대배율
            print("txtPinch.font : \(txtPinch.font.pointSize) / initialFontSize : \(initialFontSize!)")
        }
    }
}

