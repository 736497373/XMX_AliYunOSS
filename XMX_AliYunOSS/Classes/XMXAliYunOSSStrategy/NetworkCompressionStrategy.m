//
//  NetworkCompressionStrategy.m
//  XMX_AliYunOSS
//
//  Created by 736497373 on 05/31/2019.
//  Copyright (c) 2019 736497373. All rights reserved.
//

#import "NetworkCompressionStrategy.h"
#import <AFNetworking/AFNetworking.h>
@implementation NetworkCompressionStrategy

-(NSData *)compressionStrategyPercentWithImage:(UIImage *)image{
    NSData *result = UIImageJPEGRepresentation(image, 1.0);
    
    AFNetworkReachabilityStatus networkState = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    CGFloat compressThreshold;
    switch (networkState) {
        case AFNetworkReachabilityStatusUnknown:
        case AFNetworkReachabilityStatusNotReachable:
            compressThreshold = CompressThresholdNo;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
             compressThreshold = CompressThreshold5G;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
             compressThreshold = CompressThresholdWifi;
            break;
        default:
            break;
    }
    NSLog(@"image size before = %ld", result.length);
    if (result.length > compressThreshold) {
        result = UIImageJPEGRepresentation(image, compressThreshold / result.length );
    }
    NSLog(@"image size after = %ld", result.length);
    return result;
}
@end
