//
//  ScriptInterface.m
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/6.
//

#import "ScriptInterface.h"
#import "CoreService.h"
#import "N1CTFIntroduction.h"
#import "HTTRequest.h"
#import <malloc/malloc.h>

@implementation ScriptInterface
@synthesize challenge = _challenge;

- (void)setChallenge:(Challenge *)challenge {
    if (_challenge != challenge) {
        _challenge = challenge;
    }
}

- (Challenge *)challenge {
    @try {
        if(!_challenge) {
            _challenge = [Challenge new];
            _challenge.owner = @"N1CTF is a jeopardy style CTF held by team Nu1L.";
        }
        NSLog(@"%@", _challenge.owner);
        return  _challenge;
    } @catch (NSException *exception) {
        Class obj = NSClassFromString(@"WebScriptObject");
        SEL throwException = NSSelectorFromString(@"throwException:");
        ((void (*)(id, SEL, NSString *))[obj methodForSelector:throwException])(obj, throwException, [exception reason]);
        return nil;
    } @finally {
    }
}

- (N1CTFIntroduction *)makeN1CTFIntroduction {
    
    N1CTFIntroduction *ctf = [[N1CTFIntroduction alloc] init];
    [self describeObject:@"N1CTFIntroduction" :ctf];
    return ctf;
}
- (HTTRequest *)makeHTTRequest {
    return [HTTRequest new];
}
//- (void)addMultiPartData:(NSString *)url {
////    NSData *d = [[NSData alloc] initWithBase64EncodedString:data options:0];
////    [self describeObject:@"NSData" :d];
////    self.data = d;
//    
////    NSString *url1 = @"data:text/html;base64,QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB";
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSData *d = [NSData dataWithData:data];
//        [self describeObject:@"NSData" :d];
//        self.data = d;
//        dispatch_semaphore_signal(semaphore);
//    }];
//    if(task) {
//        [task resume];
//    }
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//}

- (CoreService *)makeCoreService {
    CoreService *core = [[CoreService alloc] init];
    [self describeObject:@"CoreService" :core];
    return core;
}

- (void)test {
    NSLog(@"test");
}

- (void)dealloc {}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector {
    return NO;
}

- (void)describeObject:(NSString *)clz :(id)object {
    NSLog(@"%@ address = %p",clz , object);
    NSLog(@"%@ malloc_size = %ld",clz ,malloc_size((__bridge const void*)(object)));
}

- (void)DEBUGLOG:(NSString *)log {
    
    NSLog(@"N1CTF DEBUG LOG: %@", log);
}

@end
