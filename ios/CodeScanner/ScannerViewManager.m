//
//  ScannerViewManager.m
//  RNSCanner
//
//  Created by jacokao on 2018/7/14.
//  Copyright © 2018年 Facebook. All rights reserved.
//


#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE (ScannerViewManager,RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(scanValue, NSString)
RCT_EXTERN_METHOD(doScanViaManager:(nonnull NSNumber *)node)


@end
