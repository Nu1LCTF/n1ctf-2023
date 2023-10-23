//
//  NoteBookViewController.h
//  pwn1OS
//
//  Created by dwj1210 on 2023/9/11.
//

#import <UIKit/UIKit.h>


/**
 *  屏幕高度
 */
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
/**
 *  屏幕宽度
 */
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)


/**
 *  状态栏
 */
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

/**
 *  导航栏
 */
#define kNavigationBarHeight [[UINavigationController alloc] init].navigationBar.frame.size.height

/**
 *  标签栏
 */
#define kTabBarHeight [[UITabBarController alloc] init].tabBar.frame.size.height

/**
 *  竖屏底部安全区域
 */
#define kSafeAreaHeight \
({CGFloat bottom=0.0;\
if (@available(iOS 11.0, *)) {\
bottom = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;\
} else { \
bottom=0;\
}\
(bottom);\
})


NS_ASSUME_NONNULL_BEGIN

@interface NoteBookViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
