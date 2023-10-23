//
//  BackDoor.h
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackDoor : NSObject
+ (void)getFlag:(NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
