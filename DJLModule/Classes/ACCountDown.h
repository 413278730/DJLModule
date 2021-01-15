//
//  ACCountDown.h
//  AnChu
//
//  Created by Henry on 2018/7/11.
//  Copyright © 2018年 HangzhouAnChuTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACCountDown : NSObject

@property(nonatomic,retain) dispatch_source_t timer;

/**
 根据剩余时间戳倒计时
 
 @param restTimeStamp 剩余时间戳
 @param completeBlock 回调
 */
- (void)countDownWithRestTimeStamp:(long long)restTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second,NSTimeInterval restTimeStamp))completeBlock;

/**
 根据开始与截止日期倒计时
 
 @param startDate 开始日期
 @param finishDate 结束日期
 @param completeBlock 回调
 */
- (void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;

/**
 根据开始与截止时间戳倒计时 (秒倒计时)
 
 @param starTimeStamp 开始时间戳
 @param finishTimeStamp 截止时间戳
 @param completeBlock 回调
 */
- (void)countDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;


/**
 根据开始与截止时间戳倒计时  (毫秒倒计时)
 
 @param starTimeStamp 开始时间戳
 @param finishTimeStamp 截止时间戳
 @param completeBlock 回调
 */
- (void)countDownWithMsecStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second,NSInteger msec))completeBlock;

/**
 每秒sec执行1次
 */
- (void)countDownWithSecond:(CGFloat)sec PER_SECBlock:(void (^)(void))PER_SECBlock;

/**
 销毁定时器
 */
- (void)destoryTimer;
@end
