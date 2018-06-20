//
//  CommonTools.h
//  shortVideoProject
//
//  Created by  Yi Shen on 2018/3/13.
//  Copyright © 2018年 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#ifdef DEBUG
#define SVLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define SVLog(...)
#endif

@interface CommonTools : NSObject

@property (readonly, class) BOOL isIPhoneX;
@property (readonly, class) CGFloat tabbarHeight;
@property (readonly, class) CGFloat statusHeight;
@property (readonly, class) CGFloat tabUnsafetyHeight;
/** 最长录制时间 */
@property (readonly, class) NSTimeInterval recoreMaxTime;
@property (readonly, class) NSTimeInterval recordMinTime;
@property (readonly, class) NSTimeInterval longVideoMaxTime;
@property (readonly, class) CGSize videoSize;
@property (readonly, class) NSUInteger averageVideoBitRate;
@property (readonly, class) NSUInteger videoMaxKeyframeInterval;
@property (readonly, class) int videoFrameRate;
/** 计时器刷新频率 */
@property (readonly, class) double refreshRate;

///** 启动页数组 */
//@property (readonly, class) NSArray *launchPageArr;

//  音乐会
@property (readonly, class) BOOL app_status;//app状态 0 关闭 1 正常
@property (readonly, class) NSString *music_match_entry;//音乐比赛入口地址
@property (readonly, class) NSString *music_match_ico;//音乐比赛入口地址按钮图标
@property (readonly, class) NSString *music_apply_status;//报名与否的状态0未报名 1已报名     报名取消了也算报过名
@property (readonly, class) NSString *music_apply_url;//链接地址
@property (readonly, class) NSString *music_match_api_domain;//音乐汇服务器地址
@property (readonly, class) NSString *music_match_h5_domain;//音乐汇h5入口地址
@property (readonly, class) NSString *app_start_page_image;//app启动页图片地址

+ (void)saveMusicDataWithDict:(NSDictionary *)dict;
+ (void)saveMusicApplyData:(NSDictionary *)dict;
+ (void)saveApplyStatus:(NSString *)music_apply_status;
+ (BOOL)deleteFileWithPath:(id)path;

@end

#pragma mark - FUNCTION
extern CGFloat ScreenWidth(void);
extern CGFloat ScreenHeight(void);

extern CGFloat StatusHeight(void);
extern CGFloat NavHeight(void);
extern CGFloat TabUnsafetyHeight(void);
extern CGFloat TopHeight(void);
extern CGFloat TabbarHeight(void);

extern UIColor * UIColorWithRGB(double r, double g, double b);
extern UIColor * UIColorFromHex(NSUInteger colorValue);
extern UIColor * UIColorHexString(NSString *colorValue);

extern CGFloat AnimatViewWidth(void);
extern CGFloat AnimatViewDuration(void);
extern BOOL isPortrait(void);





