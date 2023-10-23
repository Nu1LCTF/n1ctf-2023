//
//  HTTRequest.m
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/11.
//

#import "HTTRequest.h"
#import <malloc/malloc.h>

@implementation HTTRequest
- (void)addMultiPartData:(NSString *)url {
        NSData *d = [[NSData alloc] initWithBase64EncodedString:url options:0];
        [self describeObject:@"NSData" :d];
        self.data = d;
    
}
- (void)describeObject:(NSString *)clz :(id)object {
    NSLog(@"%@ address = %p",clz , object);
    NSLog(@"%@ malloc_size = %ld",clz ,malloc_size((__bridge const void*)(object)));
}
@end


