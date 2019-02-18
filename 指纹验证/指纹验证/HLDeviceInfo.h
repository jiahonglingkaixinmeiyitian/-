//
//  HLSystemInfo.h
//  指纹验证
//
//  Created by heartjhl on 2019/2/14.
//  Copyright © 2019年 heartjhl. All rights reserved.
//
//概念参考：https://www.cnblogs.com/zxykit/p/5320259.html
#import <Foundation/Foundation.h>

@interface HLDeviceInfo : NSObject
/**
 获取IDFA
 用户在设置->隐私 ->广告 ->限制广告跟踪里，打开限制开关后，将无法获取到IDFA
 */
+(NSString *)getDeviceIDFA;
/**
 获取IDFV
 */
+(NSString *)getDeviceIDFV;
@end
