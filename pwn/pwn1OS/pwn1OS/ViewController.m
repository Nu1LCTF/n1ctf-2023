//
//  ViewController.m
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/6.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "NoteBookViewController.h"
#import <JavaScriptCore/JSContext.h>

@interface ViewController ()
@property(nonatomic, assign) NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI {
    
    self.count = 0;
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTabBarHeight + kStatusBarHeight, kScreenWidth, 150)];
    [titileLabel setText:@"Welcome to N1CTF!"];
    [titileLabel setTextAlignment:NSTextAlignmentCenter];
    titileLabel.font = [UIFont fontWithName:@"PressStart2P-Regular" size:20];
    [self.view addSubview:titileLabel];
    titileLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)];
    [titileLabel addGestureRecognizer:labelTapGestureRecognizer];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didReceiveNotification:) name:@"openWebView" object:nil];
}

- (void)btnClick {
    self.count++;
    
    if (self.count < 10) {
        return;
    }
    
    NoteBookViewController *notebook = [NoteBookViewController new];
    [self.navigationController pushViewController:notebook animated:YES];
}

- (void)didReceiveNotification:(NSNotification *)notify {
    
    NSURL *url = (NSURL *)notify.object;
    NSString *scheme = url.scheme;
    NSString *host = url.host;
    if(![scheme isEqualToString:@"n1ctf"] || ![host isEqualToString:@"web"]) {
        return;
    }
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:url.absoluteString];
    NSMutableDictionary *kvs = [NSMutableDictionary new];
    for (NSURLQueryItem *item in components.queryItems) {
        [kvs setValue:item.value forKey:item.name];
    }
    if([kvs.allKeys containsObject:@"url"]) {
        
        WebViewController *web = [WebViewController new];
        web.urlString= kvs[@"url"];
        [self.navigationController pushViewController:web animated:YES];
    }
}



@end
