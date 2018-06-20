//
//  CommonTools.m
//  shortVideoProject
//
//  Created by  Yi Shen on 2018/3/13.
//  Copyright © 2018年 Rocky. All rights reserved.
//

#import "CommonTools.h"
#import "CommonUtils.h"

@implementation CommonTools

+ (BOOL)isIPhoneX {
    
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
}

+ (CGFloat)tabbarHeight {
    
    return self.isIPhoneX ? 83 : 49;
}

static CGFloat  _statusHeight = 0;
+ (CGFloat)statusHeight {
    
    if (_statusHeight == 0) _statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    return _statusHeight;
}

+ (CGFloat)tabUnsafetyHeight {
    return self.isIPhoneX ? 34 : 0;
}

+ (NSTimeInterval)recoreMaxTime {
    
    return 18.0;
}

+ (NSTimeInterval)recordMinTime {
    
    return 4.0;
}

+ (NSTimeInterval)longVideoMaxTime {
    
    return 60 * 6;
}

/*
 @property (readonly, class) CGSize videoSize;
 @property (readonly, class) CGSize averageVideoBitRate;
 @property (readonly, class) CGSize videoMaxKeyframeInterval;
 @property (readonly, class) CGSize videoFrameRate;
 */
+ (CGSize)videoSize {
    
    return CGSizeMake(540, 960);
}

+ (NSUInteger)averageVideoBitRate {
    
    return 1024 * 1000 * 5;
}

+ (NSUInteger)videoMaxKeyframeInterval {
    
    return 2 * self.videoFrameRate;
}

+ (int)videoFrameRate {
    
    return 30;
}

+ (double)refreshRate {
    
    return 0.05;
}

+ (BOOL)app_status {
    return _app_status;
}

+ (NSString *)app_start_page_image {
    return _app_start_page_image;
}

+ (NSString *)music_match_entry {
    return _music_match_entry;
}

+ (NSString *)music_match_ico {
    return _music_match_ico;
}

+ (NSString *)music_apply_status {
    return _music_apply_status;
}

+ (NSString *)music_apply_url {
    return _music_apply_url;
}

+ (NSString *)music_match_api_domain {
    return _music_match_api_domain;
}

+ (NSString *)music_match_h5_domain {
    return _music_match_h5_domain;
}

static BOOL _app_status = NO;
static NSString *_music_match_entry = nil;
static NSString *_music_match_ico = nil;
static NSString *_music_apply_status = nil;
static NSString *_music_apply_url = nil;
static NSString *_music_match_api_domain = nil;
static NSString *_music_match_h5_domain = nil;
static NSString *_app_start_page_image = nil;

+ (void)saveMusicDataWithDict:(NSDictionary *)dict {
    
    if ([CommonUtils isEmpty:dict]) {
        return;
    }
    
    _app_status = [dict[@"app_status"] boolValue];
    _music_match_entry = dict[@"music_match_entry"];
    _music_match_ico = dict[@"music_match_ico"];
    _music_match_api_domain = dict[@"music_match_api_domain"];
    _music_match_h5_domain = dict[@"music_match_h5_domain"];
    _app_start_page_image = dict[@"app_start_page_image"];
}

+ (void)saveMusicApplyData:(NSDictionary *)dict {
    
    if ([CommonUtils isEmpty:dict]) {
        return;
    }
    _music_apply_status = dict[@"status"];
    _music_apply_url = dict[@"url"];
}

+ (void)saveApplyStatus:(NSString *)music_apply_status {
    _music_apply_status = music_apply_status;
}

#pragma mark - 删除文件
+ (BOOL)deleteFileWithPath:(id)path {
    NSURL *url;
    if ([path isKindOfClass:[NSString class]]) {
        url = [NSURL fileURLWithPath:path];
    }else if ([path isKindOfClass:[NSURL class]]){
        url = path;
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exist = [fm fileExistsAtPath:url.path];
    NSError *err = nil;
    if (exist) {
        [fm removeItemAtURL:url error:&err];
        if (err) {
            NSLog(@"file remove error, %@", err.localizedDescription);
            return NO;
        }
        return YES;
    }else{
        NSLog(@"no file by that name");
        return NO;
    }
}

@end

#pragma mark - FUNCTION
CGFloat ScreenWidth(void) {
    
    return [[UIScreen mainScreen] bounds].size.width;
}

CGFloat ScreenHeight(void) {
    
    return [[UIScreen mainScreen] bounds].size.height;
}

CGFloat StatusHeight(void) {
    return CommonTools.isIPhoneX ? 44 : 20;
}

CGFloat NavHeight(void) {
    return 44;
}

CGFloat TabUnsafetyHeight(void) {
    return CommonTools.isIPhoneX ? 34 : 0;
}

CGFloat TopHeight(void) {
    return CommonTools.isIPhoneX ? 88 : 64;
}

CGFloat TabbarHeight(void) {
    
    return CommonTools.isIPhoneX ? 83 : 49;
}

UIColor * UIColorWithRGB(double r, double g, double b) {
    
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

UIColor * UIColorFromHex(NSUInteger colorValue) {
    
    return [UIColor colorWithRed:(((colorValue & 0xFF0000) >> 16))/255.0 green:(((colorValue &0xFF00) >>8))/255.0 blue:((colorValue &0xFF))/255.0 alpha:1.0];
}

UIColor * UIColorHexString(NSString *colorValue)
{
    NSString *cString = [[colorValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

CGFloat AnimatViewWidth(void) {
    
    return ScreenWidth()*2/3.0;
}

CGFloat AnimatViewDuration(void) {
    
    return 0.4;
}

BOOL isPortrait(void) {
    
    return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
}
