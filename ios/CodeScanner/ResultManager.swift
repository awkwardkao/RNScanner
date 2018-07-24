//
//  ResultManager.swift
//  RNSCanner
//
//  Created by jeff on 2018/7/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//

import Foundation

@objc(ResultManager)
class ResultManager: RCTEventEmitter {
  // ...
  @objc func checkValue(_ dur: NSNumber,
                        resolver resolve: RCTPromiseResolveBlock,
                        rejecter reject: RCTPromiseRejectBlock) -> Void {
    
    print("check value")
    var mode = -1
    while(mode != 2) {
      mode = UserDefaults.standard.integer(forKey: "RunStep")
      print(mode)
      if(mode == 2) {
        break
        
      }
      usleep(200000)
      print(mode)
    }
    print("scan value ")
    let scanValue = UserDefaults.standard.string(forKey: "ScannedValue")
    print(scanValue)
    resolve(scanValue)
  }
  // ...
}
