//
//  DoneCaptureViewController.swift
//  instogram
//
//  Created by Eros on 2017/4/2.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit

class DoneCaptureViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var capturedImageRef = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(capturedImageRef)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        imageView.image = capturedImageRef
//        imageView.image = UIImage(data: imageData!)
    }
    
}
