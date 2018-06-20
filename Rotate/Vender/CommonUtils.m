//
//  CommonUtils.m
//  shortVideoProject
//
//  Created by MR_THT on 2018/2/1.
//  Copyright © 2018年 Rocky. All rights reserved.
//

#import "CommonUtils.h"
#define isEmpty(obj)        [CommonUtils isEmpty:obj]

@implementation CommonUtils

+ (BOOL)isEmpty:(id)thing
{
    return thing == nil || [thing isEqual:[NSNull null]] || ([thing respondsToSelector:@selector(length)] &&
                                                             [(NSData*)thing length] == 0) || ([thing respondsToSelector:@selector(count)] &&
                                                                                               [(NSArray*)thing count] == 0);
}

+ (NSData*)dict2JsonData:(id)dict
{
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
        if (error != nil) {
            NSLog(@"convert to json error %@", error);
        }
        return data;
    }
    return nil;
}

+ (id)data2Dict:(NSData*)data
{
    if (data == nil) {
        return nil;
    }
    
    NSError* error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) {
        NSLog(@"convert to dictionary error %@", error);
    }
    return result;
}

+ (NSString*)dict2JsonString:(id)dict
{
    if (isEmpty(dict)) {
        return nil;
    }
    NSData* registerData = [self dict2JsonData:dict];
    if (registerData) {
        return [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (id)string2Dict:(NSString*)string
{
    if (isEmpty(string)) {
        return nil;
    }
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error != nil) {
        NSLog(@"convert to dictionary error %@", error);
    }
    return dict;
}

+ (int)intFromDict:(id)dict key:(NSString*)key defaultValue:(int)defaultValue
{
    NSNumber* number = [dict objectForKey:key];
    if (number != nil && ![number isEqual:[NSNull null]]) {
        return [number intValue];
    }
    return defaultValue;
}

+ (BOOL)boolFromDict:(id)dict key:(NSString*)key defaultValue:(BOOL)defaultValue
{
    NSNumber* number = [dict objectForKey:key];
    if (number != nil && ![number isEqual:[NSNull null]]) {
        return [number boolValue];
    }
    return defaultValue;
}

+ (float)floatFromDict:(id)dict key:(NSString*)key defaultValue:(float)defaultValue
{
    NSNumber* number = [dict objectForKey:key];
    if (number != nil && ![number isEqual:[NSNull null]]) {
        return [number floatValue];
    }
    return defaultValue;
}

+ (double)doubleFromDict:(id)dict key:(NSString*)key defaultValue:(double)defaultValue
{
    NSNumber* number = [dict objectForKey:key];
    if (number != nil && ![number isEqual:[NSNull null]]) {
        return [number doubleValue];
    }
    return defaultValue;
}

+ (long long)longLongFromDict:(id)dict key:(NSString*)key defaultValue:(long long)defaultValue
{
    NSNumber* number = [dict objectForKey:key];
    if (number != nil && ![number isEqual:[NSNull null]]) {
        return [number longLongValue];
    }
    return defaultValue;
}


@end






