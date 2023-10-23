//
//  N1CTFIntroduction.m
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/7.
//

#import "N1CTFIntroduction.h"

@implementation N1CTFIntroduction
- (instancetype)init {
    if (self = [super init]) {
        self.name = @"N1CTF 2023";
        self.time = @"2023-10-21 00:00 UTC,48h";
        self.website = @"https://ctf2023.nu1l.com/";
        self.rating_weight = @"97.33";
        self.discord = @"https://discord.gg/dtn8Qp5cbN";
    }
    return self;
}

@end
