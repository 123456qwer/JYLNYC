//
//  AddPeopleViewController.h
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/12.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPickerView.h"
@class AddPeopleViewController;
@protocol addPeopleViewDelegate <NSObject>

- (void)changeHomeAndPan:(NSDictionary *)dicForHomeAndPan;


@end

@interface AddPeopleViewController : UIViewController<MyPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;

@property (nonatomic ,weak)id<addPeopleViewDelegate>addDelegate;
@end
