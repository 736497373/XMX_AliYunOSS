//
//  DefaultOSSCredential.h
//  XMX_AliYunOSS
//
//  Created by 谢茂雄 on 2019/6/3.
//

#import <Foundation/Foundation.h>
#import "OSSCredential.h"
NS_ASSUME_NONNULL_BEGIN

@interface DefaultOSSCredential : NSObject <OSSCredential>


+ (DefaultOSSCredential *)sharedInstance;


- (id<OSSCredentialProvider>)getOSSCredentialProviderByOnwerWithAccessKey:(NSString *)accessKey AccessSecret:(NSString *)accessSecret ProviderError:(NSError *)providerError;


- (id<OSSCredentialProvider>)getOSSCredentialProviderByServerWithBlock:(void(^)(OSSFederationToken *token,dispatch_semaphore_t sem))block;

@end

NS_ASSUME_NONNULL_END
