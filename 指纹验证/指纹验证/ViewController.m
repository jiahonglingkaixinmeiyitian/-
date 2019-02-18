//
//  ViewController.m
//  指纹验证
//
//  Created by heartjhl on 2019/2/13.
//  Copyright © 2019年 heartjhl. All rights reserved.
//

#import "ViewController.h"
#import "HLFingerprintManager.h"
#import "HLDeviceInfo.h"
#import "SFHFKeychainUtils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)zhiwenAction:(id)sender {
    [[HLFingerprintManager sharedFingerprintManager] touchIDVerificationResultWithSuccessBlock:^{
        NSError *error;
        BOOL saved = [SFHFKeychainUtils storeUsername:@"userName" andPassword:@"password"
                                       forServiceName:@"com.linktrust.linxin" updateExisting:YES error:&error];
        
        if (!saved) {
            NSLog(@"❌Keychain保存密码时出错：%@", error);
        }else{
            NSLog(@"✅Keychain保存密码成功！");
        }
        NSLog(@"指纹识别成功");
    } enterPsdBlock:^{
        NSLog(@"用户不用指纹解锁，通过选择输入密码解锁");
    } andFailBlock:^{
        NSLog(@"指纹识别失败");
    }];
    [HLDeviceInfo getDeviceIDFV];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
