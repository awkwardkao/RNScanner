//
//  ResultManager.m
//  RNSCanner
//
//  Created by jacokao on 2018/7/25.
//  Copyright © 2018年 Facebook. All rights reserved.
//


#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(ResultManager, NSObject)

RCT_EXTERN_METHOD(checkValue:(NSNumber) dur
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  )

@end
