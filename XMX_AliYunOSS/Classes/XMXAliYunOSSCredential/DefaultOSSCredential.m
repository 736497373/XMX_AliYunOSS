//
//  DefaultOSSCredential.m
//  XMX_AliYunOSS
//
//  Created by 谢茂雄 on 2019/6/3.
//

#import "DefaultOSSCredential.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>

@implementation DefaultOSSCredential


static DefaultOSSCredential *sharedInstance = nil;


+ (DefaultOSSCredential *)sharedInstance{
    @synchronized(self) {
        if (sharedInstance == nil) {
            return [[self alloc] init];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone{
    @synchronized(self) {
        if ( sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return  nil;
}

- (id)copyWithZone: (NSZone *)zone{
    return self;
}

- (id<OSSCredentialProvider>)getOSSCredentialProviderByOnwerWithAccessKey:(NSString *)accessKey AccessSecret:(NSString *)accessSecret ProviderError:(NSError *)providerError{
    id<OSSCredentialProvider> credential = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
        NSString *signature = [OSSUtil calBase64Sha1WithData:contentToSign withSecret:accessSecret];
        if (signature != nil) {
            *error = nil;
        }
        else{
            *error = providerError;
            return nil;
        }
        return [NSString stringWithFormat:@"OSS %@:%@", accessKey, signature];
    }];
    return credential;
}

- (id<OSSCredentialProvider>)getOSSCredentialProviderByServerWithBlock:(void(^)(OSSFederationToken *token,dispatch_semaphore_t sem))block {
    id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken *{
        __block OSSFederationToken *token = [[OSSFederationToken alloc] init];
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        if (block) {
            block(token,sem);
        }
       dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        return token;
    }];
    return credential;
}


@end
