//
//  EventEmitter.swift
//  RNSCanner
//
//  Created by jeff on 2018/7/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

import Foundation


@objc(EventEmitter)
class EventEmitter: RCTEventEmitter {
  
  @objc
  override func supportedEvents() -> [String]! {
    return ["event1","event2"]
  }
}
