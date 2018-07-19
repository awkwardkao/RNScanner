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
}
