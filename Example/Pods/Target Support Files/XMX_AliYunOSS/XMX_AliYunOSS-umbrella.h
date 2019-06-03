#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DefaultOSSCredential.h"
#import "OSSCredential.h"
#import "CompressionStrategy.h"
#import "DefaultCompressionStrategy.h"
#import "NetworkCompressionStrategy.h"
#import "XMX_AliYunOSSUtils.h"

FOUNDATION_EXPORT double XMX_AliYunOSSVersionNumber;
FOUNDATION_EXPORT const unsigned char XMX_AliYunOSSVersionString[];

