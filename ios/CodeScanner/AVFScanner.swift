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
  var lightBtn : UIButton?
  
  var timer: Timer?
  
  var isReading = false
  
  //var userDefault :UserDefaults!
  
  //var mode = -1
  var mode: Int {
    get {
      return UserDefaults.standard.integer(forKey: "RunStep")//userDefault.integer(forKey: "RunStep")
    }
  }
  
  var scanValue:String? {
    get {
      return UserDefaults.standard.string(forKey: "ScannedValue")
    }
  }
  
 
  override func viewDidLoad() {
    super.viewDidLoad()
    print("DidLoad")
    //scanValue = "---"
    captureSession = nil
    
    messageLabel = UILabel(frame:CGRect(x:5,y:5,width:100,height:50))
    messageLabel!.text = "no qrcode"
    //view.addSubview(messageLabel!)
    
    lightBtn = UIButton(frame: CGRect(x:110,y:5,width:50,height:50))
    lightBtn!.setTitle("light", for: UIControlState.normal)
    lightBtn!.setTitle("Up", for: UIControlState.highlighted)
    lightBtn!.setTitleColor(UIColor.white, for: UIControlState.normal)
    lightBtn!.setTitleColor(UIColor.blue, for: UIControlState.highlighted)
    lightBtn!.isEnabled = true
    lightBtn!.backgroundColor = UIColor.blue
    lightBtn!.addTarget(self, action: #selector(touchLight), for: UIControlEvents.touchUpInside)
    lightBtn!.center = CGPoint(x:200, y:10)
    //view.addSubview(lightBtn!)
    
    //previewLayer.layer.cornerRadius = 5;
  }
  
  
  
  func startReading() -> Bool {
    print("Start Reading()")
    // initial background color
    //view.backgroundColor = UIColor.black
    //ResultManager.ScanValue = "----"

    UserDefaults.standard.setValue(-1, forKey: "RunStep")
    UserDefaults.standard.setValue("---", forKey: "ScannedValue")
    UserDefaults.standard.synchronize()
    
    // get camera device
    let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    print("Capture Touch State")
    print(captureDevice?.hasTorch)
    print(captureDevice?.isTorchActive)
    
    // set session and input
    do {
      
      let input = try AVCaptureDeviceInput(device: captureDevice)
      captureSession = AVCaptureSession()
      captureSession?.addInput(input)
      
    } catch let error as NSError {
      print (error)
      return false
    }
    
    
    // set preview
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    previewLayer.cornerRadius = 5
    //let prevFrame = CGRect(x:view.frame.width * 0.1, y:view.frame.height * 0.1 , width:view.frame.width * 0.6 , height:view.frame.height * 0.6)
    previewLayer.frame = view.layer.bounds//view.layer.bounds.insetBy(dx: 60.0, dy: 60.0) //prevFrame //CGRect(x:0 , y:0, width:view.frame.width , height:view.frame.height) //view.layer.bounds
    
    view.layer.addSublayer(previewLayer)
    
    codeFrameView = UILabel()
    codeFrameView!.layer.borderColor = UIColor.white.cgColor
    codeFrameView!.layer.cornerRadius = 5
    codeFrameView!.layer.borderWidth = 2
    //let codeFrame = CGRect(x:view.frame.width * 0.2 , y: view.frame.height * 0.2 , width:view.frame.width * 0.2 , height:view.frame.height * 0.2)
    codeFrameView!.layer.frame = view.layer.bounds;//view.layer.bounds.insetBy(dx:100.0, dy: 100.0) //codeFrame
    
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
    
    UserDefaults.standard.setValue(1, forKey: "RunStep")
    UserDefaults.standard.synchronize()
    //mode = 1
    //ResultManager.ScannedMode = 1
    return true
  }
  
  func touchLight() {
    print("touchLight")
    let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)//.defaultDeviceWithMediaType(AVMediaTypeVideo)
    if (device!.hasTorch) {
      do {
        print(device!.torchMode)
        try device!.lockForConfiguration()
        if (device!.torchMode == AVCaptureTorchMode.on) {
          device!.torchMode = AVCaptureTorchMode.off
        } else {
          do {
            try device!.setTorchModeOnWithLevel(1.0)
          } catch {
            print(error)
          }
        }
        device!.unlockForConfiguration()
      } catch {
        print(error)
      }
    } else {
      print (device?.description)
      print(device?.hasTorch)
      print(device?.hasFlash)
    }
  }
  
  func stopReading() {
    captureSession?.stopRunning()
    captureSession = nil
    previewLayer.removeFromSuperlayer()
    codeFrameView!.removeFromSuperview()
    timer?.invalidate()
    UserDefaults.standard.setValue(2, forKey: "RunStep")
    UserDefaults.standard.synchronize()
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
    
    
    
    for data in metadataObjects {
      let metaData = data as! AVMetadataObject
      print(metaData.description)
      
      let transformed = previewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
      
      if let unwraped = transformed {
        print(unwraped.stringValue)
        
        codeFrameView!.layer.borderColor = UIColor.green.cgColor
        
        messageLabel?.text = "Value"
        messageLabel?.text = unwraped.stringValue
        print("result :"+unwraped.stringValue)
       // scanValue = unwraped.stringValue
       // ResultManager.ScanValue = unwraped.stringValue
        UserDefaults.standard.setValue(unwraped.stringValue, forKey: "ScannedValue")
        UserDefaults.standard.synchronize()
        self.performSelector(onMainThread: #selector(stopReading), with: nil, waitUntilDone: false)
        isReading = false
      }
    }
    
    //captureSession.startRunning()
  }
  
  func doScan() -> Bool {
    print("doscan")
    if(self.startReading()) {
      print("staring...scan")
      return true
    } else {
      print("can't start scan")
      return false
    }
  }
  
}
