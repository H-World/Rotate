//
//  UIViewController+Rotate.m
//  Rotate
//
//  Created by 王寒标 on 2018/6/19.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import "UIViewController+Rotate.h"

@implementation UIViewController (Rotate)

- (UIViewController *)topmostViewController {
    
    if (self.presentedViewController) {
        
        UIViewController* presentedViewController = self.presentedViewController;
        return [presentedViewController topmostViewController];
    } else if ([self isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* tabBarController = (UITabBarController*)self;
        return [tabBarController.selectedViewController topmostViewController];
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* nav = (UINavigationController*)self;
        return [nav.visibleViewController topmostViewController];
    } else {
        
        return self;
    }
}

@end
