//
//  HLSystemInfo.m
//  指纹验证
//
//  Created by heartjhl on 2019/2/14.
//  Copyright © 2019年 heartjhl. All rights reserved.
//

#import "HLDeviceInfo.h"
#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>

@implementation HLDeviceInfo
+ (NSString *)getDeviceIDFA{
    //判断是否可用
    __unused BOOL boolTag = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    NSString *idfa = nil;
    if (boolTag) {
        idfa = [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
    }
    return idfa;
}
+ (NSString *)getDeviceIDFV{
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return idfv;
}
@end
