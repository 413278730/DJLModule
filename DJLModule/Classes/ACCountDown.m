//
//  ACCountDown.m
//  AnChu
//
//  Created by Henry on 2018/7/11.
//  Copyright © 2018年 HangzhouAnChuTechnology. All rights reserved.
//

#import "ACCountDown.h"

@interface ACCountDown ()
@property(nonatomic,retain) NSDateFormatter *dateFormatter;
@end

@implementation ACCountDown

- (void)dealloc{
    NSLog(@"ACCountDownDelloc");
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dateFormatter=[[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
        [self.dateFormatter setTimeZone:localTimeZone];
    }
    return self;
}


/**
 每sec秒执行1次
 */
- (void)countDownWithSecond:(CGFloat)sec PER_SECBlock:(void (^)(void))PER_SECBlock;{
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),sec*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                PER_SECBlock();
            });
        });
        dispatch_resume(_timer);
    }
}

/**
 根据剩余时间戳倒计时
 
 @param restTimeStamp 剩余时间戳
 @param completeBlock 回调
 */
-(void)countDownWithRestTimeStamp:(long long)restTimeStamp completeBlock:(void (^)(NSInteger, NSInteger, NSInteger, NSInteger, NSTimeInterval restTimeStamp))completeBlock {
    {
        long long value = restTimeStamp/1000;
        NSNumber *time = [NSNumber numberWithLongLong:value];
        //转换成NSTimeInterval,用longLongValue，防止溢出
        NSTimeInterval restTimeInterval = [time longLongValue];
        __block int timeout = restTimeInterval; //倒计时时间
        if (_timer == nil) {
            if (timeout!=0) {
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    if(timeout<=0){ //倒计时结束，关闭
                        dispatch_source_cancel(_timer);
                        _timer = nil;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completeBlock(0,0,0,0,0);
                        });
                    }else{
                        int days = (int)(timeout/(3600*24));
                        int hours = (int)((timeout-days*24*3600)/3600);
                        int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                        int second = timeout-days*24*3600-hours*3600-minute*60;
                        timeout--;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completeBlock(days,hours,minute,second,timeout);
                        });
                    }
                });
                dispatch_resume(_timer);
            }
        }
    }
}

/**
 根据开始与截止日期倒计时

 @param startDate 开始日期
 @param finishDate 结束日期
 @param completeBlock 回调
 */
- (void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer==nil) {
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}


/**
  根据开始与截止时间戳倒计时

 @param starTimeStamp 开始时间戳
 @param finishTimeStamp 截止时间戳
 @param completeBlock 回调
 */
- (void)countDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer==nil) {
        NSDate *finishDate = [self dateWithLongLong:finishTimeStamp];
        NSDate *startDate  = [self dateWithLongLong:starTimeStamp];
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}


- (void)countDownWithMsecStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second,NSInteger msec))completeBlock{
    
    if (_timer==nil) {
        NSDate *finishDate = [self dateWithLongLong:finishTimeStamp];
        NSDate *startDate  = [self dateWithLongLong:starTimeStamp];
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeout = timeInterval * 1000; //倒计时时间 毫秒倒计时
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),0.1*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/1000/(3600*24));
                    int hours = (int)((timeout/1000-days*24*3600)/3600);
                    int minute = (int)(timeout/1000-days*24*3600-hours*3600)/60;
                    int second = timeout/1000-days*24*3600-hours*3600-minute*60;
                    int msec = timeout%1000/100;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second,msec);
                    });
                    timeout -= 100;
                }
            });
            dispatch_resume(_timer);
        }
    }
    
}

- (NSDate *)dateWithLongLong:(long long)longlongValue{
    long long value = longlongValue/1000;
    NSNumber *time = [NSNumber numberWithLongLong:value];
    //转换成NSTimeInterval,用longLongValue，防止溢出
    NSTimeInterval nsTimeInterval = [time longLongValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:nsTimeInterval];
    return date;
}

/**
 *  主动销毁定时器
 */
-(void)destoryTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
@end
