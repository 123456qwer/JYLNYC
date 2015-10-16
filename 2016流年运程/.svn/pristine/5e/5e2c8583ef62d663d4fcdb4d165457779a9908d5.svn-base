//
//  ViewController.m
//  guanYinQian
//
//  Created by 何川 on 15-3-23.
//  Copyright (c) 2015年 金源互动科技有限公司. All rights reserved.
//

#import "AppHelper.h"
#import "MBProgressHUD.h"

@implementation AppHelper

static MBProgressHUD *HUD;
//MBProgressHUD 的使用方式，只对外两个方法，可以随时使用(但会有警告！)，其中窗口的 alpha值 可以在源程序里修改。
+ (void)showHUD:(NSString *)msg{
	HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
	[[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.dimBackground = YES;
	HUD.labelText = msg;
	[HUD show:YES];
}

+ (void)removeHUD{
	[HUD hide:YES];
	[HUD removeFromSuperViewOnHide];
	[HUD release];
}

@end