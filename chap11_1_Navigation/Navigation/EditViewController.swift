//
//  EditViewController.swift
//  Navigation
//
//  Created by inooph on 2021/10/23.
//

import UIKit

class EditViewController: UIViewController {
    var textWayValue: String = ""
    var textMessage: String = ""
    
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var lblWay: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txtMessage.text = textMessage
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
