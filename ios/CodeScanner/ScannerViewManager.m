//
//  ScannerViewManager.m
//  RNSCanner
//
//  Created by jeff on 2018/7/14.
//  Copyright © 2018年 Facebook. All rights reserved.
//


#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE (ScannerViewManager,RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(scanValue, NSString)
RCT_EXTERN_METHOD(doScanViaManager:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(doTouchLightViaManager:(nonnull NSNumber *)node)


RCT_EXTERN_METHOD(fetchScanCode:(nonnull NSNumber *)node resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseResolveBlock)reject)

//RCT_EXTERN_METHOD(callScanViaManager:(RCTPromiseResolveBlock)resolve   rejecter:(RCTPromiseRejectBlock)reject))


@end
