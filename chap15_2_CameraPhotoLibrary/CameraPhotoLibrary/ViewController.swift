//
//  ViewController.swift
//  CameraPhotoLibrary
//
//  Created by inooph on 2021/10/25.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage! // 촬영및 포토라이브러리에서 불러온 사진 저장할 변수
    var videoURL: URL! // 녹화한 비디오의 URL을 저장할 변수
    var flagImageSave = false // 이미지 저장 여부를 나타낼 변수
    
    
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - [ㅇ] 사진촬영
    @IBAction func btnCaptureImgFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) { // 카메라 사용 가능하면
            flagImageSave = true // 사진저장 플래그
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes =  [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            // 뷰에 imagePicker가 보이게 함
            present(imagePicker, animated: true, completion: nil)
        } else { // 카메라 사용할 수 없을 때 경고창
            myAlert("Camera inaccessable", message: "Application cannot access the camera")
        }
    }
    
    // MARK: - [ㅇ] 사진 불러오기
    @IBAction func btnLoadImgFromLibrary(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true // 편집허용
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    // MARK: - [ㅇ] 비디오 촬영
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    // MARK: - [ㅇ] 비디오 불러오기
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    // MARK: - [ㅇ] 촬영 및 선택 끝났을 때 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) { // 미디어가 사진이면
            //사진 가져옴
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            if flagImageSave { // 이미지저장이 true -> 포토 라이브러리에 저장
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            imgView.image = captureImage // 가져온 사진을 이미지뷰에 출력
            
        } else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) { // 미디어가 비디오
            if flagImageSave { // 저장이 true
                // 비디오 가져옴
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                // 비디오 포토 라이브러리에 저장
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        // 현재뷰(이미지피커) 제거
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - [ㅇ] 사진 또는 비디오 미촬영 & 미선택시 호출
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

