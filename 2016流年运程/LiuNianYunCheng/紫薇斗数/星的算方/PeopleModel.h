//
//  PeopleModel.h
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/12.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleModel : NSObject

//主页要存的数据
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *yangli;
@property (nonatomic ,copy)NSString *wuxing;
@property (nonatomic ,copy)NSString *today;
@property (nonatomic ,copy)NSString *right;
@property (nonatomic ,copy)NSString *wrong;
@property (nonatomic ,copy)NSString *geju;
@property (nonatomic ,copy)NSString *shuxiang;
@property (nonatomic ,copy)NSString *ageForHomePage;

//盘要存的数据
@property (nonatomic ,assign)NSInteger yearsNow;  //阳历日期
@property (nonatomic ,assign)NSInteger monthNow;
@property (nonatomic ,assign)NSInteger dayNow;
@property (nonatomic ,assign)NSInteger hoursNow;

@property (nonatomic ,assign)NSInteger hours;     //阴历日期
@property (nonatomic ,assign)NSInteger day;
@property (nonatomic ,assign)NSInteger month;
@property (nonatomic ,copy)NSString *yinliSTR;
@property (nonatomic ,copy)NSString *dizhiSTR;
@property (nonatomic ,copy)NSString *tiangan;
@property (nonatomic ,copy)NSString *yinyang;
@property (nonatomic ,copy)NSString *age;




@end
