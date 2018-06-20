//
//  TabBarController.m
//  Rotate
//
//  Created by 王寒标 on 2018/6/19.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import "TabBarController.h"
#import "CommonTools.h"
#import "NavigationController.h"
#import "UIViewController+Rotate.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAllChildViewController];
    self.tabBar.barTintColor = [UIColor blackColor];
}

- (void)addAllChildViewController {
    
    NSArray *titles = @[@"印象", @"主题", @"消息", @"我"];
    NSArray *selectImages = @[@"impression_h1.4", @"theme_h1.4", @"news_h1.4", @"my_h1.4"];
    NSArray *normalImages = @[@"impression_n1.4", @"theme_n1.4", @"news_n1.4", @"my_n1.4"];
    NSArray *viewControllers = @[@"FirstViewController", @"FirstViewController", @"FirstViewController", @"FirstViewController"];
    
    NSUInteger count = viewControllers.count;
    for (NSUInteger i = 0; i < count; i++) {
        
        UIViewController *viewController = [[NSClassFromString(viewControllers[i]) alloc] init];
        [self addChildVc:viewController title:titles[i] image:normalImages[i] selectedImage:selectImages[i]];
    }
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    // 设置子控制器的文字
    childVc.title = title;
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置UIControlStateNormal状态下的文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColorFromHex(0xb6b6b6);
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    // 设置UIControlStateSelected状态下的文字样式
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = UIColorFromHex(0xffdb4f);
    selectTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器 可以在这里统一设置相关属性
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childVc];
    nav.navigationBar.barTintColor = [UIColor blackColor];
    // 添加为子控制器
    [self addChildViewController:nav];
}

- (BOOL)shouldAutorotate {
    
    return [[self topmostViewController] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return [[self topmostViewController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [[self topmostViewController] preferredInterfaceOrientationForPresentation];
}

@end
