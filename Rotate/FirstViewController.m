//
//  FirstViewController.m
//  Rotate
//
//  Created by 王寒标 on 2018/6/19.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "EffectView.h"

@implementation FirstViewController

- (void)loadView {
    
    self.view = [[EffectView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
    [UIDevice changeOrientationPortrait];
}

@end
