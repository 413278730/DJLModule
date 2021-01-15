//
//  StringUtil.m
//  TaiHeToolKit
//
//  Created by Henry on 8/27/15.
//  Copyright (c) 2015 TaiHe. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

#pragma mark Public Methods
+ (BOOL)isEmpty:(NSString *)string {
   
    if (string == nil || [string isEqual:[NSNull null]] || string.length == 0) {
        
        return YES;
    }
    
    return NO;
}

#pragma mark- 判断邮箱格式是否正确，利用正则表达式验证
+ (BOOL)isAvailableEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark 判断字符串是否是手机号码
+ (BOOL)checkMobileNumber:(NSString *)mobileNumber
{
    if (mobileNumber.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestct evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma mark 判断字符串是否是电话号码
+ (BOOL)checkTelephoneNumber:(NSString *)telephoneNumber
{
    if ([StringUtil isEmpty:telephoneNumber]) {
        
        return NO;
    }
    
    NSString * mobileFormat = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat];
    
    if ([regexMobile evaluateWithObject:telephoneNumber]) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

#pragma mark- 产生一个随机8到16位的字符串
+ (NSString *)getRandomStrAmongst8to16{
    
    int count = [self getRandomNumber:8 to:17];
    
    return [self getRandomStrWithLengh:count];
}

#pragma mark- 产生随机字符串，长度为lengh
+ (NSString *)getRandomStrWithLengh:(int)lengh{
    
    char singleLetter[lengh];
    for (int x=0; x<lengh; singleLetter[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:singleLetter length:lengh encoding:NSUTF8StringEncoding];
}

#pragma mark- 获取一个随机整数，范围在[from,to），包括from，不包括to
+ (int)getRandomNumber:(int)from to:(int)to{
    
    return (int)(from + (arc4random() % (to - from +1)));
}


#pragma mark 检测是否是验证码

+ (BOOL)checkCode:(NSString *)astr
{
    NSScanner* scan = [NSScanner scannerWithString:astr];
    int val;
    if([scan scanInt:&val] && [scan isAtEnd] && astr.length == 4) {
        return YES;
    }else return NO;
}


#pragma mark 检测是否密码

+ (BOOL)checkPwd:(NSString *)aStr
{
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return  ([pred evaluateWithObject:aStr]);

    
//    //密码
//    + (BOOL) validatePassword:(NSString *)passWord
//    {
//        NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
//        NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
//        return [passWordPredicate evaluateWithObject:passWord];
//    }
}

#pragma mark- 最多输入两位小数
+ (BOOL)checkValidInputCount:(NSString *)inputCount{
    
    NSString *regex = @"^\\d+(\\.\\d{0,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return ([pred evaluateWithObject:inputCount]);
   
}

#pragma mark 检测是否是身份证号码

+ (BOOL)isValidateIDCard:(NSString *)IDCard
{
    NSString *IDCardRegex15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSString *IDCardRegex18 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}[\\d|x|X]$";
    NSPredicate *predicate15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex15];
    NSPredicate *predicate18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex18];
    return [predicate15 evaluateWithObject:IDCard] || [predicate18 evaluateWithObject:IDCard];
}


#pragma mar 四舍五入

+(NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

#pragma mark 匹配html中所有imageurl
+ (NSArray *)filterImage:(NSString *)html
{
    NSMutableArray *resultArray = [NSMutableArray array];

        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
        NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];

        for (NSTextCheckingResult *item in result) {
            NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];

            NSArray *tmpArray = nil;
            if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
                tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
            } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
                tmpArray = [imgHtml componentsSeparatedByString:@"src="];
            }

            if (tmpArray.count >= 2) {
                NSString *src = tmpArray[1];
                NSUInteger loc = [src rangeOfString:@"\""].location;
                if (loc != NSNotFound) {
                    src = [src substringToIndex:loc];
                    [resultArray addObject:src];
                }
            }
        }

    return resultArray;
}


#pragma mark 格式化所有带标签的文本
+(NSString *)filterHTML:(NSString *)html
{
    
//    html = [html stringByReplacingOccurrencesOfString:@"<p>" withString:@"\n"];
//
//    html = [html stringByReplacingOccurrencesOfString:@"<h5>" withString:@"\n\n"];
    html = [[[html stringByReplacingOccurrencesOfString:@"</p><h5>" withString:@"\n\n"] stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"] stringByReplacingOccurrencesOfString:@"</h5><p>" withString:@"\n"];

    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;

    
}

+(NSString *)randomStringWithLength:(int)len{

    NSString *letters = @"abcdefghijklmnopqrstuvwxyz0123456789";
    NSMutableString *radomString = [NSMutableString stringWithCapacity:len];
    
    for (int i=0; i<len; i++) {
        [radomString appendFormat:@"%C",[letters characterAtIndex:arc4random_uniform((int)[letters length])]];
    }
    
    return radomString;
}

#pragma mark- 是否为中文
+ (BOOL)isChineseWithStr:(NSString *)str{
    
    NSString *regex = @"^[\u4e00-\u9fa5]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:str];
}

#pragma mark- 检查银行卡号是否合法
+ (BOOL)isBankCardWithStr:(NSString *)str {
    
    NSString *regex = @"^\\d{15,19}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:str];
}


/**
 获取url中指定的参数

 @param name 参数名称
 @param url url
 @return 参数值
 */
+ (NSString *)getParamByName:(NSString *)name URLString:(NSString *)url
{
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)", name];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return nil;
}
@end
