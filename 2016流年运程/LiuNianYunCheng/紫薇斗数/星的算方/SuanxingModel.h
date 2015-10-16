//
//  SuanxingModel.h
//  ziweidoushu
//
//  Created by 吴冬 on 15/7/6.
//  Copyright (c) 2015年 吴冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuanxingModel : NSObject


@property (nonatomic ,assign)NSInteger month;   //月份
@property (nonatomic ,assign)NSInteger hours;   //时间
@property (nonatomic ,copy)NSString   *tiangan; //天干
@property (nonatomic ,assign)NSInteger day;     //出生日期
@property (nonatomic ,strong)NSString *yinyang;  //阴阳
@property (nonatomic ,strong)NSString *shengxiao; //生肖


//传出的数据
@property (nonatomic ,copy)NSString *wuxingSTR;
@property (nonatomic ,copy)NSString *mingzhuSTR;
@property (nonatomic ,copy)NSString *shenzhuSTR;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,assign)NSInteger age;
@property (nonatomic ,assign)NSInteger indexForMingzhu;
@property (nonatomic ,strong)NSArray *daxianArr;
@property (nonatomic ,strong)NSDictionary *dicForBOSHI;
@property (nonatomic ,strong)NSMutableDictionary *superDicForStar;
@property (nonatomic ,strong)NSMutableDictionary *dicForZiwei;
@property (nonatomic ,strong)NSMutableDictionary *dicForTianfu;
@property (nonatomic ,strong)NSDictionary *dicForLiuji;
@property (nonatomic ,strong)NSDictionary *dicForLucun;

//带有庙线的传出字典
@property (nonatomic ,strong)NSDictionary *dicForZiweiOUT;
@property (nonatomic ,strong)NSDictionary *dicForTianfuOUT;
@property (nonatomic ,strong)NSDictionary *dicForLucunOUT;
@property (nonatomic ,strong)NSDictionary *dicForLiujiOUT;
@property (nonatomic ,strong)NSDictionary *dicForTaohuaOUT;
@property (nonatomic ,strong)NSDictionary *dicForXunkongOUT;
@property (nonatomic ,strong)NSDictionary *dicForChangchengOUT;
@property (nonatomic ,strong)NSDictionary *dicForSihuaOUT;
@property (nonatomic ,strong)NSDictionary *dicForZaxingOUT;
@property (nonatomic ,strong)NSDictionary *dicForSuiqianOUT;
@property (nonatomic ,strong)NSDictionary *dicForGongOUT;
@property (nonatomic ,copy)NSString *ziniandoujunSTR;
@property (nonatomic ,strong)NSDictionary *dicForXiaoxianOUT;
@property (nonatomic ,strong)NSDictionary *dicForXiaoxianOUTforTurn;
/**
 *  初始化算命人信息,均为阴历
 *
 *  @param month     出生月份
 *  @param hours     出生时辰
 *  @param tiangan   天干
 *  @param day       出生日期
 *  @param yinyang   阴阳
 *  @param shengxiao 属性，地支
 *  @param name      名字
 *  @param age       年龄
 *
 *  @return 返回人model
 */
- (instancetype)initWithMonth:(NSInteger )month
                     andHours:(NSInteger )hours
                   andTiangan:(NSString *)tiangan
                       andDay:(NSInteger)day
                   andYinyang:(NSString *)yinyang
                 andShengxiao:(NSString *)shengxiao
                      andName:(NSString *)name
                       andAge:(NSInteger )age;


/**
 *  返回出生日的阳历出生年月
 *
 *  @param year  年份
 *  @param month 月份
 *  @param day   日
 *
 *  @return 返回出生年月
 */
- (NSString *)returnActionForBornWithYear:(NSInteger )year
                                 andMonth:(NSInteger )month
                                   andDay:(NSInteger )day
                                 andHours:(NSInteger )hours;

/**
 *  改变成流年的工位
 *
 *  @param index 命宫的新位置
 */
- (NSDictionary *)gongChange:(NSInteger )index;


@end
