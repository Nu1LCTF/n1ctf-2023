//
//  NoteBookViewController.m
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/11.
//

#import "NoteBookViewController.h"




@interface NoteBookViewController ()
@property(nonatomic, strong) UITextView *textView;
@end

@implementation NoteBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI {
    
////    UINavigationBar *bar = self.navigationController.navigationItem.title.
//    double statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
//    double topSafeAreaHeight = (statusBarHeight - 20);

//    int height =  [self kStatusBarHeight];
    int height = kStatusBarHeight + kNavigationBarHeight;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 80)];
    [self.view addSubview:label];
    [label setText:@"N1CTF Notebook"];
    label.font = [UIFont fontWithName:@"CoveredByYourGrace" size:30];
    label.textAlignment = NSTextAlignmentCenter;
    
//    label.layer.borderColor = [UIColor grayColor].CGColor;
//    label.layer.borderWidth =  1;

    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, height + 80, kScreenWidth, kScreenHeight - height - 80 - 70)];
    
    [self.view addSubview:textView];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"notebook" ofType:nil];
    NSString *note = [NSString stringWithContentsOfFile:path];
    textView.text = note;
    textView.font = [UIFont fontWithName:@"NanumGothicCoding" size:12];
    self.textView = textView;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 20)];
    label1.text = @"pwn1OS is running on an iPhone12 device with iOS14.1";
    label1.textAlignment = NSTextAlignmentCenter;
//    label1.font = [UIFont fontWithName:@"CoveredByYourGrace" size:14];
    label1.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label1];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.textView resignFirstResponder];
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
