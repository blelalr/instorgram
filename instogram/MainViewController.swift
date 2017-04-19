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
import FirebaseDatabaseUI
import SDWebImage
import SVProgressHUD

class PhotoCell: UITableViewCell{
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
}

class MainViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var tableView: UITableView!
    
    var ref: FIRDatabaseReference!
    var postsRef: FIRDatabaseReference!
    var commentsRef: FIRDatabaseReference!
//    var dataSource = PhotoCellDataSource()
    var dataSource: FUITableViewDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 478
        
        ref = FIRDatabase.database().reference()
        postsRef = ref.child("posts")
        commentsRef = ref.child("comments")
        
        let query = postsRef.queryOrdered(byChild: "postDateReverse")
        dataSource = tableView.bind(to: query) { tableView, indexPath, snapshot -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as! PhotoCell

            if let psotData = snapshot.value as? [String: Any] {
                cell.accountLabel.text = psotData["email"] as? String
                cell.postImage.sd_setImage(with: URL(string: psotData["imageURL"] as! String))

            }
    
            return cell
        }
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)

        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let postRef = postsRef.childByAutoId()
        let commentRef = postRef
        let postKey = postRef.key
        
        let currentUser = (FIRAuth.auth()?.currentUser)!
        
        if let imageData = UIImageJPEGRepresentation(image, 0.7) {
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            let imageRef = FIRStorage.storage().reference().child("photos/\(postKey).jpg")
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.showProgress(0, status: "上傳中")
            
            let uploadTask = imageRef.put(imageData, metadata: metadata) { metadata, error in
                SVProgressHUD.dismiss()
                guard let metadata = metadata else{
                    print("上傳檔案錯誤")
                    return
                }
                //upload finish
                print("上傳完成")
                debugPrint(metadata)
                debugPrint(metadata.downloadURL()!)
                
                //
                let post = Post()
                post.authorUID = currentUser.uid
                post.email = currentUser.email
                post.imagePath = imageRef.fullPath
                post.imageURL = metadata.downloadURL()!.absoluteString
                let postDate = Int(round(Date().timeIntervalSince1970 * 1000))
                post.postDate = postDate
                post.postDateReverse = -postDate

                postRef.updateChildValues(Post().toDictionary(from: post))
                commentRef.updateChildValues(["id": imageRef.fullPath])
                
            }
            
            uploadTask.observe(.progress, handler:{ (snapshot) in
                guard let progress = snapshot.progress else {
                    return
                }
                SVProgressHUD.showProgress(Float(progress.fractionCompleted))
            })
            
        }
        
    }
    
    
   
}
