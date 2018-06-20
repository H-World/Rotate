//
//  NavigationController.m
//  Rotate
//
//  Created by 王寒标 on 2018/6/19.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import "NavigationController.h"
#import "CommonTools.h"
#import "UIViewController+Rotate.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromHex(0xffdb4f), NSFontAttributeName : [UIFont systemFontOfSize:20]};
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
