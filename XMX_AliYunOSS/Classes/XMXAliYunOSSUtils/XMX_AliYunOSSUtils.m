//
//  XMX_AliYunOSSUtils.m
//  XMX_AliYunOSS
//
//  Created by 736497373 on 05/31/2019.
//  Copyright (c) 2019 736497373. All rights reserved.
//
#import "XMX_AliYunOSSUtils.h"
#import "OSSUtil.h"
#import "OSSService.h"
#import <AliyunOSSiOS/OSSService.h>
#import <AliyunOSSiOS/OSSCompat.h>
#import "NetworkCompressionStrategy.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

static XMX_AliYunOSSUtils *sharedInstance = nil;
@implementation XMX_AliYunOSSUtils

+ (XMX_AliYunOSSUtils *)sharedInstance{
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


- (void)registerWithEndpoint:(NSString *)endpoint
                 ImageBucket:(NSString *)imageBucket
                  FileBucket:(NSString *)fileBucket
                 VedioBucket:(NSString *)vedioBucket
              ImageBucketUrl:(NSString *)imageBucketUrl
               FileBucketUrl:(NSString *)fileBucketUrl
              VedioBucketUrl:(NSString *)vedioBucketUrl
         CompressionStrategy:(id)compressionStrategy
          CredentialProvider:(OSSCustomSignerCredentialProvider *)credentialProvider {
    
    id<OSSCredentialProvider> credential = credentialProvider;
    _ossClient = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    _imageBucket = imageBucket;
    _fileBucket = fileBucket;
    _vedioBucket = vedioBucket;
    
    _imageBucketUrl = imageBucketUrl;
    _fileBucketUrl = fileBucketUrl;
    _vedioBucketUrl = vedioBucketUrl;
    
    _compressionStrategy = compressionStrategy;
}



- (OSSTask *)uploadImage:(UIImage *)image withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
    NSData *data = [_compressionStrategy compressionStrategyPercentWithImage:image];
    return [self uploadObjectWithData:data withKey:key bucket:_imageBucket bucketUrl:_imageBucketUrl uploadProgress:uploadProgress uploadComplete:uploadComplete];
}

- (OSSTask *)uploadImageWithData:(NSData *)data withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
    return [self uploadObjectWithData:data withKey:key bucket:_imageBucket bucketUrl:_imageBucketUrl uploadProgress:uploadProgress uploadComplete:uploadComplete];
}

- (OSSTask *)uploadImageWithUrl:(NSURL *)url withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
    return [self uploadObjectWithUrl:url withKey:key bucket:_imageBucket bucketUrl:_imageBucketUrl uploadProgress:uploadProgress uploadComplete:uploadComplete];
}

- (OSSTask *)uploadFile:(NSData *)fileData withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
    return [self uploadObjectWithData:fileData withKey:key bucket:_fileBucket bucketUrl:_fileBucketUrl uploadProgress:uploadProgress uploadComplete:uploadComplete];
}

- (OSSTask *)uploadFileWithUrl:(NSURL *)url withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
     return [self uploadObjectWithUrl:url withKey:key bucket:_fileBucket bucketUrl:_fileBucketUrl uploadProgress:uploadProgress uploadComplete:uploadComplete];
}

- (OSSTask *)uploadVedio:(NSData *)vedioData withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
    return [self uploadObjectWithData:vedioData withKey:key bucket:_vedioBucket bucketUrl:_vedioBucketUrl uploadProgress:uploadProgress uploadComplete:uploadComplete];
}

- (OSSTask *)uploadVedioWithUrl:(NSURL *)url withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
    return [self uploadObjectWithUrl:url withKey:key bucket:_vedioBucket bucketUrl:_vedioBucketUrl uploadProgress:uploadProgress uploadComplete:uploadComplete];
}

- (OSSTask *)uploadObjectWithData:(NSData *)data withKey:(NSString *)key bucket:(NSString *)bucket bucketUrl:(NSString *)bucketUrl uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
    if (![self checkOSSVaild:uploadComplete]){
        return nil;
    }
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = bucket;
    put.objectKey = key;
    put.uploadingData = data;
    put.uploadProgress = uploadProgress;
    
    return [self putObject:put bucketUrl:bucketUrl uploadComplete:uploadComplete];
}

- (OSSTask *)uploadObjectWithUrl:(NSURL *)url withKey:(NSString *)key bucket:(NSString *)bucket bucketUrl:(NSString *)bucketUrl uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
    if ([self checkOSSVaild:uploadComplete]){
        return nil;
    }
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = bucket;
    put.objectKey = key;
    put.uploadingFileURL = url;
    put.uploadProgress = uploadProgress;
    return [self putObject:put bucketUrl:bucketUrl uploadComplete:uploadComplete];
}

- (BOOL)checkOSSVaild:(OSSNetworkingUploadComplete)uploadComplete{
    if (_ossClient == nil) {
        if( uploadComplete != nil ){
            NSError *error = [[NSError alloc] init];
            uploadComplete(error,nil,nil);
        }
        return NO;
    }
    return YES;

}

- (OSSTask *)putObject:(OSSPutObjectRequest *)put bucketUrl:(NSString *)bucketUrl uploadComplete:(OSSNetworkingUploadComplete)uploadComplete{
    OSSTask *putTask = [_ossClient putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if(uploadComplete != nil){
            NSString *key = put.objectKey;
            NSString *url = [NSString stringWithFormat:@"%@/%@",bucketUrl,key];
            uploadComplete(task.error,url,key);
        }
        return nil;
    }];
    return putTask;
}
@end
