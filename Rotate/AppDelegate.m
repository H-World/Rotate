//
//  AppDelegate.m
//  Rotate
//
//  Created by 王寒标 on 2018/6/19.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [self loadAppUI];
    return YES;
}

- (void)loadAppUI {
    
    TabBarController *tabBarController = [[TabBarController alloc] init];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}

//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    
//    NSLog(@"%p-----\n%p---\n%d", self.window, window, [self.window isEqual:window]);
//    return window.rootViewController.supportedInterfaceOrientations;
//}

@end
