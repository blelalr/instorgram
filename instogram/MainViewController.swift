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

class MainViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var tableView: UITableView!
    
    var ref: FIRDatabaseReference!
    var postsRef:  FIRDatabaseReference!
//    var dataSource = PhotoCellDataSource()
    var dataSource: FUITableViewDataSource!
    var Posts = [Post](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 478
        
        ref = FIRDatabase.database().reference()

        postsRef = ref.child("posts")
        dataSource = tableView.bind(to: postsRef) { tableView, indexPath, snapshot -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as! PhotoCell

            if let psotData = snapshot.value as? [String: Any] {
                cell.accountLabel.text = psotData["email"] as? String
                    
//                cell.messageLabel.text = Posts[indexPath.row].email
                
                cell.postImage.sd_setImage(with: URL(string: psotData["imageURL"] as! String))

            }
    
            return cell
        }
        
        
//        download()

    }
    
//    func download() {
//        Post.downloadLatestArticles { (Posts, error) in
//            if let error = error {
//                print("\(error)")
//                return
//            }
//            if let Posts = Posts {
//                self.Posts = Posts
//                self.dataSource.Posts = Posts
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
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
        let postKey = postRef.key
        
        let currentUser = (FIRAuth.auth()?.currentUser)!
        
        var postData: [String: Any] = [
            "authorUID": currentUser.uid,
            "email": currentUser.email!,
            "imagePath":"",
            "imageURL":"",
            "postDate":""
        ]
        
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
                postData["imagePath"] = imageRef.fullPath
                postData["imageURL"] = metadata.downloadURL()!.absoluteString
                let postDate = Int(round(Date().timeIntervalSince1970 * 1000))
                postData["postDate"] = postDate
                postData["postDateReverse"] = -postDate
                
                postRef.updateChildValues(postData)
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
