//
//  HLKeychainTool.h
//  指纹验证
//
//  Created by heartjhl on 2019/2/13.
//  Copyright © 2019年 heartjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLKeychainTool : NSObject
///单例
+ (instancetype)shareKeychainInstance;
@end
