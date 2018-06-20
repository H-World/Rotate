//
//  EffectView.m
//  Rotate
//
//  Created by 王寒标 on 2018/6/20.
//  Copyright © 2018年 王寒标. All rights reserved.
//

#import "EffectView.h"
#import "EffectModel.h"
#import "Aspects.h"

@interface EffectView ()

@property (nonatomic, weak) UIView *sourceView;
@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, strong) NSMutableArray<EffectModel *> *effects;
@property (nonatomic, strong) EffectModel *currentEffect;
@property (nonatomic, strong) EffectModel *nextEffect;

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
    
    static UIView *maskView;
    static EffectModel *effect;
    CGRect currentFrame = self.indicatorView.frame;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            
            maskView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(currentFrame), 0, 0, 70)];
            maskView.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:0.3];
            [self.sourceView addSubview:maskView];
            
            effect = [[EffectModel alloc] init];
            effect.startAnchor = CGRectGetMinX(maskView.frame);
            effect.endAnchor = CGRectGetMinX(maskView.frame);
            effect.effectColor = maskView.backgroundColor;
            effect.maskView = maskView;
            
            if (self.currentEffect) {
                
                [self.effects insertObject:effect atIndex:self.currentEffect.index + 1];
                
                EffectModel *nextEffect = [[EffectModel alloc] init];
                nextEffect.endAnchor = self.currentEffect.endAnchor;
                nextEffect.startAnchor = CGRectGetMinX(currentFrame);
                
                self.currentEffect.endAnchor = CGRectGetMinX(currentFrame);
                CGRect currentEffectFrame = self.currentEffect.maskView.frame;
                currentEffectFrame.size.width = self.currentEffect.endAnchor - self.currentEffect.startAnchor;
                self.currentEffect.maskView.frame = currentEffectFrame;
                
                UIView *separationView = [[UIView alloc] initWithFrame:CGRectMake(nextEffect.startAnchor, 0, nextEffect.endAnchor - nextEffect.startAnchor, 70)];
                separationView.backgroundColor = self.currentEffect.maskView.backgroundColor;
                nextEffect.maskView = separationView;
                [self.sourceView addSubview:separationView];
                [self.effects insertObject:nextEffect atIndex:self.currentEffect.index + 2];
                self.nextEffect = nextEffect;
            } else if (self.nextEffect) {
                
                [self.effects insertObject:effect atIndex:self.nextEffect.index];
            } else {
                
                [self.effects addObject:effect];
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            
            currentFrame.origin.x += 1;

            if (CGRectGetWidth(self.sourceView.frame) >= CGRectGetMaxX(currentFrame)) {

                self.indicatorView.frame = currentFrame;
                
                CGFloat width = CGRectGetMinX(currentFrame) - CGRectGetMinX(maskView.frame);
                CGRect currentMaskFrame = maskView.frame;
                currentMaskFrame.size.width = width;
                maskView.frame = currentMaskFrame;
                
                effect.endAnchor = CGRectGetMaxX(maskView.frame);
            }
            
            if (self.nextEffect != nil) {
                
                if (CGRectGetMinX(self.indicatorView.frame) > self.nextEffect.startAnchor && CGRectGetMinX(self.indicatorView.frame) < self.nextEffect.endAnchor) {
                    
                    self.nextEffect.startAnchor = CGRectGetMinX(self.indicatorView.frame);
                    
                    CGRect currentNextFrame = self.nextEffect.maskView.frame;
                    currentNextFrame.origin.x = self.nextEffect.startAnchor;
                    currentNextFrame.size.width = self.nextEffect.endAnchor - self.nextEffect.startAnchor;
                    
                    self.nextEffect.maskView.frame = currentNextFrame;
                } else if (CGRectGetMinX(self.indicatorView.frame) >= CGRectGetMaxX(self.nextEffect.maskView.frame)) {
                    
                    EffectModel *changeEffect = nil;
                    if (![self.nextEffect isEqual:self.effects.lastObject]) {
                        
                        NSUInteger index = [self.effects indexOfObject:self.nextEffect];
                        changeEffect = self.effects[index + 1];
                    }
                    [self.nextEffect.maskView removeFromSuperview];
                    [self.effects removeObject:self.nextEffect];
                    self.nextEffect = changeEffect;
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled: {
            
            effect.endAnchor = CGRectGetMaxX(maskView.frame);
            [self locateindicatorView];
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
    
    [self locateindicatorView];
}

- (void)locateindicatorView {
    
    CGFloat startIndicator = CGRectGetMinX(self.indicatorView.frame);
    self.currentEffect = nil;
    self.nextEffect = nil;
    __weak typeof(self) weakSelf = self;
    [self.effects enumerateObjectsUsingBlock:^(EffectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.startAnchor <= startIndicator && obj.endAnchor > startIndicator) {
            
            weakSelf.currentEffect = obj;
            if (idx != weakSelf.effects.count - 1) {
                
                weakSelf.nextEffect = weakSelf.effects[idx + 1];
            }
            
            *stop = YES;
        }
        
        if (obj.startAnchor > startIndicator) {
            
            weakSelf.currentEffect = nil;
            weakSelf.nextEffect = obj;
            *stop = YES;
        }
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

- (NSMutableArray<EffectModel *> *)effects {
    
    if (_effects == nil) {
        
        _effects = [NSMutableArray array];
        
        __weak typeof(self) weakSelf = self;
        [_effects aspect_hookSelector:@selector(insertObject:atIndex:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, id object, NSUInteger idx) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSMutableArray *array = strongSelf->_effects;
            NSUInteger index = [array indexOfObject:object];
            if (![[array lastObject] isEqual:object]) {
                
                [array enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index + 1, array.count - index - 1)] options:NSEnumerationConcurrent usingBlock:^(EffectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    obj.index++;
                }];
            }
        } error:nil];
        
        [_effects aspect_hookSelector:@selector(removeObject:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, id object) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSMutableArray *array = strongSelf->_effects;
            NSUInteger index = [array indexOfObject:object];
            if (![[array lastObject] isEqual:object]) {
                
                [array enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index + 1, array.count - index - 1)] options:NSEnumerationConcurrent usingBlock:^(EffectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    obj.index--;
                }];
            }
        } error:nil];
    }
    
    return _effects;
}

@end
