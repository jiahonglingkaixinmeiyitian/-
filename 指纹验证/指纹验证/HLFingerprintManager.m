//
//  HLFingerprintManager.m
//  指纹验证
//
//  Created by heartjhl on 2019/2/13.
//  Copyright © 2019年 heartjhl. All rights reserved.
//
/**
 指纹登录有个有效时间，超过有效时间需要输入密码登录
 1.打开app内的指纹开关，验证通过后，将账号，密码和当前时间存储到钥匙串，并将账号存储到沙盒
 2.指纹登录时，用沙盒中的账号到钥匙串中查找到密码和上次存储的时间，如果钥匙串的时间和当前时间的差值在有效范围就可以用钥匙串中的密码登录，如果超出了有效范围就需要密码输入登录，登录成功后更新钥匙串的密码和时间
 3.如果钥匙串中的密码登录时出现错误（可能在其他机器中修改过密码等），则需要输入密码，登陆成功后更新钥匙串
 4.如果关闭指纹登录则需要将钥匙串中的信息删除
 */
#import "HLFingerprintManager.h"
#import <LocalAuthentication/LocalAuthentication.h>
@implementation HLFingerprintManager
+ (instancetype)sharedFingerprintManager
{
    static HLFingerprintManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(void)touchIDVerificationResultWithSuccessBlock:(SuccessTouchIDBlock)successBlock enterPsdBlock:(EnterPsdTouchIDBlock)enterPsdBlock andFailBlock:(FailTouchIDBlock)failBlock{
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"验证登录密码";//第一次没有验证成功后会出现该自定义标题
    NSError *error;
    BOOL success = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];//是否支持touchid
    if(success){
        NSLog(@"支持touchid");
//        验证指纹是否匹配
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"通过home键验证已有指纹" reply:^(BOOL success, NSError * _Nullable error) {
            
            if(success){//指纹验证成功
                NSLog(@"指纹验证成功");
                if (successBlock) {
                    successBlock();
                }
            }else{
                NSLog(@"指纹验证失败：%ld",error.code);
                switch (error.code) {
                    case LAErrorUserFallback:{
                        NSLog(@"用户选择输入密码");
                        if (enterPsdBlock) {
                            enterPsdBlock();
                        }
                        break;
                    }
                    case LAErrorAuthenticationFailed:{
                        NSLog(@"验证失败，指纹不匹配");//弹出指纹不匹配的提示
                        break;
                    }
                    case LAErrorUserCancel:{
                        NSLog(@"用户取消");
                        break;
                    }
                    case LAErrorSystemCancel:{
                        NSLog(@"系统取消");
                        break;
                    }
                        //以下三种情况如果提前检测TouchID是否可用就不会出现
//                    case LAErrorPasscodeNotSet:{
//                        break;
//                    }
//                    case LAErrorTouchIDNotAvailable:{
//                        break;
//                    }
//                    case LAErrorTouchIDNotEnrolled:{
//                        break;
//                    }
                        
                    default:
                        break;
                }
            }
        }];
    }else{//指纹验证失败后，继续验证指纹，当还是失败时，指纹验证就会被锁定。就会调用以下代码
        NSLog(@"不支持touchid %ld",(long)error.code);
        if (error.code==-8) {//指纹验证被锁定
//            报错码为-8时，调用此方法会弹出系统密码输入界面
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"指纹验证错误次数过多,请输入密码" reply:^(BOOL success, NSError * _Nullable error) {
                if(success){
                    NSLog(@"🍎🍎🍎🍎🍎🍎");
                }else{
                  NSLog(@"🍊🍊🍊🍊🍊🍊：%ld",error.code);
                }
            }];
        }
    }
}
@end
