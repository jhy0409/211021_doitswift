//
//  ViewController.swift
//  ImageViewer
//
//  Created by inooph on 2021/10/21.
//

import UIKit

class ViewController: UIViewController {
    var imageName = ["01.jpg", "02.jpg", "03.jpg", "04.jpg", "05.jpg", "06.jpg"]
    var index = 0
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnBefore: UIButton!
    @IBOutlet weak var btnAfter: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgView.image = UIImage(named: imageName[index])
    }
    
    
    @IBAction func btnPrev(_ sender: UIButton) {
        if index <= 0 {
            index = imageName.count - 1
        } else {
            index = index - 1
        }
        print("\n\n ---> \(index)")
        imgView.image = UIImage(named: imageName[index])
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        if index < 5 {
            index+=1
        } else {
            index = 0
        }
        print("\n\n ---> \(index)")
        imgView.image = UIImage(named: imageName[index])
    }
    
    
    
}

