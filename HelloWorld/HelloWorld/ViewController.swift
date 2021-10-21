//
//  ViewController.swift
//  HelloWorld
//
//  Created by inooph on 2021/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbHello: UILabel!
    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSend(_ sender: UIButton) {
        let contents: String = txtName.text!.isEmpty ? "입력한 값이 없습니다33." : txtName.text!
        lbHello.text = "Hello, \(String(describing: contents))"
    }
    
}

