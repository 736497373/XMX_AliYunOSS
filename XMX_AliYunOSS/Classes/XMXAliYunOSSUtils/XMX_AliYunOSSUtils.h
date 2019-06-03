//
//  XMX_AliYunOSSUtils.h
//  XMX_AliYunOSS
//
//  Created by 736497373 on 05/31/2019.
//  Copyright (c) 2019 736497373. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OSSClient.h"
#import "OSSModel.h"
#import "CompressionStrategy.h"
#import "DefaultCompressionStrategy.h"
#import "NetworkCompressionStrategy.h"

#import "DefaultOSSCredential.h"

typedef void (^OSSNetworkingUploadComplete) (NSError *error,NSString *url,NSString *key);

@interface XMX_AliYunOSSUtils : NSObject

@property (strong, nonatomic) OSSClient *ossClient;
@property (strong, nonatomic) NSString *imageBucket;
@property (strong, nonatomic) NSString *fileBucket;
@property (strong, nonatomic) NSString *vedioBucket;

@property (strong, nonatomic) NSString *imageBucketUrl;
@property (strong, nonatomic) NSString *fileBucketUrl;
@property (strong, nonatomic) NSString *vedioBucketUrl;

@property (strong, nonatomic) id<CompressionStrategy> compressionStrategy;


+ (XMX_AliYunOSSUtils *)sharedInstance;


- (void)registerWithEndpoint:(NSString *)endpoint
                 ImageBucket:(NSString *)imageBucket
                  FileBucket:(NSString *)fileBucket
                 VedioBucket:(NSString *)vedioBucket
              ImageBucketUrl:(NSString *)ImageBucketUrl
               FileBucketUrl:(NSString *)FileBucketUrl
              VedioBucketUrl:(NSString *)vedioBucketUrl
         CompressionStrategy:(id)compressionStrategy
          CredentialProvider:(OSSCustomSignerCredentialProvider *)credentialProvider;

/*!
 @method
 @brief 上传图片到OSS
 @result 上传任务，可进行取消或同步等操作
*/
- (OSSTask *)uploadImageWithData:(NSData *)data withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete;

/*!
 @method
 @brief 上传图片到OSS
 @result 上传任务，可进行取消或同步等操作
 */
- (OSSTask *)uploadImage:(UIImage *)image withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete;

/*!
 @method
 @brief 上传图片到OSS
 @result 上传任务，可进行取消或同步等操作
 */
- (OSSTask *)uploadImageWithUrl:(NSURL *)url withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete;

/*!
 @method
 @brief 上传文件到OSS
 @result 上传任务，可进行取消或同步等操作
 */
- (OSSTask *)uploadFile:(NSData *)fileData withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete;

/*!
 @method
 @brief 上传文件到OSS
 @result 上传任务，可进行取消或同步等操作
 */
- (OSSTask *)uploadFileWithUrl:(NSURL *)url withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete;

/*!
 @method
 @brief 上传视频到OSS
 @result 上传任务，可进行取消或同步等操作
 */
- (OSSTask *)uploadVedio:(NSData *)vedioData withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete;

/*!
 @method
 @brief 上传视频到OSS
 @result 上传任务，可进行取消或同步等操作
 */
- (OSSTask *)uploadVedioWithUrl:(NSURL *)url withKey:(NSString *)key uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress uploadComplete:(OSSNetworkingUploadComplete)uploadComplete;


@end
