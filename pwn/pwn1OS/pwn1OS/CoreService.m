//
//  CoreService.m
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/6.
//

#import "CoreService.h"

@implementation CoreService

- (instancetype)init {
    if (self = [super init]) {
        NSMethodSignature *signature = [CoreService instanceMethodSignatureForSelector:@selector(cancelAllRequests)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(cancelAllRequests)];
        self.cancelRequest = invocation;
    }
    return self;
}


- (void)dealloc {
    
    if (self.cancelRequest) {
        @try {
            [self.cancelRequest invoke];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    } else {
        NSLog(@"CoreService's invocation is nil.");
    }
}

- (void)cancelAllRequests {
    if(self.dataTask && [self.dataTask state] != NSURLSessionTaskStateCompleted) {
        [self.dataTask cancel];
    } else {
        NSLog(@"CoreService's request is completed.");
    }
}

@end
