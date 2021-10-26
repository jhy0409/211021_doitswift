//
//  ViewController.swift
//  PinchGesture
//
//  Created by inooph on 2021/10/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgPinch: UIImageView!
    var initialFontSize: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }

    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        // 이미지를 스케일에 맞게 변환
        imgPinch.transform = imgPinch.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1 // 핀치스케일 속성을 1로 설정
        print(pinch.scale)
    }
}

