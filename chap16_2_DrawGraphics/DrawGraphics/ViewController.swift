//
//  ViewController.swift
//  DrawGraphics
//
//  Created by inooph on 2021/10/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawFlower()
    }
    
    func drawFlower() {
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // 줄기
        context.setLineWidth(3.0)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setFillColor(UIColor.green.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 200))
        context.addLine(to: CGPoint(x: 200, y: 450))
        context.addLine(to: CGPoint(x: 140, y: 450))
        context.addLine(to: CGPoint(x: 170, y: 200))
        context.fillPath()
        context.strokePath()
        
        
        // 꽃
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.addEllipse(in: CGRect(x: 120, y: 150, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120+50, y: 150, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120-50, y: 150, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120, y: 150-50, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120, y: 150+50, width: 100, height: 100)) 
        context.strokePath()
 
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
}
