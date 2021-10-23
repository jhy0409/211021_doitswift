//
//  ViewController.swift
//  Navigation
//
//  Created by inooph on 2021/10/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        if segue.identifier == "editButton" { // 버튼 클릭
            editViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" { // 바 버튼 클릭
            editViewController.textWayValue = "segue : use Bar button"
        }
    }
    
    @IBAction func btnGoEdit(_ sender: UIButton) {
        let editViewController = self.storyboard?.instantiateViewController(identifier: "View2") as! EditViewController
        self.navigationController?.pushViewController(editViewController, animated: true)
        editViewController.textWayValue = "use Storyboard ID"
    }

}

