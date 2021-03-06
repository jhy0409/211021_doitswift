//
//  ViewController.swift
//  TapTouch
//
//  Created by Ho-Jeong Song on 2020/11/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var txtMessage: UILabel!
    @IBOutlet var txtTapCount: UILabel!
    @IBOutlet var txtTouchCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - [ㅇ] 터치시작
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch // 현재 발생한 터치이벤트 가져옴
        
        txtMessage.text = "Touches Began"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    
    // MARK: - [ㅇ] 터치된 손가락 움직였을 때
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Moved"
        txtTapCount.text = String(touch.tapCount) // touches 세트 안에 포함된 터치 개수 출력 -> 연속으로 몇번 탭?
        txtTouchCount.text = String(touches.count) // 터치 객체 중 첫번째 객체에서 탭의 갯수를 가져옴 -> 몇개의 손가락 터치했는지?
    }
    
    // MARK: - [ㅇ] 화면에서 손가락 뗐을 때
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Ended"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
}

