//
//  MainViewController.swift
//  instogram
//
//  Created by Eros on 2017/3/27.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class MainViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let imagePicker = UIImagePickerController()
//    @IBOutlet weak var imageViewer: UIImageView!
    var ref: FIRDatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
//        ref.observe(.value, with: { (snapshot) in
//            if let value = snapshot.value as? [String: Any]{
//                debugPrint(value)
//            }
//        })
        ref.observe(.childAdded, with: { (snapshot) in
            if let value = snapshot.value as? [String: Any]{
                debugPrint(value)
            }
        })
        
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String: Any]{
                debugPrint(value)
            }
        })
    }
    
    @IBAction func SignOut(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
    }
    
    @IBAction func TakePicTap(_ sender: Any) {
        
        if UIImagePickerController.isCameraDeviceAvailable( UIImagePickerControllerCameraDevice.front) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            present(imagePicker, animated: true, completion: nil)
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if let imageData = UIImageJPEGRepresentation(image, 0.7) {
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            let imageRef = FIRStorage.storage().reference().child("photo.jpg")
            imageRef.put(imageData, metadata: metadata) { metadata, error in
                guard let metadata = metadata else{
                    print("上傳檔案錯誤")
                    return
                }
                print("上傳完成")
                
            
            }
        }
        
    }
    
    
   
}
