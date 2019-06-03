# XMX_AliYunOSS

[![CI Status](https://img.shields.io/travis/736497373/XMX_AliYunOSS.svg?style=flat)](https://travis-ci.org/736497373/XMX_AliYunOSS)
[![Version](https://img.shields.io/cocoapods/v/XMX_AliYunOSS.svg?style=flat)](https://cocoapods.org/pods/XMX_AliYunOSS)
[![License](https://img.shields.io/cocoapods/l/XMX_AliYunOSS.svg?style=flat)](https://cocoapods.org/pods/XMX_AliYunOSS)
[![Platform](https://img.shields.io/cocoapods/p/XMX_AliYunOSS.svg?style=flat)](https://cocoapods.org/pods/XMX_AliYunOSS)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

XMX_AliYunOSS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XMX_AliYunOSS' ,:git => 'https://github.com/736497373/XMX_AliYunOSS'

```

## Usage

### 使用远程配置签名
```ruby

OSSCustomSignerCredentialProvider *credentialProviderByServer = [[DefaultOSSCredential sharedInstance] getOSSCredentialProviderByServerWithBlock:^(OSSFederationToken * _Nonnull token, dispatch_semaphore_t  _Nonnull sem) {
// 在此处发送请求获取凭证信息设置token 
token.tAccessKey = .accessKeyId;
token.tSecretKey = .accessKeySecret;
token.expirationTimeInGMTFormat = .expiration;
token.tToken = .securityToken;

// 设置完token后更新等待信号量
dispatch_semaphore_signal(sem);
}];
```


### 使用本地自签名
```ruby

// 本地配置accessKey accessSecret
NSString *accessKey = @"";
NSString *accessSecret = @"";

NSError * error = [NSError errorWithDomain:@"www.xxxxxx.com" code:-1001 userInfo:nil];
OSSCustomSignerCredentialProvider  *credentialProviderByOnwer = [[DefaultOSSCredential sharedInstance] getOSSCredentialProviderByOnwerWithAccessKey:accessKey AccessSecret:accessSecret ProviderError:error];
```



### 压缩策略
```ruby

NetworkCompressionStrategy 基于AFNetworkReachabilityStatus提供了默认压缩策略
DefaultCompressionStrategy 不压缩

若需要自定义压缩策略 
遵循CompressionStrategy协议重写-(NSData *)compressionStrategyPercentWithImage:(UIImage *)image;
```

### 配置参数
```ruby

NSString *endpoint = @"";
NSString *bucket = @"";
NSString *bucketUrl = @"";

NetworkCompressionStrategy *strategy = [[NetworkCompressionStrategy alloc] init];

[[XMX_AliYunOSSUtils sharedInstance] registerWithEndpoint:endpoint ImageBucket:bucket FileBucket:bucket VedioBucket:bucket ImageBucketUrl:bucketUrl FileBucketUrl:bucketUrl VedioBucketUrl:bucketUrl CompressionStrategy:strategy CredentialProvider:credentialProviderByServer];

```


### 上传
```ruby

[[XMX_AliYunOSSUtils sharedInstance] uploadImage: withKey: uploadProgress:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
NSLog(@"上传中。。。");
} uploadComplete:^(NSError *error, NSString *url, NSString *key) {
if (error) {
NSLog(@"上传失败。。。");
return ;
}
NSLog(@"上传成功。。。url = %@ key = %@",url,key);
}];
```
## Author



736497373, 736497373@qq.com

## License

XMX_AliYunOSS is available under the MIT license. See the LICENSE file for more info.
