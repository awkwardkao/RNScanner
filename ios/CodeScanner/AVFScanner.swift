//
//  AVFScanner.swift
//  RNSCanner
//
//  Created by jacokao on 2018/7/19.
//  Copyright © 2018年 Facebook. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AVFScanner : UIViewController, AVCaptureMetadataOutputObjectsDelegate {
  
  var captureSession : AVCaptureSession!
  var previewLayer: AVCaptureVideoPreviewLayer!
  var codeFrameView:UIView?
  var messageLabel : UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //view.backgroundColor = UIColor.black
    
    
    let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    do {
      let input = try AVCaptureDeviceInput(device: videoCaptureDevice)
      
      captureSession = AVCaptureSession()
      captureSession?.addInput(input)
      
      codeFrameView = UIView()
      if let codeFrameView = codeFrameView {
        codeFrameView.layer.borderColor = UIColor.green.cgColor
        codeFrameView.layer.borderWidth = 2
        
        view.addSubview(codeFrameView)
        view.bringSubview(toFront: codeFrameView)
        
      }
      
      let label = UILabel(frame: CGRect(x:5, y:5, width:100, height:50))
      label.text = "-------"
      view.addSubview(label)
      
      
    } catch {
      print(error)
      return
    }
    
    let captureMetadataOutput = AVCaptureMetadataOutput()
    captureSession?.addOutput(captureMetadataOutput)
    
    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
    previewLayer?.frame = CGRect(x:10 , y:60, width:view.frame.width, height:view.frame.height * 0.7) //view.layer.bounds
    view.layer.addSublayer(previewLayer)
    
    captureSession.startRunning()
  }
  
  func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
    
    captureSession.stopRunning()
    
    messageLabel?.text = "Receive Data"
    
    if metadataObjects == nil || metadataObjects.count == 0 {
      codeFrameView?.frame = CGRect.zero
      messageLabel?.text = "No Code is detected"
      return
      
    }
    
    let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
    let codeObject = previewLayer?.transformedMetadataObject(for: metadataObj)
    
    codeFrameView?.frame = codeObject!.bounds
    
    if metadataObj.stringValue != nil {
      messageLabel?.text = metadataObj.stringValue
    }
    
    
    
  }
}
