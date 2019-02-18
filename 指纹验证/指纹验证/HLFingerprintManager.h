//
//  HLFingerprintManager.h
//  指纹验证
//
//  Created by heartjhl on 2019/2/13.
//  Copyright © 2019年 heartjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessTouchIDBlock)(void);///验证成功
typedef void(^FailTouchIDBlock)(void);///验证失败
typedef void(^EnterPsdTouchIDBlock)(void);///用户选择输入密码

@interface HLFingerprintManager : NSObject
///单例
+ (instancetype)sharedFingerprintManager;
///检测TouchID是否可用，并获得验证结果
-(void)touchIDVerificationResultWithSuccessBlock:(SuccessTouchIDBlock)successBlock enterPsdBlock:(EnterPsdTouchIDBlock)enterPsdBlock andFailBlock:(FailTouchIDBlock)failBlock;
@end
