//
//  CommonUtils.h
//  shortVideoProject
//
//  Created by MR_THT on 2018/2/1.
//  Copyright © 2018年 Rocky. All rights reserved.
//

#ifndef shortVideoProject_CommonUtils_h
#define shortVideoProject_CommonUtils_h

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject

+ (BOOL)isEmpty:(id)thing;

+ (NSString*)dict2JsonString:(id)dict;
+ (id)string2Dict:(NSString*)string;
+ (NSData*)dict2JsonData:(id)dict;
+ (id)data2Dict:(NSData*)data;

+ (int)intFromDict:(id)dict key:(NSString*)key defaultValue:(int)defaultValue;
+ (BOOL)boolFromDict:(id)dict key:(NSString*)key defaultValue:(BOOL)defaultValue;
+ (float)floatFromDict:(id)dict key:(NSString*)key defaultValue:(float)defaultValue;
+ (double)doubleFromDict:(id)dict key:(NSString*)key defaultValue:(double)defaultValue;
+ (long long)longLongFromDict:(id)dict key:(NSString*)key defaultValue:(long long)defaultValue;


@end

#endif

