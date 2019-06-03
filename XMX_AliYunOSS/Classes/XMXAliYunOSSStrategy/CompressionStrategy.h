//
//  CompressionStrategy.h
//  XMX_AliYunOSS
//
//  Created by 736497373 on 05/31/2019.
//  Copyright (c) 2019 736497373. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CompressionStrategy <NSObject>

-(NSData *)compressionStrategyPercentWithImage:(UIImage *)image;

@end
