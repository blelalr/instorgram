//
//  TakePhotoViewController.swift
//  instogram
//
//  Created by Eros on 2017/3/30.
//  Copyright © 2017年 Eros. All rights reserved.
//

import UIKit
import AVFoundation
import ImageIO

class TakePhotoViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myView: UIView!
    
    let captureSession = AVCaptureSession()
    var captureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    let capturePhotoOutput = AVCapturePhotoOutput()
    var imageDetail: UIImage!
    var device: AVCaptureDevice?
//    var error: NSError?
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        device = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back)
        if let device = device {
            captureSession.addInput(try! AVCaptureDeviceInput(device: device))
            captureSession.addOutput(AVCapturePhotoOutput())
            captureVideoPreviewLayer.session = captureSession
            captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            myView.layer.addSublayer(captureVideoPreviewLayer)
            
        }
        captureSession.startRunning()

//        let devices = AVCaptureDevice.devices().filter{ ($0 as AnyObject).hasMediaType(AVMediaTypeVideo) && ($0 as AnyObject).position == AVCaptureDevicePosition.back }
//        
//        if let captureDevice = devices.first as? AVCaptureDevice  {
//            captureSession.addInput(try! AVCaptureDeviceInput(device: captureDevice))
//            captureSession.sessionPreset = AVCaptureSessionPresetPhoto
//            stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
//            if captureSession.canAddOutput(stillImageOutput) {
//                captureSession.addOutput(stillImageOutput)
//            }
//            
////            captureVideoPreviewLayer.session = captureSession
//            captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//            captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
//            
//            myView.layer.addSublayer(captureVideoPreviewLayer)
//            captureSession.startRunning()

        
        
    }
    
//    func saveToCamera(_ sender: UITapGestureRecognizer) {
//        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo) {
//            stillImageOutput.captureStillImageAsynchronously(from: videoConnection) {
//                (imageDataSampleBuffer, error) -> Void in
//                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
//                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, nil, nil, nil)
//            }
//        }
//    }
    
    @IBAction func startTap(_ sender: Any) {
    }
    
    @IBAction func stopTap(_ sender: Any) {
    }
    
    @IBAction func takeTap(_ sender: Any) {
//        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo) {
//            stillImageOutput.captureStillImageAsynchronously(from: videoConnection) {
//                (imageDataSampleBuffer, error) -> Void in
//                if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer){
//                    self.imageDetail = UIImage(data:imageData)
//                    self.performSegue(withIdentifier: "doneCaptureSeque", sender: self)
//                    
//                }
//                
//            }
//        }
        let setting = AVCapturePhotoSettings()
        let previewPixelType = setting.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: imageView.frame.size.width,
            kCVPixelBufferHeightKey as String: imageView.frame.size.height
        ] as [String : Any]
        setting.previewPhotoFormat = previewFormat
        
        if let output = captureSession.outputs.first as? AVCapturePhotoOutput{
            output.capturePhoto(with: setting, delegate: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DoneCaptureViewController
        destination.capturedImageRef = self.imageDetail
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureVideoPreviewLayer.frame = myView.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}



