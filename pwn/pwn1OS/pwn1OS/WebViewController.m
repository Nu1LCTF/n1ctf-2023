//
//  WebViewController.m
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/6.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ScriptInterface.h"

@interface WebScriptObject: NSObject
@end

@interface WebView
- (WebScriptObject *)windowScriptObject;
@end

@interface UIWebDocumentView: UIView
- (WebView *)webView;
@end

@interface WebViewController ()
@property(strong, nonatomic)UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString ? self.urlString : @"http://172.16.113.54:9001/pwn.html"]]];
}


- (void)setUpUI {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:webView];
    webView.center = self.view.center;
    [self injectScriptInterface:webView];
    self.webView = webView;
}

- (void)injectScriptInterface:(UIWebView * )webView {
        if (webView.subviews.count > 0) {
        UIScrollView *scrollView = webView.subviews[0];
        for (UIView *childView in scrollView.subviews) {
            if ([childView isKindOfClass:[UIWebDocumentView class]]) {
                UIWebDocumentView *documentView = (UIWebDocumentView *)childView;
                WebScriptObject *script = documentView.webView.windowScriptObject;
                [script setValue:[ScriptInterface new] forKey:@"n1ctf"];
            }
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
