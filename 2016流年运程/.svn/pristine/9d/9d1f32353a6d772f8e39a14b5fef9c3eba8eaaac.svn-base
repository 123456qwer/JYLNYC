//
//  SqliteForPeople.h
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface SqliteForPeople : NSObject


//获取数据
- (NSArray *)getAllContacts;

//打开数据库
- (void)openSQL;


//插入数据
- (void)insertRecordIntoTableName:(NSString *)tableName
                             name:(NSString *)name
                        nameValue:(NSString *)nameValue
                           yangli:(NSString *)yangli
                      yangliValue:(NSString *)yangliValue
                           wuxing:(NSString *)wuxing
                      wuxingValue:(NSString *)wuxingValue
                             geju:(NSString *)geju
                        gejuValue:(NSString *)gejuValue
                         shuxiang:(NSString *)shuxiang
                    shuxiangValue:(NSString *)shuxiangValue
                   ageForHomePage:(NSString *)ageForHomePage
              ageForHomePageValue:(NSString *)ageForHomePageValue
                         yearsNow:(NSString *)yearsNow
                    yearsNowValue:(NSString *)yearsNowValue
                         monthNow:(NSString *)monthNow
                    monthNowValue:(NSString *)monthNowValue
                           dayNow:(NSString *)dayNow
                      dayNowValue:(NSString *)dayNowValue
                         hoursNow:(NSString *)hoursNow
                    hoursNowValue:(NSString *)hoursNowValue
                            hours:(NSString *)hours
                       hoursValue:(NSString *)hoursValue
                              day:(NSString *)day
                         dayValue:(NSString *)dayValue
                            month:(NSString *)month
                       monthValue:(NSString *)monthValue
                         yinliSTR:(NSString *)yinliSTR
                    yinliSTRValue:(NSString *)yinliSTRValue
                         dizhiSTR:(NSString *)dizhiSTR
                    dizhiSTRValue:(NSString *)dizhiSTRValue
                          tiangan:(NSString *)tiangan
                     tianganValue:(NSString *)tianganValue
                          yinyang:(NSString *)yinyang
                     yinyangValue:(NSString *)yinyangValue
                              age:(NSString *)age
                         ageValue:(NSString *)ageValue;

//删除数据
-(BOOL)deleteaNote:(NSString *)nameForP;

@property (nonatomic) sqlite3 *database;

@end
