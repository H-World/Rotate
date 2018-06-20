//
//  EffectModel.h
//  Rotate
//
//  Created by 王寒标 on 2018/6/20.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EffectModel : NSObject

@property (nonatomic) CGFloat startAnchor;
@property (nonatomic) CGFloat endAnchor;
@property (nonatomic, strong) UIColor *effectColor;
@property (nonatomic) NSUInteger index;
@property (nonatomic, weak) UIView *maskView;

@end
