//
//  BaseViewController.m
//  Rotate
//
//  Created by 王寒标 on 2018/6/19.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate {
    
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

@end

@implementation UIDevice (BaseViewController)

+ (instancetype)makeOrientation:(UIDeviceOrientation)orientation{
    
    UIDevice *device = [UIDevice currentDevice];

    if([device respondsToSelector:@selector(setOrientation:)]) {

        SEL selector = NSSelectorFromString(@"setOrientation:");

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];

        [invocation setSelector:selector];

        [invocation setTarget:[UIDevice currentDevice]];

        int val = orientation;

        [invocation setArgument:&val atIndex:2];

        [invocation invoke];
    }
    
    return device;
}

+ (instancetype)changeOrientationPortrait {
    
    return [UIDevice makeOrientation:UIDeviceOrientationPortrait];
}

+ (instancetype)changeOrientationLandscapeLeft {
    
    return [UIDevice makeOrientation:UIDeviceOrientationLandscapeLeft];
}

+ (instancetype)changeOrientationLandscapeRight {
    
    return [UIDevice makeOrientation:UIDeviceOrientationLandscapeRight];
}

@end
