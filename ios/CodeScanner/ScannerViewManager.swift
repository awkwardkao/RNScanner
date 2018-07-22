//
//  ScannerViewManager.swift
//  RNSCanner
//
//  Created by jacokao on 2018/7/14.
//  Copyright © 2018年 Facebook. All rights reserved.
//

import Foundation


@objc(ScannerViewManager)
class ScannerViewManager : RCTViewManager {
  
  override func view() -> UIView! {
    return ScannerView()
  }
  
  func doScanViaManager(_ node:NSNumber) {
    print("doScanViaManager")
    DispatchQueue.main.async {
      print("dispatch Queue For DoScan")
      let sview = self.bridge.uiManager.view(forReactTag: node) as! ScannerView
      sview.doScan()
    }
  }
}
