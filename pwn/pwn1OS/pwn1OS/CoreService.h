//
//  CoreService.h
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/6.
//

#import "ScriptInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreService : ScriptInterface
@property(nonatomic, strong) NSInvocation *cancelRequest;
@property(nonatomic, strong) NSURLSessionDataTask *dataTask;
@property(nonatomic, strong) NSString *serviceName;
@end

NS_ASSUME_NONNULL_END
