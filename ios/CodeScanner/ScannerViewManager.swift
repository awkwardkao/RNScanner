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
  
  func doTouchLightViaManager(_ node:NSNumber) {
    print("doTouchLightViaManager")
    DispatchQueue.main.async {
      print("dispatch Queue For do touch light")
      let sview = self.bridge.uiManager.view(forReactTag: node) as! ScannerView
      sview.doTouchlight()
    }
  }
  
  func sendEvent() {
    if let eventEmitter = self.bridge.module(for: EventEmitter.self) as? EventEmitter {
      eventEmitter.sendEvent(withName: "event1", body: "test")
    }
  }
  
  func fetchScanCode( _ node:NSNumber,
                      resolver resolve: @escaping RCTPromiseResolveBlock,
                      rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    
    let sview = self.bridge.uiManager.view(forReactTag: node) as! ScannerView
    
    print("fetchScanCode ")
    DispatchQueue.main.async {
      print("dispatch Queue For Fetch")
      
      sview.doScan()
    }
    
    /*
    
    var mode = -1
    while(mode != 2) {
      mode = sview.getMode()
      print(mode)
      if(mode == 2) {
        break      }
      print(mode)
    }
    print("scan value ")
    print(sview.scanValue)
    resolve(sview.scanValue)
 */
    /*
    if(sview.doScan()) {
      print("call resolve")
      print(resolve)
      resolve(1)
    } else {
      print("call rject")
      reject("-9","fail",nil)
    }*/
  }
}
