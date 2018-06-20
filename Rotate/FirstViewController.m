//
//  FirstViewController.m
//  Rotate
//
//  Created by 王寒标 on 2018/6/19.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
    [UIDevice changeOrientationPortrait];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    SecondViewController *secondViewController = [SecondViewController new];
    
    [self.navigationController pushViewController:secondViewController animated:YES];
}

@end
