//
//  HLKeychainTool.m
//  指纹验证
//
//  Created by heartjhl on 2019/2/13.
//  Copyright © 2019年 heartjhl. All rights reserved.
//

#import "HLKeychainTool.h"
#import <Security/Security.h>
@implementation HLKeychainTool
+ (instancetype)shareKeychainInstance {
    
    static HLKeychainTool *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[HLKeychainTool alloc] init];
    });
    return shareInstance;
}
@end
