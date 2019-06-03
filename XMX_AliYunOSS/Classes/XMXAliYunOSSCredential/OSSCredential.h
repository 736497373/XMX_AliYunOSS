//
//  OSSCredential.h
//  XMX_AliYunOSS
//
//  Created by 谢茂雄 on 2019/6/3.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/AliyunOSSiOS.h>

@protocol OSSCredential <NSObject>

- (id<OSSCredentialProvider>)getOSSCredentialProviderByOnwerWithAccessKey:(NSString *)accessKey AccessSecret:(NSString *)accessSecret ProviderError:(NSError *__autoreleasing *)providerError;


- (id<OSSCredentialProvider>)getOSSCredentialProviderByServerWithBlock:(void(^)(OSSFederationToken *token))block;

@end


