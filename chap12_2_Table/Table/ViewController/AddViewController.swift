//
//  AddViewController.swift
//  Table
//
//  Created by inooph on 2021/10/24.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var fileName = ""
    let MAX_ARRAY_NUM = 3
    let PICKER_VIEW_COMUMN = 1
    let PICKER_VIEW_HEIGHT:CGFloat = 40
    var imageArray = [UIImage?]()
    var imageFileName = [ "cart.png", "clock.png", "pencil.png" ]
    
    @IBOutlet weak var tvAddItem: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for i in 0..<itemsImageFile.count {
            let image = UIImage(named: itemsImageFile[i])
            imageFileArray.append(image!)
        }
        imgView.image = imageFileArray[0]
        fileName = imageFileName[0]
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tvAddItem.text!)
        itemsImageFile.append(fileName)
        tvAddItem.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        itemsImageFile.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageFileArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imgView.image = imageFileArray[row]
        fileName = imageFileName[row]
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
