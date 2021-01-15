//
//  TimeUtil.m
//  TaiHeToolKit
//
//  Created by Henry on 8/6/15.
//  Copyright (c) 2015 TaiHe. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil

#pragma mark - Class Methods
#pragma mark 获取当前时间戳
+ (long long)getCurrentTimeInterval {
    
    return [[NSDate date] timeIntervalSince1970];
}


#pragma mark 将手机当天日期转换为"yyyy-MM-dd"格式的字符串
+ (NSString *)formatCurrentDate {
    
    return [self formatCurrentDate:@"yyyy-MM-dd"];
}

+ (NSString *)formatTimeStrWithTimeInterval:(NSTimeInterval)interval format:(NSString *)formatStr{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self formatterDate:date formatString:formatStr];
}

#pragma mark 将手机当天日期转换为formatString指定格式的字符串
+ (NSString *)formatCurrentDate:(NSString *)formatString {
    
    return [self formatterDate:[NSDate date] formatString:formatString];
}

#pragma mark 将NSDate对象转换为"yyyy-MM-dd"格式的字符串
+ (NSString *)formatterDate:(NSDate *)date {
    
    return [self formatterDate:date formatString:@"yyyy-MM-dd"];
}


#pragma mark 将NSDate对象转换为formatString指定格式的字符串
+ (NSString *)formatterDate:(NSDate *)date formatString:(NSString *)formatString {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    return [formatter stringFromDate:date];
}

/**
 将时间字符串按指定格式转换成日期
 
 @param dateString 时间字符串
 @param formatString 时间格式
 @return 日期
 */
+ (NSDate *)getDateFromDateString:(NSString *)dateString formatString:(NSString *)formatString {
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];
    [inputFormatter setDateFormat:formatString];
    return [inputFormatter dateFromString:dateString];
}


#pragma mark 将格式为"yyyyMMdd"的日期字符串转换为NSDate对象
+ (NSDate *)getDateFromDateString:(NSString *)dateString {
    
    if ([dateString length] != [@"yyyyMMdd" length]) {
        
        return nil;
    }
    
    return [self getDateFromDateString:dateString formatString:@"yyyyMMdd"];
}


#pragma mark 将如oldformatString格式的字符串转换为newformatString指定格式的字符串
+ (NSString *)formatterDateStrWithTime:(NSString *)timeString oldFormatString:(NSString *)oldformatString ToNewFormatString:(NSString *)newformatString{
    
    if (timeString == nil) {
        
        return nil;
    }
    
    NSDate *date = [self getDateFromDateString:timeString formatString:oldformatString];
    
    return [self formatterDate:date formatString:newformatString];
}

/**
 比较两个时间是否符合先后顺序
 @param start 开始时间
 @param end 结束时间
 */
+ (BOOL)compareDateFromStartDate:(NSString *)start end:(NSString *)end formatStr:(NSString *)fromatStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:fromatStr];
    
    NSDate *startDate = [dateFormatter  dateFromString:start];
    NSDate *endDate = [dateFormatter dateFromString:end];
    
    NSComparisonResult result = [startDate compare:endDate];
    
    if (result == NSOrderedAscending) {// start < end
        
        return YES;
    }
    
    return NO;
}

#pragma mark  根据时间戳计算剩余时间
+ (void)restTimeWithTimeInterval:(NSTimeInterval)interval finishBlock:(void (^)(int, int, int, int))block{
    int days = (int)(interval/(3600*24));
    int hours = (int)((interval-days*24*3600)/3600);
    int minute = (int)(interval-days*24*3600-hours*3600)/60;
    int second = interval-days*24*3600-hours*3600-minute*60;
    
    if (block) {
        block(days,hours,minute,second);
    }
}
@end
