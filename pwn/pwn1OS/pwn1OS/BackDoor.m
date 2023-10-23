//
//  BackDoor.m
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/6.
//

#import "BackDoor.h"

@implementation BackDoor
+ (void)getFlag:(NSString *)urlString {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flag" ofType:nil];
    NSString *flag = [[NSData dataWithContentsOfFile:path] base64Encoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, flag]];
    [NSData dataWithContentsOfURL:url];
}
@end
