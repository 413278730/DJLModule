//
//  StringUtil.h
//  TaiHeToolKit
//
//  Created by Henry on 8/27/15.
//  Copyright (c) 2015 TaiHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

/**
 产生指定长度的随机字符串，由字母和数字组成
 
 @param len 长度
 @return 随机字符串
 */
+(NSString *)randomStringWithLength:(int)len;


/**
 *  产生8-16位的随机字符串
 */
+ (NSString *)getRandomStrAmongst8to16; 

/**
 *  产生随机字符串，长度为lengh
 */
+ (NSString *)getRandomStrWithLengh:(int)lengh;

/**
 *  获取一个随机整数，范围在[from,to），包括from，不包括to
 */
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 *  判断字符串是否为空
 *
 *  @param string 判断的字符串
 *
 *  @return 判断结果
 */
+ (BOOL)isEmpty:(NSString *)string;


/**
 *  判断邮箱格式是否正确，利用正则表达式验证
 *
 *  @param email 判断的字符串
 *
 *  @return 判断结果
 */

+ (BOOL)isAvailableEmail:(NSString *)email;


/**
 *  判断字符串是否是手机号码
 *
 *  @param mobileNumber 判断的字符串
 *
 *  @return 判断结果
 */
+ (BOOL)checkMobileNumber:(NSString *)mobileNumber;


/**
 *  判断字符串是否是电话号码
 *
 *  @param telephoneNumber 判断的字符串
 *
 *  @return 判断结果
 */
+ (BOOL)checkTelephoneNumber:(NSString *)telephoneNumber;


/**
 *  检测是否是验证码
 *
 *  @param astr 验证码字符串
 *
 */
+ (BOOL)checkCode:(NSString *)astr;

/**
*  匹配html中所有imageurl
*
*  @param html 验证码字符串
*
*/
+ (NSArray *)filterImage:(NSString *)html;



/**
 检查输入金额是否合法（最多输入两个小数点）
 @param inptCount 输入字符
 */
+ (BOOL)checkValidInputCount:(NSString *)inptCount;

/**
 *  检测是密码
 *
 *  @param aStr 密码字符串
 *
 */
+ (BOOL)checkPwd:(NSString *)aStr;


/**
 *  检测是否是身份证号
 *
 *  @param IDCard 身份证号字符串
 */
+ (BOOL)isValidateIDCard:(NSString *)IDCard;

/**
 *  浮点型数据四舍五入
 *
 *  @param format 保留两位小数  传入@"0.00";
 *  @param floatV 字符数据
 *
 *  @return 四舍五入保留两位后的字符串
 */
+(NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;

/**
 *  格式化所有带标签的文本
 *
 *  @param html 带标签的字符串
 *
 *  @return 处理完成后不带标签的字符串
 */
+(NSString *)filterHTML:(NSString *)html;


/**
 检查是否为中文

 @param str 目标字符串
 @return 结果
 */
+ (BOOL)isChineseWithStr:(NSString *)str;

/**
 检查银行卡号是否合法
 
 @param str 银行卡号字符串
 @return 结果
 */
+ (BOOL)isBankCardWithStr:(NSString *)str;

/**
 获取url中指定的参数
 
 @param name 参数名称
 @param url url
 @return 参数值
 */
+ (NSString *)getParamByName:(NSString *)name URLString:(NSString *)url;
@end
