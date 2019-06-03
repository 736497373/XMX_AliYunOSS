//
//  NetworkCompressionStrategy.h
//  XMX_AliYunOSS
//
//  Created by 736497373 on 05/31/2019.
//  Copyright (c) 2019 736497373. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CompressionStrategy.h"

#define CompressThresholdWifi (1024 * 1024  * 2.0 )  //2MB
#define CompressThreshold5G   (1024 * 1024  * 1.0)   //1MB
#define CompressThreshold4G   (1024 * 1024  * 1.0)   //1MB
#define CompressThreshold3G   (1024 * 1024 * 0.5)          //0.5MB
#define CompressThreshold2G   (1024 * 1024 * 0.5)          //0.5MB
#define CompressThresholdNo   (1024 * 1024 * 0.5)          //0.5MB
@interface NetworkCompressionStrategy : NSObject<CompressionStrategy>

@end
