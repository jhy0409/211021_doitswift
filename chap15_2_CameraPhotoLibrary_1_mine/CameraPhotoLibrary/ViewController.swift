//
//  ViewController.swift
//  CameraPhotoLibrary
//
//  Created by inooph on 2021/10/25.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var flagImageSave = false
    var numImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            numImage += 1
            
            if numImage > 3 { numImage = 1 }
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            numImage += 1
            
            if numImage>3 { numImage = 1}
            
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    @IBAction func btnClearImage(_ sender: UIButton) {
        numImage = 0
        
        imgView1.image = nil
        imgView2.image = nil
        imgView3.image = nil
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            if numImage == 1 { imgView1.image = captureImage}
            else if numImage == 2 { imgView2.image = captureImage}
            else if numImage == 3 { imgView3.image = captureImage}
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        numImage = numImage - 1
        if numImage<0 { numImage = 0}
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

