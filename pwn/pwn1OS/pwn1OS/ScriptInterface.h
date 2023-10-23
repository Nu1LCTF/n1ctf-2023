//
//  ScriptInterface.h
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/6.
//

#import <Foundation/Foundation.h>
#import "Challenge.h"
//#import "CoreService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScriptInterface : NSObject
@property(nonatomic, strong) Challenge *challenge;
//@property(nonatomic, strong) NSData *data;
@end

NS_ASSUME_NONNULL_END
