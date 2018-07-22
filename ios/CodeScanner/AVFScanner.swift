//
//  AVFScanner.swift
//  RNSCanner
//
//  Created by jeff on 2018/7/19.
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
  
  var timer: Timer?
  
  var isReading = false
  
  var scanValue:String?
  
  
 
  override func viewDidLoad() {
    super.viewDidLoad()
    print("DidLoad")
    scanValue = "---"
    captureSession = nil
    //previewLayer.layer.cornerRadius = 5;
  }
  
  
  
  func startReading() -> Bool {
    print("Start Reading()")
    // initial background color
    //view.backgroundColor = UIColor.black
    
    // get camera device
    let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    // set session and input
    do {
      
      let input = try AVCaptureDeviceInput(device: captureDevice)
      captureSession = AVCaptureSession()
      captureSession?.addInput(input)
      
    } catch let error as NSError {
      print (error)
      return false
    }
    
    messageLabel = UILabel(frame: CGRect(x:5, y:5, width:100, height:50))
    messageLabel!.text = "no qrcode"
    view.addSubview(messageLabel!)
    
    
    
    // set preview
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    previewLayer.cornerRadius = 5
    previewLayer.frame = CGRect(x:0 , y:0, width:view.frame.width , height:view.frame.height) //view.layer.bounds
    
    view.layer.addSublayer(previewLayer)
    
    codeFrameView = UILabel()
    codeFrameView?.layer.borderColor = UIColor.green.cgColor
    codeFrameView?.layer.borderWidth = 2
    view.addSubview(codeFrameView!)
    view.bringSubview(toFront: codeFrameView!)
    
    // set ouptut result
    let captureMetadataOutput = AVCaptureMetadataOutput()
    captureSession?.addOutput(captureMetadataOutput)
    
    captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
    
    print(captureMetadataOutput.availableMetadataObjectTypes)
    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AVFScanner.updateTime), userInfo: nil, repeats: true)
    
    captureSession?.startRunning()
    return true
  }
  
  func stopReading() {
    captureSession?.stopRunning()
    captureSession = nil
    previewLayer.removeFromSuperlayer()
    timer?.invalidate()
    
  }
  
  // for keep
  func updateTime() {
    //print(Date())
  }
  
  // must add for keep session runn
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if (captureSession?.isRunning == false) {
      captureSession.startRunning();
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if (captureSession?.isRunning == true) {
      captureSession.stopRunning();
    }
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // on ouptut result process
  // for swift 3.0
  func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
      print("capture Output")
    
    //captureSession.stopRunning();
    
    if metadataObjects == nil {
      codeFrameView?.frame = CGRect.zero
    } else  {
      codeFrameView?.frame = view.layer.bounds//CGRect(x:view.frame.width * 0.1 , y:view.frame.height * 0.1, width:view.frame.width * 0.5 , height:view.frame.height  * 0.5)
    }
    
    for data in metadataObjects {
      let metaData = data as! AVMetadataObject
      print(metaData.description)
      
      let transformed = previewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
      
      if let unwraped = transformed {
        print(unwraped.stringValue)
        
        messageLabel?.text = "Value"
        messageLabel?.text = unwraped.stringValue
        print("result :"+unwraped.stringValue)
        scanValue = unwraped.stringValue
        self.performSelector(onMainThread: #selector(stopReading), with: nil, waitUntilDone: false)
        isReading = false
      }
    }
    
    //captureSession.startRunning()
  }
  
  func doScan() {
    print("doscan")
    if(self.startReading()) {
      print("staring...scan")
    } else {
      print("can't start scan")
    }
  }
  
}
