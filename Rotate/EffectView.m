//
//  EffectView.m
//  Rotate
//
//  Created by 王寒标 on 2018/6/20.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import "EffectView.h"

@interface EffectView ()

@property (nonatomic, weak) UIView *sourceView;
@property (nonatomic, weak) UIView *indicatorView;

@end

@implementation EffectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self installSubviews];
        [self loadInteractionEvent];
    }
    return self;
}

- (void)loadInteractionEvent {
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(increasedEffect:)];
    [self addGestureRecognizer:longPressGesture];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeLocation:)];
    [self.sourceView addGestureRecognizer:tap];
}

- (void)increasedEffect:(UILongPressGestureRecognizer *)gesture {
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            
            NSLog(@"Gesture recognizer began   %@", self.nextResponder);
        }
            break;
        case UIGestureRecognizerStateChanged: {
            
            CGRect currentFrame = self.indicatorView.frame;
            currentFrame.origin.x += 1;

            if (CGRectGetWidth(self.sourceView.frame) >= CGRectGetMaxX(currentFrame)) {

                self.indicatorView.frame = currentFrame;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)changeLocation:(UITapGestureRecognizer *)gesture {
    
    CGPoint location = [gesture locationInView:self.sourceView];
    CGRect currentFrame = self.indicatorView.frame;
    currentFrame.origin.x = location.x;
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.indicatorView.frame = currentFrame;
    }];
}

- (void)installSubviews {
    
    UIView *sourceView = [[UIView alloc] initWithFrame:CGRectMake(20, 150, CGRectGetWidth([UIScreen mainScreen].bounds) - 40, 70)];
    sourceView.backgroundColor = [UIColor grayColor];
    [self addSubview:sourceView];
    self.sourceView = sourceView;
    
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 70)];
    indicatorView.backgroundColor = [UIColor whiteColor];
    [sourceView addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

@end
