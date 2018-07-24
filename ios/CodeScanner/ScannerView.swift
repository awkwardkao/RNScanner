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


*/

class ScannerView: UIView {
  
  var codeScanner: AVFScanner?
  
  var scanValue : String? {
    get {
      print("call scan value ")
      
      return codeScanner?.scanValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    //let label = UILabel(frame: CGRect(x:0, y:0, width:100, height:50))
    //label.text = "This is Swift"
    //self.addSubview(label)
    
    print("init")
    codeScanner = AVFScanner()
    //print(codeScanner)
    //codeScanner.view.frame = self.bounds
    self.addSubview(codeScanner!.view)
    
  }
  
  func doScan() -> Bool {
    print("call dos can on scanview")
    print(codeScanner)
    return codeScanner!.doScan()
  }
  
  func getMode() -> Int {
    print("mode ")
    print(codeScanner!.mode)
    return codeScanner!.mode
  }
  
  func doTouchlight() {
    print("call do touch light")
    codeScanner?.touchLight()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) ha not been implement")
  }
  
}

