//
//  TimeUtil.h
//  TaiHeToolKit
//
//  Created by Henry on 8/6/15.
//  Copyright (c) 2015 TaiHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject

/**
 *  获取当前时间戳
 *
 *  @return 当前时间戳
 */
+ (long long)getCurrentTimeInterval;

/**
 *  将手机当天日期转换为"yyyy-MM-dd"格式的字符串
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)formatCurrentDate;

/**
 *  将手机当天日期转换为formatString指定格式的字符串
 *
 *  @param formatString 日期格式，如"yyyy-MM-dd"
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)formatCurrentDate:(NSString *)formatString;


/**
 *  将NSDate对象转换为"yyyy-MM-dd"格式的字符串
 *
 *  @param date NSDate对象
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)formatterDate:(NSDate *)date;


/**
 *  将NSDate对象转换为formatString指定格式的字符串
 *
 *  @param date         NSDate对象
 *  @param formatString 日期格式，如"yyyy-MM-dd"
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)formatterDate:(NSDate *)date
               formatString:(NSString *)formatString;


/**
 *  将格式为"yyyyMMdd"的日期字符串转换为NSDate对象
 *
 *  @param dateString  8位日期字符串，格式必须为"yyyyMMdd"
 *
 *  @return NSDate对象
 */
+ (NSDate *)getDateFromDateString:(NSString *)dateString;


/**
 将时间戳转换为固定格式时间字符串

 @param interval 时间戳
 @param formatStr 时间格式
 @return 格式化的时间字符串
 */
+ (NSString *)formatTimeStrWithTimeInterval:(NSTimeInterval)interval format:(NSString *)formatStr;


/**
 *  将日期字符串根据formatString格式转换为NSDate对象
 *
 *  @param dateString   日期字符串
 *  @param formatString dateString的日期格式，如"yyyyMMdd"
 *
 *  @return NSDate对象
 */
+ (NSDate *)getDateFromDateString:(NSString *)dateString
                     formatString:(NSString *)formatString;

/**
 *  将旧格式日期字符串转换为新格式的字符串
 *  timeString 格式如"yyyy-MM-dd"的日期字符串
 *  oldformatString 旧的日期格式
 *  newformatString 新的日期格式
 *  @return 格式化后的字符串
 */
+ (NSString *)formatterDateStrWithTime:(NSString *)timeString
                       oldFormatString:(NSString *)oldformatString
                     ToNewFormatString:(NSString *)newformatString;


/**
 比较两个时间是否符合先后顺序
 @param start 开始时间
 @param end 结束时间
 @param fromatStr 时间格式
 @return 如果start小于end 返回YES
 */
+ (BOOL)compareDateFromStartDate:(NSString *)start
                             end:(NSString *)end
                       formatStr:(NSString *)fromatStr;


/**
 根据时间戳计算剩余时间
 @param interval 剩余时间戳
 */
+ (void)restTimeWithTimeInterval:(NSTimeInterval)interval finishBlock:(void(^)(int days,int hours,int minute,int second))block;
@end
