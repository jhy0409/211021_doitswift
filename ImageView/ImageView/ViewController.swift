//
//  ViewController.swift
//  ImageView
//
//  Created by inooph on 2021/10/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnResize: UIButton!
    
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        
        imgView.image = imgOn
    }
    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale: CGFloat = 2.0
        var newWidth : CGFloat, newHeight: CGFloat
        
        if isZoom { // true - 확대상태이면 /2, 축소상태이므로 버튼내용을 반대로
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            btnResize.setTitle("확대", for: .normal)
            print("True - isZoom : \(isZoom), w : \(newWidth), h : \(newHeight)")
        } else { // false - 축소상태이면 *2, 확대중이므로 버튼내용을 반대로
            newWidth = imgView.frame.width * scale
            newHeight = imgView.frame.height * scale
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            btnResize.setTitle("축소", for: .normal)
            print("False - isZoom : \(isZoom), w : \(newWidth), h : \(newHeight)")
        }
        isZoom = !isZoom
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
    }
    
}

