//
//  TakePhotoViewController.swift
//  instogram
//
//  Created by Eros on 2017/3/30.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import AVFoundation

class TakePhotoViewController: UIViewController {

    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var error: NSError?
    override func viewDidLoad() {
        super.viewDidLoad()
        let devices = AVCaptureDevice.devices().filter{ ($0 as AnyObject).hasMediaType(AVMediaTypeVideo) && ($0 as AnyObject).position == AVCaptureDevicePosition.back }
        if let captureDevice = devices.first as? AVCaptureDevice  {
            do {
                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
            }
            catch _ {
                print("ERROR!!")
            }
            captureSession.sessionPreset = AVCaptureSessionPresetPhoto
            captureSession.startRunning()
            stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
            if captureSession.canAddOutput(stillImageOutput) {
                captureSession.addOutput(stillImageOutput)
            }
            if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                previewLayer.bounds = view.bounds
                
                previewLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                let cameraPreview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.size.width, height: view.bounds.size.width))
                cameraPreview.layer.addSublayer(previewLayer)
                cameraPreview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.saveToCamera(_:))))
                view.addSubview(cameraPreview)
            }
        }
    }
    
    func saveToCamera(_ sender: UITapGestureRecognizer) {
        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo) {
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, nil, nil, nil)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



