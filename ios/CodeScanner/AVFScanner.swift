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
  var codeFrameView: UIView?
  var messageLabel : UILabel?
  
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("DidLoad")
    
    // initial background color
    view.backgroundColor = UIColor.black
    
    // get camera device
    let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    do {
      
      let input = try AVCaptureDeviceInput(device: captureDevice)
      captureSession = AVCaptureSession()
      captureSession?.addInput(input)
      
    } catch let error as NSError {
      
      print (error)
      
    }
    
    let messageLabel = UILabel(frame: CGRect(x:5, y:5, width:100, height:50))
    messageLabel.text = "-------"
    //view.addSubview(messageLabel)
    
    let btn = UIButton(frame: CGRect(x:5,y:5,width:50,height:50))
    //btn.titleLabel?.text = "start scanning"
    btn.setTitle("SCAN", for: .normal)
    //btn.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
    view.addSubview(btn)
    
    
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    previewLayer.frame = CGRect(x:view.frame.width * 0.1 , y:view.frame.height * 0.1, width:view.frame.width * 0.7 , height:view.frame.height * 0.7) //view.layer.bounds
    view.layer.addSublayer(previewLayer)
    
    let captureMetadataOutput = AVCaptureMetadataOutput()
    captureSession?.addOutput(captureMetadataOutput)
    
    captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
    
    print(captureMetadataOutput.availableMetadataObjectTypes)
    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    
    print(captureMetadataOutput)
    
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AVFScanner.updateTimer), userInfo: nil, repeats: true)
    
    
    captureSession?.startRunning()
    
    
    /*
    let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    do {
      let input = try AVCaptureDeviceInput(device: videoCaptureDevice)
      
      captureSession = AVCaptureSession()
      captureSession?.addInput(input)
      
      codeFrameView = UIView()
      if let codeFrameView = codeFrameView {
        codeFrameView.layer.borderColor = UIColor.green.cgColor
        codeFrameView.layer.borderWidth = 2
        codeFrameView.layer.frame = CGRect(x:30 , y:100, width:view.frame.width * 0.5 , height:view.frame.height * 0.5)
        
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
    
    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue()) //DispatchQueue.main)
    captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes //[AVMetadataObjectTypeQRCode]
    
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
    previewLayer?.frame = CGRect(x:10 , y:60, width:view.frame.width * 0.7 , height:view.frame.height * 0.7) //view.layer.bounds
    view.layer.addSublayer(previewLayer)
    
    captureSession.startRunning()*/
  }
  
  func updateTimer() {
    print("update")
  }
  
  func buttonClicked() {
    print("Button Clicked")
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if (captureSession.isRunning == false) {
      captureSession.startRunning();
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if (captureSession.isRunning == true) {
      captureSession.stopRunning();
    }
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
      print("log")
    for data in metadataObjects {
      let metaData = data as! AVMetadataObject
      print(metaData.description)
      
      let transformed = previewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
      
      if let unwraped = transformed {
        print(unwraped.stringValue)
        
        messageLabel?.text = unwraped.stringValue
        print("result :"+unwraped.stringValue)
        //btnStartStop.setTitle("Start", for: .normal)
        
        //self.performSelector(onMainThread: #selector(stopReading), with: nil, waitUntilDone: false)
        //isReading = false
      }
    }
  }
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    for data in metadataObjects {
      let metaData = data //as! AVMetadataObject
      print(metaData.description)
      
      let transformed = previewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
      
      if let unwraped = transformed {
        print(unwraped.stringValue)
        
        messageLabel?.text = unwraped.stringValue
        print("result :"+unwraped.stringValue)
        //btnStartStop.setTitle("Start", for: .normal)
        
        //self.performSelector(onMainThread: #selector(stopReading), with: nil, waitUntilDone: false)
        //isReading = false
      }
    }
  }
  
  //func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
  //func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
   // captureSession.stopRunning()
    
   // messageLabel?.text = "Receive Data"
    
    /*
    if metadataObjects == nil || metadataObjects.count == 0 {
      codeFrameView?.frame = CGRect.zero
      messageLabel?.text = "No Code is detected"
      return
      
    }
 */
    
   // let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
   // let codeObject = previewLayer?.transformedMetadataObject(for: metadataObj)
    
    //codeFrameView?.frame = codeObject!.bounds
    
    //if metadataObj.stringValue != nil {
    //  messageLabel?.text = metadataObj.stringValue
   // }
    
    
    
  //}
}
