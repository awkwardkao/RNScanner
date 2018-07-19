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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    //let label = UILabel(frame: CGRect(x:0, y:0, width:100, height:50))
    //label.text = "This is Swift"
    //self.addSubview(label)
    
    let codeScanner = AVFScanner()
    self.addSubview(codeScanner.view)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) ha not been implement")
  }
  
}

