//
//  ScannerView.swift
//  RNSCanner
//
//  Created by jacokao on 2018/7/14.
//  Copyright © 2018年 Facebook. All rights reserved.
//


import UIKit
import AVFoundation
/*

class ScannerView : UIViewController, AVCaptureMetadataOutputObjectsDelegate {
  
  var captureSession : AVCaptureSession!
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.black
    
    
    let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    do {
      let input = try AVCaptureDeviceInput(device: videoCaptureDevice)
      
      captureSession = AVCaptureSession()
      captureSession?.addInput(input)
      
      
    } catch {
      print(error)
      return
    }
  }
}
*/

class ScannerView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let label = UILabel(frame: CGRect(x:0, y:0, width:100, height:50))
    label.text = "This is Swift"
    self.addSubview(label)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) ha not been implement")
  }
  
}
 
