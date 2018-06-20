//
//  BaseViewController.h
//  Rotate
//
//  Created by 王寒标 on 2018/6/19.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@end

@interface UIDevice (BaseViewController)

+ (instancetype)makeOrientation:(UIDeviceOrientation)orientation;
+ (instancetype)changeOrientationPortrait;
+ (instancetype)changeOrientationLandscapeRight;
+ (instancetype)changeOrientationLandscapeLeft;

@end
