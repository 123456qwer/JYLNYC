//
//  SuanxingModel.m
//  ziweidoushu
//
//  Created by 吴冬 on 15/7/6.
//  Copyright (c) 2015年 吴冬. All rights reserved.
//

#import "SuanxingModel.h"

@implementation SuanxingModel
{
    
//-------------------------------吴冬-----------------------------//
   
    NSArray *arrForMingpan;  //命盘根据这个数组排盘
    NSArray *_forWuxing;     //五行根据这个数组算
    NSDictionary *dicForSAN; //三太星
    NSDictionary *dicForAllstar;  //全部的星
    NSDictionary *_mingzhuDict;   //命主
    NSInteger    _indexForMingzhu; //命主index
    NSDictionary *_shenzhuDict;   //根据这个算身主
    NSArray *_arrForAllGong; //所有需要用到的宫
    NSString *_wuxingSTR;
    NSDictionary *_dicForXiaoxian;  //算小限
    NSMutableArray      *_arrForXiaoxian;
    NSMutableArray      *_arrForXiaoxianOut;
    NSMutableDictionary *_superDicForStar;  //所有的星星字典
    
    
//------------------------------刘江伟----------------------------//

    NSMutableDictionary *yiqiDict;

}

//-------------------------------------------------吴冬------------------------------------------------------//


 /**
 *  初始化
 *
 *  @param month     月份
 *  @param hours     出生小时(如酉时 ，则为10)
 *  @param tiangan   天干 (甲、乙、丙、丁。。。。)
 *  @param day       出生日期
 *  @param yinyang   阴阳属性
 *  @param shengxiao 地支，属性
 *
 *  @return 星整体属性
 */
- (instancetype)initWithMonth:(NSInteger)month
                     andHours:(NSInteger)hours
                   andTiangan:(NSString *)tiangan
                       andDay:(NSInteger)day
                   andYinyang:(NSString *)yinyang
                 andShengxiao:(NSString *)shengxiao
                      andName:(NSString *)name
                       andAge:(NSInteger)age
{
   
    self = [super init];
    if (self) {
        
        //初始化数值
        _name = name;
        _age = age;
        _month = month;
        _hours = hours;
        _tiangan = tiangan;
        _day = day;
        _yinyang = yinyang;
        _shengxiao = shengxiao;
        
        
        _superDicForStar = [NSMutableDictionary dictionary];
        //紫微星字典
        _dicForZiwei = [NSMutableDictionary dictionary];

        //天府星字典
        _dicForTianfu = [NSMutableDictionary dictionary];
        
        //小限字典
        _dicForXiaoxian = @{@"寅":@"辰",
            @"午":@"辰",
            @"戌":@"辰",
            
            @"亥":@"丑",
            @"卯":@"丑",
            @"未":@"丑",
            
            @"巳":@"未",
            @"酉":@"未",
            @"丑":@"未",
            
            @"申":@"戌",
            @"子":@"戌",
            @"辰":@"戌"};
        //小限数组
        _arrForXiaoxian = [NSMutableArray array];
  
        for (int j = 0; j < 12; j++) {

            NSString *str123 = @"" ;

            for (int i = 0; i < 9 ; i ++) {

                NSString *str = [NSString stringWithFormat:@"%d ",1 + j + i * 12];
                str123 = [str123 stringByAppendingString:str];

            }
  
            [_arrForXiaoxian addObject:str123];
        }
        
        _arrForXiaoxianOut = [NSMutableArray array];
        
        for (int i = 0; i < 12; i++) {
            
            NSMutableArray *arr = [NSMutableArray array];
            
            for (int j = 0; j < 9; j++) {
                
                NSString *str = [NSString stringWithFormat:@"%d",i + 1 + j * 12];
                
                [arr addObject:str];
            }
            
            [_arrForXiaoxianOut addObject:arr];
            
        }
        
        
        
        NSLog(@"123 : %@",_arrForXiaoxian[0]);
        
        /**
         *  整个命盘的arr，都是从巳为起始算起，index为0
         */
        arrForMingpan = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];
        
        /**
         *  五行局需要用到的数组，从寅开始算起
         */
        _forWuxing = @[@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑"];
        
        /**
         *  命主计算需要用到的字典
         */
        _mingzhuDict = @{@"子":@"贪狼",@"丑":@"巨门",@"寅":@"存禄",@"卯":@"文曲",@"辰":@"廉贞",@"巳":@"武曲",@"午":@"破军",@"未":@"武曲",@"申":@"廉贞",@"酉":@"文曲",@"戌":@"存禄",@"亥":@"巨门"};
        /**
         *  根据出生以后的属性算出身主
         */
        _shenzhuDict = @{@"子":@"火星",@"丑":@"天相",@"寅":@"天梁",@"卯":@"天同",@"辰":@"文昌",@"巳":@"天机",@"午":@"火星",@"未":@"天相",@"申":@"天梁",@"酉":@"天同",@"戌":@"文昌",@"亥":@"天机"};
       
        /**
         *  算命盘宫的排列用到的数组
         */
        _arrForAllGong = @[@"命宫",@"兄弟",@"夫妻",@"子女",@"财帛",@"疾厄",@"迁移",@"奴仆",@"官禄",@"田宅",@"福德",@"父母"];
        
        
        //创建星字典
        //吴冬
        [self dictionaryForStar1];
        
        
        //创建星字典
        //刘江伟
        [self dictionaryForStar2];
        
        //算命主
        _mingzhuSTR = _mingzhuDict[arrForMingpan[_indexForMingzhu]];
        
        //算身主
        _shenzhuSTR = [_shenzhuDict objectForKey:shengxiao];
        
        //算大限用到的数组
        _daxianArr = [self qidaxian:_wuxingSTR];
        
        //命宫所对的生肖
        NSLog(@"命宫对应生肖: %@",arrForMingpan[_indexForMingzhu]);
        
        //庙线
        [self formiaoxianAction];
        
        //子年斗君
        [self ziniandoujunAction:month withDizhi:hours];
    }

    return self;
}


/**
 *  庙线搭命盘
 */
- (void)formiaoxianAction
{
  
//    NSArray *ziweiArr = @[@"紫薇",@"天机",@"太阳",@"武曲",@"天同",@"廉贞"];
//    NSArray *tianfuArr = @[@"天府",@"太陰",@"貪狼",@"巨門",@"天相",@"天梁",@"七殺",@"破軍"];
//    NSArray *jixingArr = @[@"文昌",@"文曲",@"右弼",@"左辅",@"天魁",@"天钺"];
//    NSArray *lucunArr  = @[@"火星",@"铃星",@"擎羊",@"陀罗",@"禄存",@"地空",@"地劫"];
    NSArray  *dizhiArray = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];

    NSDictionary * duiyingDict =
    
    @{@"紫薇":@[@"-1",@"3",@"3",@"2",@"-3",@"2",@"3",@"3",@"2",@"-1",@"-3",@"2"],
      
      @"天机":@[@"3",@"-3",@"2",@"2",@"3",@"-1",@"3",@"-3",@"-1",@"2",@"3",@"-1"],
      
      @"太阳":@[@"-3",@"-3",@"2",@"3",@"2",@"2",@"3",@"-1",@"-2",@"-2",@"-3",@"-3"],
      
      @"武曲":@[@"2",@"3",@"-2",@"-3",@"3",@"-1",@"2",@"3",@"-1",@"2",@"3",@"-1"],
      
      @"天同":@[@"2",@"-3",@"-2",@"3",@"-1",@"3",@"-3",@"-3",@"2",@"-1",@"-1",@"3"],
      
      @"廉贞":@[@"-1",@"2",@"3",@"-2",@"2",@"-3",@"-1",@"3",@"3",@"-1",@"2",@"-3"],
      
      @"天府":@[@"3",@"3",@"3",@"-1",@"3",@"-1",@"2",@"3",@"-1",@"-3",@"3",@"2"],
     
      @"太阴":@[@"3",@"3",@"-2",@"-3",@"-2",@"-3",@"-3",@"-1",@"-1",@"2",@"2",@"3"],
    
      @"贪狼":@[@"2",@"3",@"-1",@"0",@"3",@"-3",@"2",@"3",@"-1",@"-1",@"3",@"-3"],
    
      @"巨门":@[@"2",@"2",@"3",@"3",@"-1",@"-1",@"2",@"-3",@"3",@"3",@"2",@"2"],
     
      @"天相":@[@"3",@"3",@"3",@"-3",@"2",@"-1",@"2",@"-2",@"3",@"-3",@"-2",@"-1"],
     
      @"天梁":@[@"3",@"2",@"3",@"3",@"2",@"-3",@"3",@"2",@"-3",@"1",@"2",@"-3"],
     
      @"七杀":@[@"2",@"3",@"3",@"-3",@"2",@"-1",@"2",@"2",@"3",@"-2",@"3",@"-1"],
     
      @"破军":@[@"3",@"2",@"-3",@"2",@"2",@"-2",@"3",@"3",@"-3",@"-3",@"2",@"-1"],
    
      @"火星":@[@"-1",@"2",@"3",@"-1",@"-2",@"2",@"3",@"-2",@"-3",@"-3",@"3",@"-1"],
     
      @"铃星":@[@"-3",@"-3",@"3",@"3",@"2",@"2",@"3",@"2",@"2",@"-3",@"3",@"3"],
      
      @"擎羊":@[@"-3",@"3",@"4",@"-3",@"3",@"4",@"-1",@"3",@"4",@"-3",@"3",@"4"],
      
      @"陀罗":@[@"4",@"3",@"-3",@"4",@"3",@"-3",@"4",@"3",@"-3",@"4",@"3",@"-3"],
      
      @"文昌":@[@"2",@"3",@"-3",@"-1",@"2",@"3",@"-3",@"-1",@"2",@"3",@"-3",@"2"],
      
      @"文曲":@[@"3",@"3",@"-1",@"2",@"3",@"3",@"-3",@"2",@"-1",@"3",@"-3",@"2"]};
    
    
    NSDictionary * miaoDict = @{@"0":@"利",
                                @"1":@"地",
                                @"2":@"旺",
                                @"3":@"庙",
                                @"-1":@"平",
                                @"-2":@"闲",
                                @"-3":@"陷",
                                @"4":@""};
    
    //紫薇
    NSMutableDictionary *ziweiNumber = [NSMutableDictionary dictionary];
    
    for (int i = 0; i<12; i++) {
        
        NSString *dizhiSTR = dizhiArray[i];
        
        for (int j = 0; j < _dicForZiwei.count; j++) {
            
            if ([_dicForZiwei[_dicForZiwei.allKeys[j]] isEqualToString:dizhiSTR]) {
                
                NSArray *arrForZi = duiyingDict[_dicForZiwei.allKeys[j]];
                
                NSString *strForMiao = miaoDict[arrForZi[i]];
                
                
                if (strForMiao == NULL) {
                    
                    strForMiao = @"";
                }
                
                NSString *strForPinjie = [NSString stringWithFormat:@"%@%@",_dicForZiwei.allKeys[j],strForMiao];
                
                [ziweiNumber setObject:dizhiSTR forKey:strForPinjie];
                
            }
            
        }
        
    }
    
    
    //天府
    NSMutableDictionary *tianfuNumber = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < 12; i++) {
        
        NSString *dizhiSTR = dizhiArray[i];
        
        for (int j = 0; j < _dicForTianfu.count; j++) {
            
            if ([_dicForTianfu[_dicForTianfu.allKeys[j]] isEqualToString:dizhiSTR]) {
                
                NSArray *arrForZi = duiyingDict[_dicForTianfu.allKeys[j]];
                
                NSString *strForMiao = miaoDict[arrForZi[i]];
                
                
                if (strForMiao == NULL) {
                    
                    strForMiao = @"";
                }
                
                NSString *strForPinjie = [NSString stringWithFormat:@"%@%@",_dicForTianfu.allKeys[j],strForMiao];
                
                [tianfuNumber setObject:dizhiSTR forKey:strForPinjie];
                
            }
            
        }
        
    }
    
    
    //禄存星
    NSMutableDictionary *lucunNumber = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < 12; i++) {
        
        NSString *dizhiSTR = dizhiArray[i];
        
        for (int j = 0; j < _dicForLucun.count; j++) {
            
            if ([_dicForLucun[_dicForLucun.allKeys[j]] isEqualToString:dizhiSTR]) {
                
                NSArray *arrForZi = duiyingDict[_dicForLucun.allKeys[j]];
                
                NSString *strForMiao = miaoDict[arrForZi[i]];
                
                if (strForMiao == NULL) {
                    
                    strForMiao = @"";
                }
                
                NSString *strForPinjie = [NSString stringWithFormat:@"%@%@",_dicForLucun.allKeys[j],strForMiao];
                
                [lucunNumber setObject:dizhiSTR forKey:strForPinjie];
                
            }
            
        }
    }
    
    //六吉
    NSMutableDictionary *liujiNumber = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < 12; i++) {
        
        NSString *dizhiSTR = dizhiArray[i];
        
        for (int j = 0; j < _dicForLiuji.count; j++) {
            
            if ([_dicForLiuji[_dicForLiuji.allKeys[j]] isEqualToString:dizhiSTR]) {
                
                NSArray *arrForZi = duiyingDict[_dicForLiuji.allKeys[j]];
                
                NSString *strForMiao = miaoDict[arrForZi[i]];
                
                if (strForMiao == NULL) {
                    
                    strForMiao = @"";
                }
                
                NSString *strForPinjie = [NSString stringWithFormat:@"%@%@",_dicForLiuji.allKeys[j],strForMiao];
                
                [liujiNumber setObject:dizhiSTR forKey:strForPinjie];
                
            }
            
        }
    }
    

    

    _dicForZiweiOUT = ziweiNumber;
    _dicForTianfuOUT = tianfuNumber;
    _dicForLucunOUT = lucunNumber;
    _dicForLiujiOUT = liujiNumber;
}


/**
 *  子年斗君
 *
 *  @param month    阴历月份
 *  @param dizhiSTR 时辰，在数组里需要减1
 */
- (void)ziniandoujunAction:(NSInteger )month
                 withDizhi:(NSInteger )dizhiSTR  //需要减1
{
   
    NSInteger dizhistr = dizhiSTR - 1;
    
    NSArray *arrForShichen = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
    
    //取出时辰对应的生肖
    NSString *shichen = arrForShichen[dizhistr];
    
    NSDictionary *dicForZijun = @{@"子":
  @[@"子",@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑"],
                                  @"丑":
  @[@"丑",@"子",@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅"],
                                  @"寅":
  @[@"寅",@"丑",@"子",@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯"],
                                  @"卯":
  @[@"卯",@"寅",@"丑",@"子",@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰"],
                                  @"辰":
  @[@"辰",@"卯",@"寅",@"丑",@"子",@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳"],
                                  @"巳":
  @[@"巳",@"辰",@"卯",@"寅",@"丑",@"子",@"亥",@"戌",@"酉",@"申",@"未",@"午"],
                                  @"午":
  @[@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子",@"亥",@"戌",@"酉",@"申",@"未"],
                                  @"未":
  @[@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子",@"亥",@"戌",@"酉",@"申"],
                                  @"申":
  @[@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子",@"亥",@"戌",@"酉"],
                                  @"酉":
  @[@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子",@"亥",@"戌"],
                                  @"戌":
  @[@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子",@"亥"],
                                  @"亥":
  @[@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子"]};

    _ziniandoujunSTR = [dicForZijun[shichen] objectAtIndex:month - 1];

}


/**
 *  算阳历年
 *
 *  @param year  年
 *  @param month 月
 *  @param day   日
 *  @param hours 时辰
 *
 *  @return 返回阳历的具体出生日期（阳历：2005年12月23日08时）
 */
- (NSString *)returnActionForBornWithYear:(NSInteger)year
                                 andMonth:(NSInteger)month
                                   andDay:(NSInteger)day
                                 andHours:(NSInteger )hours
{
  
    
    NSString *monthSTR;
    NSString *daySTR;
    NSString *hoursSTR;
    if (month > 9) {
        
        monthSTR = [NSString stringWithFormat:@"%ld月",month];
        
    }else{
      
        monthSTR = [NSString stringWithFormat:@"0%ld月",month];
    
    }
    
    if (day > 9) {
       
        daySTR = [NSString stringWithFormat:@"%ld日",day];

    }else{
    
        daySTR = [NSString stringWithFormat:@"0%ld日",day];
    }
    
    if (hours > 9) {
        
        hoursSTR = [NSString stringWithFormat:@"%ld时",hours];

    }else{
       
        hoursSTR = [NSString stringWithFormat:@"0%ld时",hours];
        
    }
    
    NSString *bornDay = [NSString stringWithFormat:@"%ld年%@%@%@",year,monthSTR,daySTR,hoursSTR];
    
    
    return bornDay;
  
}


/**
 *  创建星所属的字典（刘江伟）
 */
- (void)dictionaryForStar2
{
    
    //14主
    NSDictionary *shisizhuxing =  [self anZiweixingWuxingjushu:_wuxingSTR chushengriqi:_day];
    
    //6吉
    NSDictionary *liujixingDictttt =  [self anLiujixingChushengniangan:_tiangan andMonth:_month andHour:_hours];
    
    //安四桃花
    [self anSitaohuaTianxinxingAndTianmaxingNiandizhi:_shengxiao AndShengYue:_month];
    
    //禄存星
    NSDictionary *luchunxingheliushaxing=[self anLuCunxingAndLiuShaXingCSNYtiangan:_tiangan AndCSNYdizhi:_shengxiao AndChuShengShiChen:_hours];
    
    //四化
    [self anSihuaxingAndZhuxingDict:shisizhuxing andLjxDict:liujixingDictttt nianTiangan:_tiangan];
    
    //生年旬空
    [self anXunkongxingAndNianTiangan:_tiangan AndNdz:_shengxiao];
    
    //安生年博士十二神
    _dicForBOSHI = [self anShengNianBoshiShiershenAndlucunxing:luchunxingheliushaxing withYinyang:_yinyang];
    
    //安生年岁前十二星
    [self anShengSuiQianShierxingAndnianDizhi:_shengxiao];
    
    //安生年将前十二星
    [self anShengNianJiangQIanShierxingAndNianDizhi:_shengxiao];

}


/**
 *  宫
 *
 *  @param dicForGongOUT
 */

- (NSDictionary *)gongChange:(NSInteger )index
{
   
    NSMutableDictionary *dicForGong = [NSMutableDictionary dictionary];
    //创建一个命宫的字典
    for (int i = 0; i < 12; i++) {
        
        if (i == index) {
            
            for (int j = 0; j < 12; j++) {
                
                int a ;
                
                if (i - j >= 0) {
                    
                    a = i - j;
                }else{
                    
                    a = i - j + 12;
                }
                
                //这个存储方法和之前的相反
                
                NSString *dizhiForGong = arrForMingpan[a];
                NSString *gong = _arrForAllGong[j];
                
                [dicForGong setObject:gong forKey:dizhiForGong];
                
            }
            
        }
        
    }
  
    return dicForGong;


}

/**
 *  创建星所属的字典(吴冬)
 */
- (void)dictionaryForStar1
{
    //算身宫位置，从巳开始算起
    NSInteger indexForShengong = [self shengongWithMonth:_month andHours:_hours];
    
    //算命宫位置，从巳开始算起
    NSInteger indexForMinggong = [self minggongWithMonth:_month andHours:_hours];
    
    _indexForMingzhu = indexForMinggong;
    
 
    
    //命宫对应的生肖
    NSString *dizhiForMinggong = arrForMingpan[indexForMinggong];
    
    NSMutableDictionary *dicForGong = [NSMutableDictionary dictionary];
    //创建一个命宫的字典
    for (int i = 0; i < 12; i++) {
        
        if (i == _indexForMingzhu) {
            
            for (int j = 0; j < 12; j++) {
                
                int a ;
                
                if (i - j >= 0) {
                    
                    a = i - j;
                }else{
                
                    a = i - j + 12;
                }
                
                //这个存储方法和之前的相反
                
                NSString *dizhiForGong = arrForMingpan[a];
                NSString *gong = _arrForAllGong[j];
                
                [dicForGong setObject:gong forKey:dizhiForGong];
                
            }
            
        }
        
    }
    //宫所对应的字典
    _dicForGongOUT = dicForGong;

    //五行局
    _wuxingSTR = [self wuxingjuDizhi:dizhiForMinggong tiangan:_tiangan withYINYANG:_yinyang];
    
    //返回紫微，天机、太阳、武曲、天同以及廉贞   天府，太阴、贪狼、巨门、天相、天梁、七杀以及破军星
    [self returnForZiwei:_wuxingSTR day:_day];
    
    [self changshengWithWuxing:_wuxingSTR andYinyang:_yinyang];
    
    
    //龙池凤阁,天哭天虚,孤辰寡宿,天月天巫,白虎丧门,阴煞台辅,封诰华盖,劫煞破碎，大耗天德，龙德月德，天空蜚廉，天官天福，截空三台，八座天贵，恩光天才，天寿天伤，天使。
    
    [self returnForOtherStarWithDizhi:_shengxiao
                                                            andMonth:_month
                                                            andHours:_hours
                                                          andTiangan:_tiangan
                                                              andDay:_day
                                                   andShenTagFromYIN:indexForShengong
                                                    andMingTagFromSi:indexForMinggong];
    
    //六吉星
    _dicForLiuji = [self anLiujixingChushengniangan:_tiangan andMonth:_month andHour:_hours];
    
    //禄存星
    _dicForLucun = [self anLuCunxingAndLiuShaXingCSNYtianganwd:_tiangan AndCSNYdizhi:_shengxiao AndChuShengShiChen:_hours];
    
    //算小限
    [self createXiaoxianWithDz:_shengxiao andYinyang:_yinyang];


}


- (void)createXiaoxianWithDz:(NSString *)dizhiStr andYinyang:(NSString *)yinyang
{
    _dicForXiaoxian = @{@"寅":@"辰",
                        @"午":@"辰",
                        @"戌":@"辰",
                        
                        @"亥":@"丑",
                        @"卯":@"丑",
                        @"未":@"丑",
                        
                        @"巳":@"未",
                        @"酉":@"未",
                        @"丑":@"未",
                        
                        @"申":@"戌",
                        @"子":@"戌",
                        @"辰":@"戌"};
    
    NSString *dizhiStrNow = _dicForXiaoxian[dizhiStr];
    NSMutableDictionary *dicForXiaoxianNow = [NSMutableDictionary dictionary];
    NSMutableDictionary *dicForXiaoxianOutforTur = [NSMutableDictionary dictionary];
    
    if ([yinyang isEqualToString:@"阳男"] || [yinyang isEqualToString:@"阴女"]) {
         //顺时针
        
        for (int i = 0; i < 12; i++) {
            
            NSString *dizhi = arrForMingpan[i];
            
            if ([dizhiStrNow isEqualToString:dizhi]) {
                
                for (int j = 0; j < 12; j++) {
                    
                    
                    if (j <= i) {
                        
                        int a ;
                        
                        if (j + i >= 12) {
                            
                            a = j + i - 12;
                            
                        }else{
                        
                            a = j + i;
                        }
                        
                        NSString *dizhiS = arrForMingpan[a];
                        
                        NSString *strForXiaoxian = _arrForXiaoxian[j];
                        
                        [dicForXiaoxianNow setObject:strForXiaoxian forKey:dizhiS];
                        
                        //传出转换用的小仙
                        
                        NSArray *arrForXiaoxianO = _arrForXiaoxianOut[j];
                        
                        [dicForXiaoxianOutforTur setObject:arrForXiaoxianO forKey:dizhiS];
                        
                        
                    }else{
                    
                    
                        int a ;
                        
                        if (j + i >= 12) {
                            
                            a = j + i - 12;
                            
                        }else{
                            
                            a = j + i;
                        }
                        
                        NSString *dizhiS = arrForMingpan[a];
                        
                        NSString *strForXiaoxian = _arrForXiaoxian[j];
                        
                        [dicForXiaoxianNow setObject:strForXiaoxian forKey:dizhiS];
                        
                        
                        //传出转换用的小仙
                        
                        NSArray *arrForXiaoxianO = _arrForXiaoxianOut[j];
                        
                        [dicForXiaoxianOutforTur setObject:arrForXiaoxianO forKey:dizhiS];
                    
                    }
                    
                    
                }
                
            }
            
            
        }
        
        
    }else{
         //逆时针
        
        for (int i = 0; i < 12; i ++) {
            
            NSString *dizhi = arrForMingpan[i];
            
            if ([dizhiStrNow isEqualToString:dizhi]) {
                
                for (int j = 0; j < 12; j ++) {
                    
                    
                    if (j <= i) {
                        
                        NSString *dizhiS = arrForMingpan[i - j];
                        
                        NSString *strForXiaoxian = _arrForXiaoxian[j];
                        
                        [dicForXiaoxianNow setObject:strForXiaoxian forKey:dizhiS];
                        
                        
                        //传出转换用的小仙
                        
                        NSArray *arrForXiaoxianO = _arrForXiaoxianOut[j];
                        
                        [dicForXiaoxianOutforTur setObject:arrForXiaoxianO forKey:dizhiS];
                        
                    }else{
                    
                        NSString *dizhiS = arrForMingpan[12 - (j - i)];
                        
                        NSString *strForXiaoxian = _arrForXiaoxian[j];

                        [dicForXiaoxianNow setObject:strForXiaoxian forKey:dizhiS];
                        
                        
                        //传出转换用的小仙
                        
                        NSArray *arrForXiaoxianO = _arrForXiaoxianOut[j];
                        
                        [dicForXiaoxianOutforTur setObject:arrForXiaoxianO forKey:dizhiS];

                    }
                    
                    
                    
                }
                
            }
            
            
        }
    
    }
    
    _dicForXiaoxianOUT = dicForXiaoxianNow;
    
    _dicForXiaoxianOUTforTurn = dicForXiaoxianOutforTur;

}


/**
 *  算长生12神
 *
 *  @param wuxing  五行
 *  @param yinyang 阴阳
 *
 *  @return 安长生十二神
 
 长生落宫由五行局确定：金长生在巳，木长生在亥，火长生在寅，水土长生在申。由长生宫起头，阳男阴女顺时针，阴男阳女逆时针依次安长生、沐浴、冠带、临官、帝旺、衰、病、死、墓、绝、胎、养，一宫安一星，写在干支的上面。
 */
- (NSDictionary *)changshengWithWuxing:(NSString *)wuxing
                            andYinyang:(NSString *)yinyang
{

    wuxing = [wuxing substringWithRange:NSMakeRange(0, 1)];
    NSDictionary * dict = @{@"金":@"巳",
                            @"木":@"亥",
                            @"水":@"申",
                            @"火":@"寅",
                            @"土":@"申"};
    NSString  * kaishiDZ = dict[wuxing];
    //arrForMingpan = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];

    NSArray *changshengArr = @[@"长生",@"沐浴",@"冠带",@"临官",@"帝旺",@"衰",@"病",@"死",@"墓",@"绝",@"胎",@"养"];
    NSMutableDictionary *dicForChangsheng = [NSMutableDictionary dictionary];
    
    if ([_yinyang isEqualToString:@"阳男"] || [_yinyang isEqualToString:@"阴女"]) {
        
        for (int i = 0; i < 12; i++) {
            
            NSString *changshengSTR = arrForMingpan[i];
            
            if ([changshengSTR isEqualToString:kaishiDZ]) {
                
                for (int j = 0; j < changshengArr.count; j++) {
                    
                    NSString *dizhiForChangsheng;

                        
                        int a ;
                        
                        if (i + j >=12) {
                            
                            a = i + j - 12;
                        }else{
                        
                           a = i + j;
                        }
                        
                        dizhiForChangsheng = arrForMingpan[a];
                        

                    
                    
                    [dicForChangsheng setObject:dizhiForChangsheng forKey:changshengArr[j]];
                    
                    
                }
                
            }
            
        }

        
    }else{
    
       
        for (int i = 0; i < 12; i++) {
            
            NSString *changshengSTR = arrForMingpan[i];
            
            if ([changshengSTR isEqualToString:kaishiDZ]) {
                
                for (int j = 0; j < changshengArr.count; j++) {
                    
                    NSString *dizhiForChangsheng;
                    
                    if (i >= j) {
                        
                        dizhiForChangsheng = arrForMingpan[i-j];
                        
                        
                    }else{
                        
                
                        
                        dizhiForChangsheng = arrForMingpan[12 - (j - i)];
                        
                    }
                    
                    
                    [dicForChangsheng setObject:dizhiForChangsheng forKey:changshengArr[j]];
                    
                    
                }
                
            }
            

            
        }
    
    }
    
    
    _dicForChangchengOUT = dicForChangsheng;
    
    return dicForChangsheng;
}



/**
 *  工具方法，算命宫位置
 *
 *  @param month 月份
 *  @param hours 时辰
 *
 *  @return 返回命宫位置，以巳为起点开始算起
 */
- (NSInteger )minggongWithMonth:(NSInteger )month andHours:(NSInteger )hours
{
    
    //命宫
    NSInteger minggong ;
    NSInteger tagGong;
    //月份和时辰相等，月份大于时辰，月份小于时辰三种情况
    if (month - hours > 0) {
        
        minggong = month - hours;
        
        //获取命宫所在的View 例如：12 1 ，所在的view就是第8个。因为寅确定为第9格
        
        
        //如果minggong加上初始的9小于12，tag直接取就可以了，如果大于12就要减去相应的
        if (9 + minggong < 12) {
            
            tagGong = 9 + minggong;
            
            
            
        }else if (9 + minggong >=12){
            
            tagGong = 9 + minggong - 12;
            
            
        }
        
        
        
    }else if(month - hours <= 0){
        
        minggong = labs(month - hours);
        
        //月份小于时辰又分为，差值大于9或小于9的情况,如果差值小于9直接取差值为命宫位置，反之用差值+12取命宫位置
        
        if (minggong < 9) {
            
            tagGong = 9 - minggong;
            
            
        }else if(minggong > 9){
            
            
            tagGong = 12 + (9 - minggong);
            
            
            
        }else if(minggong == 9){
            
            tagGong = 0;
            
            
            
        }else if(month == hours){
            
            tagGong = 9;
            
        }
        
    }
    return tagGong;
}

/**
 *  工具方法，算身宫位置
 *
 *  @param month 月份
 *  @param hours 时辰
 *
 *  @return 返回身宫位置，以巳为起点开始算起
 */
- (NSInteger )shengongWithMonth:(NSInteger )month andHours:(NSInteger )hours
{
    // NSInteger tagView;
    
    NSInteger shengong ;
    NSInteger tagView;
    
    if (month + hours < 12) {
        
        shengong = month + hours ;
        
        tagView = shengong - 2 + 9;
        
        
        if (tagView > 12) {
            
            tagView = tagView - 12 ;
            
            
            
            
        }else if(tagView < 12){
            
            
            
        }
        
        return tagView;
        
    }else if(month + hours >= 12){
        
        shengong = month + hours ;
        
        tagView = shengong - 2 + 9;
        
        
        if (tagView > 12) {
            
            tagView = tagView - 12 ;
            
            if (tagView >= 12) {
                
                tagView = tagView - 12;
                
                
            }else if(tagView < 12){
                
                
            }
            
            return tagView;
            
        }else if(tagView < 12){
            
            return tagView;
            
        }
        
        
    }
    
    return tagView;
    
}


/**
 *  定五行局《出生年份的天干 配合 命宫地支》
 *
 *  @param mdz        地支
 *  @param chnytg     天干
 *  @param yinyangSTR 阴阳
 *
 *  @return 五行局
 */
-(NSString * )wuxingjuDizhi:(NSString * ) mdz
                    tiangan:(NSString *)chnytg
                withYINYANG:(NSString *)yinyangSTR{
    
    NSDictionary * mgdizhi  = @{
                                @"子":@[@"水二局",@"火六局",@"土五局",@"木三局",@"金四局"],
                                @"丑":@[@"水二局",@"火六局",@"土五局",@"木三局",@"金四局"],
                                @"午":@[@"土五局",@"木三局",@"金四局",@"水二局",@"火六局"],
                                @"未":@[@"土五局",@"木三局",@"金四局",@"水二局",@"火六局"],
                                @"寅":@[@"火六局",@"土五局",@"木三局",@"金四局",@"水二局"],
                                @"卯":@[@"火六局",@"土五局",@"木三局",@"金四局",@"水二局"],
                                @"申":@[@"金四局",@"水二局",@"火六局",@"土五局",@"木三局"],
                                @"酉":@[@"金四局",@"水二局",@"火六局",@"土五局",@"木三局"],
                                @"辰":@[@"木三局",@"金四局",@"水二局",@"火六局",@"土五局"],
                                @"巳":@[@"木三局",@"金四局",@"水二局",@"火六局",@"土五局"],
                                @"戌":@[@"火六局",@"土五局",@"木三局",@"金四局",@"水二局"],
                                @"亥":@[@"火六局",@"土五局",@"木三局",@"金四局",@"水二局"]};
    
    
    
    NSDictionary * mgTiangan = @{@"甲":@(0),@"乙":@(1),@"丙":@(2),@"丁":@(3),@"戊":@(4),@"己":@(0),@"庚":@(1),@"辛":@(2),@"壬":@(3),@"癸":@(4)};
    //根据传进来命宫的地支获取相应地支的数组
    NSArray  * wuxingjuArray = mgdizhi[mdz];
    
    //根据传进来的出生年月天干获取在数组中对应的位置
    NSInteger   index = [mgTiangan[chnytg] intValue];
    
    //根据位置取出数组中对应的五行局
    NSString * wuxingjuStr = wuxingjuArray[index];

    return wuxingjuStr;
}



/**
 
 在定了命宫五行局之后，便可以根据出生的日期定紫微星的宫位了，紫微星是紫微斗数排盘中的第一颗星曜，起紫微星的公式如下：
 
 紫微星位置（商数）= （出生日期 + X ）除 五行局数
 　　设：X = 补码
 　　如果：X = 0，依所得商数安紫微星。
 　　如果：X = 单数，以商数所得位置逆数 X 数安紫微星。
 　　如果：X = 双数，以商数所得位置顺数 X 数安紫微星。
 商数定位：
 　　寅 = 1，卯 = 2，辰 = 3，巳 = 4，午 = 5，未 = 6，申 = 7，酉 = 8，戌 = 9，亥 = 10，子 = 11，丑 = 12。
 例：
 
 11月初八生，木三局：（8+1）/3=3，X=1，商数为3=辰，辰位逆数1位定紫微星，即卯。
 
 （如果是闰月生要看当年闰月之前的这个月是大月30天还是小月29天，加上相应的天数来计算即可。）
 *
 *  @param wuxingjushu 五行
 *  @param day         日期
 *
 *  @return 返回紫微，天机、太阳、武曲、天同以及廉贞   天府，太阴、贪狼、巨门、天相、天梁、七杀以及破军星；
 */
- (NSDictionary *)returnForZiwei:(NSString *)wuxingjushu day:(NSInteger )day
{
    NSDictionary * wuxingjuduiyingde = @{@"水二局":@(2),@"木三局":@(3),@"金四局":@(4),@"土五局":@(5),@"火六局":@(6)};
    NSArray *arrForZiwei = @[@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑"];
    // NSArray *arrForZiweiNi = @[@""]
    NSMutableDictionary *dicForZHUXING = [NSMutableDictionary dictionary];
    NSInteger jushu = [wuxingjuduiyingde[wuxingjushu] integerValue];
    NSString *dizhiForZiweiStr; //判断紫微星的地支
    NSInteger indexForZiwei;
    if (day % jushu == 0) {
        
        indexForZiwei = day / jushu;
        
        if (indexForZiwei > 12) {
            
            indexForZiwei = indexForZiwei - 12;
            
        }
        
        NSString *dizhiForZiwei = arrForZiwei[indexForZiwei - 1];
        dizhiForZiweiStr = dizhiForZiwei;
        indexForZiwei = indexForZiwei - 1;
        [dicForZHUXING setObject:dizhiForZiwei forKey:@"紫薇"];
        [_dicForZiwei setObject:dizhiForZiwei forKey:@"紫薇"];
        
    }else if(day % jushu != 0){
        
        //算法  例：
        //                   day    indexForSHANG3            indexForSHANG2
        //                     ↓         ↓                         ↓
        //11月初八生，木三局：（  8    +     1   ）      /     3  =    3，  X = 1，商数为3=辰，辰位逆数1位定紫微星，即卯。
        
        NSInteger indexForSHANG1 = day / jushu;
        
        NSInteger indexForSHANG2 = indexForSHANG1 + 1;  // 商
        
        NSInteger aaa = indexForSHANG2;
        
        if (aaa > 12) {
            
            aaa = aaa - 12;
        }
        
        indexForZiwei = aaa;      //紫薇星的index；
        
        NSInteger indexForSHANG3 = indexForSHANG2 * jushu - day;  // X
        
        if (indexForSHANG3 % 2 == 0) {
            
            //顺数
            for (int i = 0; i < 12; i++) {
                
                if ([arrForZiwei[i] isEqualToString:arrForZiwei[indexForSHANG2 - 1]]) {
                    
                    NSString *dizhiForZiwei =  arrForZiwei[i + indexForSHANG3];
                    dizhiForZiweiStr = dizhiForZiwei;
                    [dicForZHUXING setObject:dizhiForZiwei forKey:@"紫薇"];
                    [_dicForZiwei setObject:dizhiForZiwei forKey:@"紫薇"];
                }
                
            }
            
        }else{
            
            //逆数
            for (int i = 0; i < 12; i++) {
                
                if ([arrForZiwei[i] isEqualToString:arrForZiwei[aaa - 1]]) {
                    
                     indexForZiwei = i - indexForSHANG3;
                    
                    if (indexForZiwei < 0) {
                        
                        indexForZiwei = 12 + indexForZiwei;
                        
                    }
                    
                    NSString *dizhiForZiwei =  arrForZiwei[indexForZiwei];
                    dizhiForZiweiStr = dizhiForZiwei;
                    [dicForZHUXING setObject:dizhiForZiwei forKey:@"紫薇"];
                    [_dicForZiwei setObject:dizhiForZiwei forKey:@"紫薇"];
                }
                
            }
            
        }
        
        
    }
    /*    NSArray *arrForZiwei = @[@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑"];

     紫微星安定后，紫微星系统的其它五颗则依逆时针方向排列，排列方向为接着宫位安天机星，间隔一个宫位依序安太阳星、武曲星、天同星，再间隔二个宫位安廉贞星。若以紫微星所在的宫位称之为第一宫，则逆时针方向的
     第二、四、五、六、九宫分别是天机、太阳、武曲、天同以及廉贞的所在宫位。
     天府星系统为顺时针排列，天府星与紫微星成四十五度角对称排列（即寅与申宫的连线上下对称，寅对申，卯对丑，辰对子，巳对亥，午对戌，未对酉）。若以天府星所在的宫位称之为第一宫，则顺时针方向的第二、三、四、五、六、七、以及十一宫分别是太阴、贪狼、巨门、天相、天梁、七杀以及破军星的位置。
     */
    
    NSDictionary *dicForZiwei = @{@"巳":@(0),@"午":@(1),@"未":@(2),@"申":@(3),@"酉":@(4),@"戌":@(5),@"亥":@(6),@"子":@(7),@"丑":@(8),@"寅":@(9),@"卯":@(10),@"辰":@(11)};
    //天府星与紫微星成四十五度角对称排列（即寅与申宫的连线上下对称，寅对申，卯对丑，辰对子，巳对亥，午对戌，未对酉）
    NSDictionary *dicForTianfu = @{@"寅":@"寅",@"卯":@"丑",@"辰":@"子",@"巳":@"亥",@"午":@"戌",@"未":@"酉",@"申":@"申",@"酉":@"未",@"戌":@"午",@"亥":@"巳",@"子":@"辰",@"丑":@"卯"};
    
    NSString *dizhiForTianfu = dicForTianfu[dizhiForZiweiStr];
    
    
    //紫微星index
    indexForZiwei = [dicForZiwei[dizhiForZiweiStr] integerValue];
    
    //天府星 index
    NSInteger indexForTianfu = [dicForZiwei[dizhiForTianfu] integerValue];

    
    NSString *dizhiForTIANFU = arrForMingpan[indexForTianfu];
    [dicForZHUXING setObject:dizhiForTIANFU forKey:@"天府"];
    [_dicForTianfu setObject:dizhiForTIANFU forKey:@"天府"];
    //太阴
    NSInteger indexForTaiyin = indexForTianfu + 1;
    
    if (indexForTaiyin >= 12) {
        
        indexForTaiyin = indexForTaiyin - 12;
        
    }
    
    NSString *dizhiForTAIYIN = arrForMingpan[indexForTaiyin];
    [dicForZHUXING setObject:dizhiForTAIYIN forKey:@"太阴"];
    [_dicForTianfu setObject:dizhiForTAIYIN forKey:@"太阴"];
    
    //贪狼
    NSInteger indexForTanlang = indexForTaiyin + 1;
    
    if (indexForTanlang >= 12) {
        
        indexForTanlang = indexForTanlang - 12;
        
    }
    
    NSString *dizhiForTANLANG = arrForMingpan[indexForTanlang];
    [dicForZHUXING setObject:dizhiForTANLANG forKey:@"贪狼"];
    [_dicForTianfu setObject:dizhiForTANLANG forKey:@"贪狼"];
    
    //巨门
    NSInteger indexForJumen = indexForTanlang + 1;
    
    if (indexForJumen >= 12) {
        
        indexForJumen = indexForJumen - 12;
        
    }
    
    NSString *dizhiForJumen = arrForMingpan[indexForJumen];
    [dicForZHUXING setObject:dizhiForJumen forKey:@"巨门"];
    [_dicForTianfu setObject:dizhiForJumen forKey:@"巨门"];
    
    //天相
    NSInteger indexForTianxiang = indexForJumen + 1;
    
    if (indexForTianxiang >= 12) {
        
        indexForTianxiang = indexForTianxiang - 12;
        
    }
    
    NSString *dizhiForTianxiang = arrForMingpan[indexForTianxiang];
    [dicForZHUXING setObject:dizhiForTianxiang forKey:@"天相"];
    [_dicForTianfu setObject:dizhiForTianxiang forKey:@"天相"];
    
    //天梁
    NSInteger indexForTianliang = indexForTianxiang + 1;
    
    if (indexForTianliang >= 12) {
        
        indexForTianliang = indexForTianliang - 12;
        
    }
    
    NSString *dizhiForTianliang = arrForMingpan[indexForTianliang];
    [dicForZHUXING setObject:dizhiForTianliang forKey:@"天梁"];
    [_dicForTianfu setObject:dizhiForTianliang forKey:@"天梁"];
    //七杀
    NSInteger indexForQisha = indexForTianliang + 1;
    
    if (indexForQisha >= 12) {
        
        indexForQisha = indexForQisha - 12;
        
    }
    
    NSString *dizhiForQisha = arrForMingpan[indexForQisha];
    [dicForZHUXING setObject:dizhiForQisha forKey:@"七杀"];
    [_dicForTianfu setObject:dizhiForQisha forKey:@"七杀"];
    
    //破军
    NSInteger indexForPojun = indexForQisha + 1 + 3;
    
    if (indexForPojun >= 12) {
        
        indexForPojun = indexForPojun - 12;
        
    }
    
    NSString *dizhiForPojun = arrForMingpan[indexForPojun];
    [dicForZHUXING setObject:dizhiForPojun forKey:@"破军"];
    [_dicForTianfu setObject:dizhiForPojun forKey:@"破军"];

    
    //天机星
    NSInteger indexForTianji = indexForZiwei - 1;  //indexForZiwei - 1 标示数组中的位置，如紫薇在辰，实际index为3，数组中为2
    
    if (indexForTianji < 0) {
        
        indexForTianji = indexForTianji + 12;
        
    }
    
    NSString *dizhiForTIANJI = arrForMingpan[indexForTianji];
    [dicForZHUXING setObject:dizhiForTIANJI forKey:@"天机"];
    [_dicForZiwei setObject:dizhiForTIANJI forKey:@"天机"];
    //太阳星
    NSInteger indexForTaiyang = indexForTianji - 1 - 1;
    
    if (indexForTaiyang < 0) {
        
        indexForTaiyang = indexForTaiyang + 12;
        
    }
    
    NSString *dizhiForTaiyang = arrForMingpan[indexForTaiyang];
    [dicForZHUXING setObject:dizhiForTaiyang forKey:@"太阳"];
    [_dicForZiwei setObject:dizhiForTaiyang forKey:@"太阳"];
    
    //武曲星
    NSInteger indexForWuqu = indexForTaiyang - 1;
    
    if (indexForWuqu < 0) {
        
        indexForWuqu = indexForWuqu + 12;
    }
    
    NSString *dizhiForWuqu = arrForMingpan[indexForWuqu];
    [dicForZHUXING setObject:dizhiForWuqu forKey:@"武曲"];
    [_dicForZiwei setObject:dizhiForWuqu forKey:@"武曲"];
    
    //天同星
    NSInteger indexForTiantong = indexForWuqu - 1;
    
    if (indexForTiantong< 0) {
        
        indexForTiantong = indexForTiantong + 12;
    }
    
    NSString *dizhiForTiantong = arrForMingpan[indexForTiantong];
    [dicForZHUXING setObject:dizhiForTiantong forKey:@"天同"];
    [_dicForZiwei setObject:dizhiForTiantong forKey:@"天同"];
    //廉贞星
    NSInteger indexForLianzhen = indexForTiantong - 2 - 1;
    
    if (indexForLianzhen< 0) {
        
        indexForLianzhen = indexForLianzhen + 12;
    }
    
    NSString *dizhiForLianzhen = arrForMingpan[indexForLianzhen];
    [dicForZHUXING setObject:dizhiForLianzhen forKey:@"廉贞"];
    [_dicForZiwei setObject:dizhiForLianzhen forKey:@"廉贞"];
    
    
    
    
    
    NSLog(@"紫薇: %@",[dicForZHUXING objectForKey:@"紫薇"]);
    NSLog(@"天机: %@",[dicForZHUXING objectForKey:@"天机"]);
    NSLog(@"太阳: %@",[dicForZHUXING objectForKey:@"太阳"]);
    NSLog(@"武曲: %@",[dicForZHUXING objectForKey:@"武曲"]);
    NSLog(@"天同: %@",[dicForZHUXING objectForKey:@"天同"]);
    NSLog(@"廉贞: %@",[dicForZHUXING objectForKey:@"廉贞"]);
    
    
    NSLog(@"天府: %@",[dicForZHUXING objectForKey:@"天府"]);
    
    // NSLog(@"紫薇index： %ld",indexForZiwei);
    
    
    return dicForZHUXING;
}

/**
 *  龙池凤阁,天哭天虚,孤辰寡宿,天月天巫,白虎丧门
 *
 *  @param dizhiSTR 属性
 *  @param month    阳历月份
 *
 *  @return key ->星  value ->属性
 */
- (NSMutableDictionary *)returnForOtherStarWithDizhi:(NSString *)dizhiSTR
                                            andMonth:(NSInteger )month
                                            andHours:(NSInteger )hours
                                          andTiangan:(NSString *)tianganFor
                                              andDay:(NSInteger )day
                                   andShenTagFromYIN:(NSInteger )shenIndex
                                    andMingTagFromSi:(NSInteger )mingIndex
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    /**
     *  顺数12地支
     */
    NSArray *arrForDicShun = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",];
    
    /**
     *  逆数12地支
     */
    NSArray *arrForDicNi = @[@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子"];
    
    
    
    
    
    /**
     阴煞诀：从正月至十二月顺序为：寅子戌申午辰寅子戌申午辰
     
     *    天月：从正月至十二月顺序为：戌巳辰寅未卯亥未寅午戌寅。（无规律）
     *
     *    天巫：从正月至十二月顺序为：巳申寅亥巳申寅亥巳申寅亥。(每隔四个月重复相同)
     *
     *    解神星（月解）：从正月至十二月顺序为：申申戌戌子子寅寅辰辰午午。（两个月一变）
     */
    
    NSArray *arrForTianyue = @[@"戌",@"巳",@"辰",@"寅",@"未",@"卯",@"亥",@"未",@"寅",@"午",@"戌",@"寅"];
    
    NSArray *arrForTianwu = @[@"巳",@"申",@"寅",@"亥",@"巳",@"申",@"寅",@"亥",@"巳",@"申",@"寅",@"亥"];
    
    NSArray *arrForJieshen = @[@"申",@"申",@"戌",@"戌",@"子",@"子",@"寅",@"寅",@"辰",@"辰",@"午",@"午"];
    NSArray *arrForYinsha = @[@"寅",@"子",@"戌",@"申",@"午",@"辰",@"寅",@"子",@"戌",@"申",@"午",@"辰"];
    
    NSString *tianyue = arrForTianyue[month - 1];
    NSString *tianwu = arrForTianwu[month - 1];
    NSString *jieshen = arrForJieshen[month - 1];
    NSString *yinsha = arrForYinsha[month - 1];
    
    [dic setObject:tianyue forKey:@"天月"];
    [dic setObject:tianwu forKey:@"天巫"];
    [dic setObject:jieshen forKey:@"解神"];
    [dic setObject:yinsha forKey:@"阴煞"];
    
    
    /**
     *  亥子丑生年之孤辰位于寅、寅卯辰生年之孤辰位于巳、巳午未生年之孤辰位于申、申酉戌生年之孤辰位
     *  于亥
     *  孤辰，寡宿
     */
    
    NSArray *haizichou = @[@"亥",@"子",@"丑"]; //寅
    NSArray *yinmaochen = @[@"寅",@"卯",@"辰"]; //巳
    NSArray *siwuwei = @[@"巳",@"午",@"未"];   //申
    NSArray *shenyouxu = @[@"申",@"酉",@"戌"]; //亥
    
    
    for (int i = 0; i < 3; i++) {
        
        NSString *yinhu = haizichou[i];
        NSString *si = yinmaochen[i];
        NSString *shen = siwuwei[i];
        NSString *hai = shenyouxu[i];
        
        if ([hai isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"亥" forKey:@"孤辰"];
            [dic setObject:@"未" forKey:@"寡宿"];
            
        }
        
        if ([shen isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"申" forKey:@"孤辰"];
            [dic setObject:@"辰" forKey:@"寡宿"];
            
            
        }
        
        if ([si isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"巳" forKey:@"孤辰"];
            [dic setObject:@"丑" forKey:@"寡宿"];
            
            
        }
        
        
        if ([yinhu isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"寅" forKey:@"孤辰"];
            [dic setObject:@"戌" forKey:@"寡宿"];
            
            
        }
    }
    
    
    
    
    /**
     *  龙池，天虚，凤阁，天哭
     */
    
    /**
     *  大耗星：从午宫起子年，顺数到生年地支止，所在宫即是。
     *
     *  天德星：从酉宫起子年，顺数到生年地支止，所在宫即是。
     *
     *  龙德星：从未宫起子年，顺数到生年地支止，所在宫即是。
     *
     *  月德星：从巳宫起子年，顺数到生年地支止，所在宫即是。
     *
     *  天空星：从丑宫起子年，顺数到生年地支止，所在宫即是。
     */
    
    /**
     *  辰开始
     */
    NSArray *chenArr1 = @[@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯"];
    /**
     *  戌开始
     */
    NSArray *fengArr = @[@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉"];
    /**
     *  午开始
     */
    NSArray *tiankuArr = @[@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳"];
    /**
     *  申开始
     */
    //NSArray *baihuArr = @[@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未"];
    /**
     *  酉开始
     */
    //NSArray *youArr = @[@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申"];
    /**
     *  未开始
     */
   // NSArray *weiArr = @[@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午"];
    /**
     *  巳开始
     */
    NSArray *siArr = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];
    /**
     *  丑开始
     */
    NSArray *chouArr = @[@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子"];
    
    for (int i = 0; i < 12; i++) {
        
        NSString *dizhiShun = arrForDicShun[i];
        NSString *dizhiNi = arrForDicNi[i];
        
        
        if ([dizhiShun isEqualToString:dizhiSTR]) {
            
            //天空
            NSString *dizhiForTiankong = chouArr[i];
            [dic setObject:dizhiForTiankong forKey:@"天空"];
            
            //月德
            NSString *dizhiForYuede = siArr[i];
            [dic setObject:dizhiForYuede forKey:@"月德"];
            
            //龙德
//            NSString *dizhiForLongde = weiArr[i];
//            [dic setObject:dizhiForLongde forKey:@"龙德"];
            
            //天德
//            NSString *dizhiForTiande = youArr[i];
//            [dic setObject:dizhiForTiande forKey:@"天德"];
            
            //大耗
            NSString *dizhiForDahao = tiankuArr[i];
            [dic setObject:dizhiForDahao forKey:@"大耗"];
            
            //龙池
            NSString *dizhiForLongchi = chenArr1[i];
            [dic setObject:dizhiForLongchi forKey:@"龙池"];
            
            //天虚
            NSString *dizhiForTianxu = tiankuArr[i];
            [dic setObject:dizhiForTianxu forKey:@"天虚"];
            
            //白虎
//            NSString *dizhiForBaihu = baihuArr[i];
//            [dic setObject:dizhiForBaihu forKey:@"白虎"];
//            
//            NSInteger sanngmenIndex = i + 7 - 1;
//            
//            if (sanngmenIndex > 11) {
//                
//                sanngmenIndex = sanngmenIndex - 12;
//                
//            }
//            //丧门
//            NSString *dizhiForSangmen = baihuArr[sanngmenIndex];
//            [dic setObject:dizhiForSangmen forKey:@"丧门"];
            
            
        }
        
        if ([dizhiNi isEqualToString:dizhiSTR]) {
            
            int a;
            if (i >=11) {
                
                a = 0;
            }else{
            
                a = i + 1;
            }
            //凤阁
            NSString *dizhiForFengge = fengArr[a];
            [dic setObject:dizhiForFengge forKey:@"凤阁"];
            
            //天哭
            NSString *dizhiForTianku = tiankuArr[a];
            [dic setObject:dizhiForTianku forKey:@"天哭"];
            
            
        }
        
        
    }
    
    
    /**
     *  台辅，封诰
     */
    NSString *taifu = tiankuArr[hours - 1];
    [dic setObject:taifu forKey:@"台辅"];
    
    
    /**
     *  寅开始
     */
    NSArray *yinhuArr = @[@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑"];
    
    NSString *fenggao = yinhuArr[hours - 1];
    [dic setObject:fenggao forKey:@"封诰"];
    
    
    /**
     *  华盖星：申子辰年生人在辰，亥卯未年在未，寅午戌年在戌，巳酉丑年在丑。(四墓宫)
     */
    NSArray *huagai1 = @[@"申",@"子",@"辰"];
    NSArray *huagai2 = @[@"亥",@"卯",@"未"];
    NSArray *huagai3 = @[@"寅",@"午",@"戌"];
    NSArray *huagai4 = @[@"巳",@"酉",@"丑"];
    
    for (int i = 0; i < 3; i++) {
        
        /**
         *  截煞星
         */
        NSString *jiesha1 = huagai1[i];
        if ([jiesha1 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"巳" forKey:@"截煞"];
        }
        
        NSString *jiesha2 = huagai2[i];
        if ([jiesha2 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"申" forKey:@"截煞"];
        }
        
        NSString *jiesha3 = huagai3[i];
        if ([jiesha3 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"亥" forKey:@"截煞"];
        }
        
        NSString *jiesha4 = huagai4[i];
        if ([jiesha4 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"寅" forKey:@"截煞"];
        }
        
        /**
         *  华盖星
         */
        NSString *huagaiSTR1 = huagai1[i];
        if ([huagaiSTR1 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"辰" forKey:@"华盖"];
        }
        
        NSString *huagaiSTR2 = huagai2[i];
        if ([huagaiSTR2 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"未" forKey:@"华盖"];
        }
        
        NSString *huagaiSTR3 = huagai3[i];
        if ([huagaiSTR3 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"戌" forKey:@"华盖"];
        }
        
        NSString *huagaiSTR4 = huagai4[i];
        if ([huagaiSTR4 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"丑" forKey:@"华盖"];
        }
        
    }
    
    /**
     *  破碎星：子午卯酉年生人在巳，辰戌丑未年生人在丑，寅申巳亥年生人在酉。
     */
    NSArray *posui1 = @[@"子",@"午",@"卯",@"酉"];
    NSArray *posui2 = @[@"辰",@"戌",@"丑",@"未"];
    NSArray *posui3 = @[@"寅",@"申",@"巳",@"亥"];
    
    for (int i = 0; i < 4; i++) {
        
        NSString *posuiSTR1 = posui1[i];
        if ([posuiSTR1 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"巳" forKey:@"破碎"];
        }
        
        NSString *posuiSTR2 = posui2[i];
        if ([posuiSTR2 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"丑" forKey:@"破碎"];
        }
        
        NSString *posuiSTR3 = posui3[i];
        if ([posuiSTR3 isEqualToString:dizhiSTR]) {
            
            [dic setObject:@"酉" forKey:@"破碎"];
        }
        
        
    }
    
    
    /**
     *   蜚廉星：子年在申，丑年在酉，寅年在戌，卯年在巳，辰年在午，巳年在未，午年在寅，未年在卯，申年在辰，酉年在亥，戌年在子，亥年在丑。
     */
    NSDictionary *feilianDic = @{@"子":@"申",@"丑":@"酉",@"寅":@"戌",@"卯":@"巳",@"辰":@"午",@"巳":@"未",@"午":@"寅",@"未":@"卯",@"申":@"辰",@"酉":@"亥",@"戌":@"子",@"亥":@"丑"};
    
    NSString *feilianSTR = [feilianDic objectForKey:dizhiSTR];
    [dic setObject:feilianSTR forKey:@"蜚廉"];
    
    /**
     *  天官星：甲年在未，乙年在辰，丙年在巳，丁年在寅，戊年在卯，己年在酉，庚年在亥，辛年在酉，壬年在戌，癸年在午。
     */
    NSDictionary *tianguanDic = @{@"甲":@"未",@"乙":@"辰",@"丙":@"巳",@"丁":@"寅",@"戊":@"卯",@"己":@"酉",@"庚":@"亥",@"辛":@"酉",@"壬":@"戌",@"癸":@"午"};
    NSString *tianguanSTR = [tianguanDic objectForKey:tianganFor];
    [dic setObject:tianguanSTR forKey:@"天官"];
    
    /**
     *  天福星：甲年在酉，乙年在申，丙年在子，丁年在亥，戊年在卯，己年在寅，庚年在午，辛年在巳，壬年在午，癸年在巳。
     */
    NSDictionary *tianfuDic = @{@"甲":@"酉",@"乙":@"申",@"丙":@"子",@"丁":@"亥",@"戊":@"卯",@"己":@"寅",@"庚":@"午",@"辛":@"巳",@"壬":@"午",@"癸":@"巳"};
    NSString *tianfuSTR = [tianfuDic objectForKey:tianganFor];
    [dic setObject:tianfuSTR forKey:@"天福"];
    
    /**
     *  甲己年申酉，乙庚年午未，丙辛年辰巳，丁壬年寅卯，戊癸年子丑。意思是：甲年或己年的截空星是申和酉，余类推
     */
    NSDictionary *jiekongDic = @{@"甲":@"申",@"乙":@"午",@"丙":@"辰",@"丁":@"寅",@"戊":@"子",@"己":@"酉",@"庚":@"未",@"辛":@"巳",@"壬":@"卯",@"癸":@"丑"};
    NSString *jiekongSTR = [jiekongDic objectForKey:tianganFor];
    [dic setObject:jiekongSTR forKey:@"截空"];
    
    
    /**
     *  三台星等需要根据6吉星判断
     
     三台星：由左辅星所在宫位上起初一日，沿十二宫顺时针方向数，数至出生日止，即在此宫安三台星。
     
     八座星：由右弼星所在宫位上起初一日，沿十二宫逆时针方向数，数至出生日止，即在此宫安八座星。
     
     天贵星：由文曲星所在宫位上起初一日，顺时针方向数，数至出生日宫再退回一宫，即在此宫安天贵星。
     
     恩光星：由文昌星所在宫位上起初一日,顺时针方向数，数至出生日宫再退回一宫，即在此宫安恩光星。
     */
    dicForSAN = [self anLiujixingChushengniangan:tianganFor andMonth:month andHour:hours];
    
    NSString *strForZuofu = [dicForSAN objectForKey:@"左辅"];
    NSString *strForYoubi = [dicForSAN objectForKey:@"右弼"];
    NSString *strForWenqu = [dicForSAN objectForKey:@"文曲"];
    NSString *strForWenchang = [dicForSAN objectForKey:@"文昌"];
    
    NSInteger indexForSAN;
    NSInteger indexForTIAN;
    NSInteger indexForEn;
    NSInteger indexForBa;
    
    for (int i = 0; i < 12; i++) {
        
        //取六吉星所在的宫
        NSString *strForZ = arrForMingpan[i];
        NSString *strForWQ = arrForMingpan[i];
        NSString *strForWC = arrForMingpan[i];
        NSString *strForYB = arrForMingpan[i];
        
        //八座
        if ([strForYoubi isEqualToString:strForYB]) {
            
            indexForBa = i - day + 1;
            
            if (indexForBa < 0) {
                
                indexForBa = indexForBa + 12;
                
                if (indexForBa < 0) {
                    
                    indexForBa = indexForBa + 12 ;
                    
                    if (indexForBa < 0) {
                        
                        indexForBa = indexForBa + 12 + 1;
                    }
                    
                }
                
            }
            
            if (indexForBa == 12) {
                
                indexForBa = 0;
            }
            
            NSString *dizhiForBazuo = [arrForMingpan objectAtIndex:indexForBa];
            [dic setObject:dizhiForBazuo forKey:@"八座"];
            
        }
        
        //恩光
        if ([strForWenchang isEqualToString:strForWC]) {
            
            indexForEn = i + day - 1 - 1;
            
            if (indexForEn < 0) {
                
                indexForEn = indexForEn + 12;
            }
            
            if (indexForEn > 11) {
                
                indexForEn = indexForEn - 12;
                
                if (indexForEn >=12 ) {
                    
                    indexForEn = indexForEn - 12;
                    
                    if (indexForEn >= 12) {
                        
                        indexForEn = indexForEn - 12;

                    }
                    
                }
                
            }
            
            NSString *dizhiForEnguang = [arrForMingpan objectAtIndex:indexForEn];
            [dic setObject:dizhiForEnguang forKey:@"恩光"];
            
        }
        
        
        //天贵
        if ([strForWenqu isEqualToString:strForWQ]) {
            
            indexForTIAN = i + day - 1 - 1;
            
            if (indexForTIAN < 0) {
                
                indexForTIAN = indexForTIAN + 12;
            }
            
            if (indexForTIAN > 11) {
                
                indexForTIAN = indexForTIAN - 12;
                
                if (indexForTIAN >= 12) {
                    
                    indexForTIAN = indexForTIAN - 12;
                    
                    if (indexForTIAN >= 12) {
                        
                        indexForTIAN = indexForTIAN - 12;
                    }
                    
                }
                
            }
            
            NSString *dizhiForYoubi = [arrForMingpan objectAtIndex:indexForTIAN];
            [dic setObject:dizhiForYoubi forKey:@"天贵"];
            
        }
        
        
        //三台
        if ([strForZuofu isEqualToString:strForZ]) {
            
            indexForSAN = i + day - 1;
            
            if (indexForSAN > 11) {
                
                indexForSAN = indexForSAN - 12 ;
                
                if (indexForSAN >=12) {
                    
                    indexForSAN = indexForSAN - 12;
                    
                    if (indexForSAN >=12) {
                        
                        indexForSAN = indexForSAN - 12;
                    }
                    
                }
                
            }
            
            NSString *dizhiForSantai = [arrForMingpan objectAtIndex:indexForSAN];
            [dic setObject:dizhiForSantai forKey:@"三台"];
            
        }
        
        
    }
    
    /**
     *  天才星：由命宫起子年，沿十二宫顺时针方向数，数至出生年支所在宫止，即在此宫安天才星。
     
     天寿星：由身宫起子年，沿十二宫顺时针方向数，数至出生年支所在宫止，即在此宫安天寿星。
     */
    
    //天才
    for (int i = 0; i < 12; i++) {
        
        NSInteger indexForTIANCAI = i + mingIndex;
        
        if ([dizhiSTR isEqualToString:arrForDicShun[i]]) {
            
            if (indexForTIANCAI > 11) {
                
                indexForTIANCAI = indexForTIANCAI - 12;
                
            }
            
            //NSLog(@"天才index : %ld",indexForTIANCAI);
            
            NSString *dizhiForTIANCAI = arrForMingpan[indexForTIANCAI];
            
            [dic setObject:dizhiForTIANCAI forKey:@"天才"];
            
        }
        
        
    }
    //天寿
    for (int i = 0; i < 12; i++) {
        
        if ([dizhiSTR isEqualToString:arrForDicShun[i]]) {
            
            NSInteger indexForTIANSHOU = i + shenIndex;
            
            if (indexForTIANSHOU > 11) {
                
                indexForTIANSHOU = indexForTIANSHOU - 12;
                
            }
            
            NSString *dizhiForTIANSHOU = arrForMingpan[indexForTIANSHOU];
            
            [dic setObject:dizhiForTIANSHOU forKey:@"天寿"];
            
            
        }
        
        
    }
    
    /**
     *  天伤、天使星：天伤星固定在奴仆宫，天使星固定在疾厄宫。
     */
    
    //天使
    NSInteger indexForTIANSHI = mingIndex - 5;
    
    if (indexForTIANSHI < 0) {
        
        indexForTIANSHI = indexForTIANSHI + 12;
    }
    
    NSString *dizhiForTIANSHI = arrForMingpan[indexForTIANSHI];
    
    [dic setObject:dizhiForTIANSHI forKey:@"天使"];
    
    
    //天伤
    NSInteger indexForTIANSHANG = mingIndex - 7;
    
    if (indexForTIANSHANG < 0) {
        
        indexForTIANSHANG = indexForTIANSHANG + 12;
    }
    
    NSString *dizhiForTIANSHANG = arrForMingpan[indexForTIANSHANG];
    
    [dic setObject:dizhiForTIANSHANG forKey:@"天伤"];
    
    
    /*
    NSLog(@"白虎: %@",[dic objectForKey:@"白虎"]);
    NSLog(@"丧门: %@",[dic objectForKey:@"丧门"]);
    NSLog(@"龙池: %@",[dic objectForKey:@"龙池"]);
    NSLog(@"凤阁: %@",[dic objectForKey:@"凤阁"]);
    NSLog(@"天哭: %@",[dic objectForKey:@"天哭"]);
    NSLog(@"孤辰: %@",[dic objectForKey:@"孤辰"]);
    NSLog(@"寡宿: %@",[dic objectForKey:@"寡宿"]);
    NSLog(@"阴煞: %@",[dic objectForKey:@"阴煞"]);
    NSLog(@"天月: %@",[dic objectForKey:@"天月"]);
    NSLog(@"天巫: %@",[dic objectForKey:@"天巫"]);
    NSLog(@"解神: %@",[dic objectForKey:@"解神"]);
    NSLog(@"台辅: %@",[dic objectForKey:@"台辅"]);
    NSLog(@"封诰: %@",[dic objectForKey:@"封诰"]);
    NSLog(@"华盖: %@",[dic objectForKey:@"华盖"]);
    NSLog(@"破碎: %@",[dic objectForKey:@"破碎"]);
    NSLog(@"大耗: %@",[dic objectForKey:@"大耗"]);
    NSLog(@"天德: %@",[dic objectForKey:@"天德"]);
    NSLog(@"龙德: %@",[dic objectForKey:@"龙德"]);
    NSLog(@"月德: %@",[dic objectForKey:@"月德"]);
    NSLog(@"天空: %@",[dic objectForKey:@"天空"]);
    NSLog(@"蜚廉: %@",[dic objectForKey:@"蜚廉"]);
    NSLog(@"天官: %@",[dic objectForKey:@"天官"]);
    NSLog(@"天福: %@",[dic objectForKey:@"天福"]);
    NSLog(@"截空: %@",[dic objectForKey:@"截空"]);
    NSLog(@"三台: %@",[dic objectForKey:@"三台"]);
    NSLog(@"八座: %@",[dic objectForKey:@"八座"]);
    NSLog(@"天贵: %@",[dic objectForKey:@"天贵"]);
    NSLog(@"恩光: %@",[dic objectForKey:@"恩光"]);
    NSLog(@"天才: %@",[dic objectForKey:@"天才"]);
    NSLog(@"天寿: %@",[dic objectForKey:@"天寿"]);
    NSLog(@"天使: %@",[dic objectForKey:@"天使"]);
    NSLog(@"天伤: %@",[dic objectForKey:@"天伤"]);
    */
    
    _dicForZaxingOUT = dic;
    
    return dic;
    
}

/**
 *  安六吉星
 *
 *  @param chushengtg 出生年天干
 *  @param month      出生月份
 *  @param hour       出生时辰
 */
-(NSDictionary *)anLiujixingChushengniangan:(NSString *)chushengtg andMonth:(NSInteger) month andHour:(NSInteger) hour{
    NSDictionary * dict = [NSDictionary dictionary];
    NSInteger zMonth = month - 1;
    NSInteger zHour = hour -1;
    
    NSArray  * chenArray = @[@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯"];
    NSArray * xuArray =@[@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子",@"亥"];
    NSDictionary * kuiDict = @{@"甲":@"丑",
                               @"戊":@"丑",
                               @"庚":@"丑",
                               @"丙":@"亥",
                               @"丁":@"亥",
                               @"乙":@"子",
                               @"己":@"子",
                               @"壬":@"卯",
                               @"癸":@"卯",
                               @"辛":@"午"};
    
    NSDictionary * yueDict = @{@"甲":@"未",
                               @"戊":@"未",
                               @"庚":@"未",
                               @"丙":@"酉",
                               @"丁":@"酉",
                               @"乙":@"申",
                               @"己":@"申",
                               @"壬":@"巳",
                               @"癸":@"巳",
                               @"辛":@"寅"};
    
    dict = @{@"左辅":chenArray[zMonth],
             @"文曲":chenArray[zHour],
             @"右弼":xuArray[zMonth],
             @"文昌":xuArray[zHour],
             @"天魁":kuiDict[chushengtg],
             @"天钺":yueDict[chushengtg]};
    
    
    //
    //    NSLog(@"所有的键%@",[dict allKeys]);
    //    NSLog(@"%@",[dict allValues]);
    //
    
    return dict;
}


/**
 *  安禄存星以及六煞星
 *
 *  @param tgstr 出生年月天干
 *  @param dzStr 出生年月地支
 *  @param cssc  出生时辰
 *
 *  @return 返回禄存星以及六煞星对应地支的字典
 */
//禄存星决定后，依“前羊后陀”，便可将此二星排入其所该入的宫位。在禄存星的前一格（即顺时针方向）即为擎羊星的所在；禄存星的后一格（即逆时针方向）则为陀罗星的所在位置。
-(NSDictionary *)anLuCunxingAndLiuShaXingCSNYtianganwd:(NSString *) tgstr AndCSNYdizhi:(NSString *)dzStr AndChuShengShiChen:(NSInteger ) cssc{
    NSMutableDictionary * dict = [NSMutableDictionary  dictionary];
    
    NSDictionary  * tgDict = @{@"甲":@"寅",
                               @"乙":@"卯",
                               @"丙":@"巳",
                               @"丁":@"午",
                               @"戊":@"巳",
                               @"己":@"午",
                               @"庚":@"申",
                               @"辛":@"酉",
                               @"壬":@"亥",
                               @"癸":@"子"};
    
    NSDictionary * huoDict = @{@"寅":@"丑",
                               @"午":@"丑",
                               @"戌":@"丑",
                               
                               @"巳":@"卯",
                               @"酉":@"卯",
                               @"丑":@"卯",
                               
                               @"申":@"寅",
                               @"子":@"寅",
                               @"辰":@"寅",
                               
                               @"亥":@"酉",
                               @"卯":@"酉",
                               @"未":@"酉"};
    
    
    NSDictionary * lingDict = @{
                                @"寅":@"卯",
                                @"午":@"卯",
                                @"戌":@"卯",
                                
                                @"巳":@"戌",
                                @"酉":@"戌",
                                @"丑":@"戌",
                                
                                @"申":@"戌",
                                @"子":@"戌",
                                @"辰":@"戌",
                                
                                @"亥":@"戌",
                                @"卯":@"戌",
                                @"未":@"戌"};
    NSString * huoQiShi = huoDict[dzStr];
    NSString * lingQishi = lingDict[dzStr];
    
    NSString *  huodzstr;
    NSString  * lingdzStr;
    
    NSArray  * chouArray = @[@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子"];
    NSArray  * maoArray = @[@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅"];
    NSArray  * yinArray = @[@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑"];
    NSArray  * youArray = @[@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申"];
    NSArray  * xuArray = @[@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉"];
    
    if ([huoQiShi isEqualToString:chouArray[0]]) {
        
        huodzstr = chouArray[cssc - 1];
        
    }else if ([huoQiShi isEqualToString:maoArray[0]]){
        huodzstr = maoArray[cssc - 1];
        
    }else if ([huoQiShi isEqualToString:yinArray[0]]){
        
        huodzstr = yinArray[cssc - 1];
    }else if ([huoQiShi isEqualToString:youArray[0]]){
        huodzstr = youArray[cssc -1];
    }
    
    if ([lingQishi isEqualToString:maoArray[0]]) {
        lingdzStr = maoArray[cssc -1];
    }else if ([lingQishi isEqualToString:xuArray[0]]){
        lingdzStr = xuArray[cssc -1];
    }
    //    NSLog(@"%@",huodzstr);
    //    NSLog(@"%@",lingdzStr);
    
    NSArray  * dijieArray = @[@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌"];
    NSArray  * dikongArray = @[@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子"];
    
    [dict setObject:tgDict[tgstr] forKey:@"禄存"];
    [dict setObject:huodzstr forKey:@"火星"];
    [dict setObject:lingdzStr forKey:@"铃星"];
    [dict setObject:dikongArray[cssc -1] forKey:@"地空"];
    [dict setObject:dijieArray[cssc -1] forKey:@"地劫"];
    
    
    
    NSLog(@"11111111111111 :%@",[dict objectForKey:@"禄存"]);
    
    //在禄存星的前一格（即顺时针方向）即为擎羊星的所在；禄存星的后一格（即逆时针方向）则为陀罗星的所在位置
    for (int i = 0 ; i < 12; i++) {
        
        NSString *lucunSTR = arrForMingpan[i];
        
        if ([lucunSTR isEqualToString:[dict objectForKey:@"禄存"]]) {
            
            NSInteger indexForQY = i + 1;
            
            if (indexForQY >= 12) {
                
                indexForQY = indexForQY - 12;
            }
            
            NSString *dizhiForQINGYAN = arrForMingpan[indexForQY];
            [dict setObject:dizhiForQINGYAN forKey:@"擎羊"];
            
            NSInteger indexForTL = i - 1;
            
            if (indexForTL < 0) {
                
                indexForTL = indexForTL + 12;
                
            }
            
            NSString *dizhiForTUOLUO = arrForMingpan[indexForTL];
            [dict setObject:dizhiForTUOLUO forKey:@"陀罗"];
            
        }
        
    }
    
    return  dict;
};








//---------------------------------------------------刘江伟--------------------------------------------------------------//


//起大限 如木三局则03-12为第一个十年 ，大限的起法从命宫开始,  阳男 阴女 为顺时针,  阴男 阳女为逆时针
-(NSMutableArray *)qidaxian:(NSString *)wuxingjuStr{
    
    NSDictionary * daxianqishishuzuDict =   @{@"水二局":@(02),@"火六局":@(06),@"土五局":@(05),@"木三局":@(03),@"金四局":@(04)};
    
    NSMutableArray * shuziarray = [NSMutableArray array];
    int qishisuishu = [daxianqishishuzuDict[wuxingjuStr] intValue];
    
    NSString  * aaaaa = [NSString stringWithFormat:@"%d",qishisuishu];
    
    for (int i = 0; i < 12; i ++ ) {
        NSString  * str;
        int diyigejiesu;
        
        if (i == 0) {
            diyigejiesu = qishisuishu + 9;
            str  = [aaaaa stringByAppendingString:[NSString stringWithFormat:@"-%d",diyigejiesu]];
        }else{
            
            NSString * d = [NSString stringWithFormat:@"%d",diyigejiesu +1];
            str = [d stringByAppendingString:[NSString stringWithFormat:@"-%d",[d intValue] + 9]];
            diyigejiesu = [d intValue] + 9;
            
//            if(diyigejiesu > 110){
//                str = [NSString stringWithFormat:@"%d",[d intValue]];
//            }
            
        }
        
        //   NSLog(@"%@",str);
        [shuziarray addObject:str];
        
    }
    
    return shuziarray;
}


//安紫薇星  传 所属五行局 与出生年月日的日，就是几号
/*
 定紫微星後,即可逆時針排出紫微星系。(記住是 逆時針)
 定天府星後,即可順時針排出天府星系。(記住是 順時針)
 */
-(NSDictionary * )anZiweixingWuxingjushu:(NSString  *)wuxingjushu chushengriqi:(NSInteger )day{
    
    NSDictionary * ziweixingDictt = @{
                                      @(1):@[@"丑",@"辰",@"亥",@"午",@"酉"],
                                      @(2):@[@"寅",@"丑",@"辰",@"亥",@"午"],
                                      @(3):@[@"寅",@"寅",@"丑",@"辰",@"亥"],
                                      @(4):@[@"卯",@"巳",@"寅",@"丑",@"辰"],
                                      @(5):@[@"卯",@"寅",@"子",@"寅",@"丑"],
                                      @(6):@[@"辰",@"卯",@"巳",@"未",@"寅"],
                                      @(7):@[@"辰",@"午",@"寅",@"子",@"戌"],
                                      @(8):@[@"巳",@"卯",@"卯",@"巳",@"未"],
                                      @(9):@[@"巳",@"辰",@"丑",@"寅",@"子"],
                                      @(10):@[@"午",@"未",@"午",@"卯",@"巳"],
                                      @(11):@[@"午",@"辰",@"卯",@"申",@"寅"],
                                      @(12):@[@"未",@"巳",@"辰",@"丑",@"卯"],
                                      @(13):@[@"未",@"申",@"寅",@"午",@"亥"],
                                      @(14):@[@"申",@"巳",@"未",@"卯",@"申"],
                                      @(15):@[@"申",@"午",@"辰",@"辰",@"丑"],
                                      @(16):@[@"酉",@"酉",@"巳",@"酉",@"午"],
                                      @(17):@[@"酉",@"午",@"卯",@"寅",@"卯"],
                                      @(18):@[@"戌",@"未",@"申",@"未",@"辰"],
                                      @(19):@[@"戌",@"戌",@"巳",@"辰",@"子"],
                                      @(20):@[@"亥",@"未",@"午",@"巳",@"酉"],
                                      @(21):@[@"亥",@"申",@"辰",@"戌",@"寅"],
                                      @(22):@[@"子",@"亥",@"酉",@"卯",@"未"],
                                      @(23):@[@"子",@"申",@"午",@"申",@"辰"],
                                      @(24):@[@"丑",@"酉",@"未",@"巳",@"巳"],
                                      @(25):@[@"丑",@"子",@"巳",@"午",@"丑"],
                                      @(26):@[@"寅",@"酉",@"戌",@"亥",@"戌"],
                                      @(27):@[@"寅",@"戌",@"未",@"辰",@"卯"],
                                      @(28):@[@"卯",@"丑",@"申",@"酉",@"申"],
                                      @(29):@[@"卯",@"戌",@"午",@"午",@"巳"],
                                      @(30):@[@"辰",@"亥",@"亥",@"未",@"午"]
                                      };
    
    NSDictionary * wuxingjuduiyingde = @{@"水二局":@(0),@"木三局":@(1),@"金四局":@(2),@"土五局":@(3),@"火六局":@(4)};
    
    //根据生日取出对应字典
    NSArray * gArray = ziweixingDictt[@(day)];
    //根据五行局取出数组中对应地支所在，紫薇就在那个宫
    int index = [wuxingjuduiyingde[wuxingjushu] intValue];
    
    NSString * gStr = gArray[index];
    
    
    NSLog(@"紫微星在%@宫",gStr);
    
    //    NSArray * ziweixingxiArray = @[@"天機星",@"太陽星",@"武曲星",@"天同星",@"廉貞星"];
    //    NSArray * tianfuxingxiArray = @[@"天府星",@"太陰星",@"貪狼星",@"巨門星",@"天相星",@"天梁星",@"七殺星",@"破軍星"];
    if ([gStr isEqualToString:@"子"]) {
        
        NSDictionary * Zizw = @{@"子":@"紫薇",
                                @"亥":@"天机",
                                @"酉":@"太阳",
                                @"申":@"武曲",
                                @"未":@"天同",
                                @"辰":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"辰":@"天府",
                                  @"巳":@"太陰",
                                  @"午":@"貪狼",
                                  @"未":@"巨門",
                                  @"申":@"天相",
                                  @"酉":@"天梁",
                                  @"戌":@"七殺",
                                  @"寅":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if([gStr isEqualToString:@"丑"]){
        
        NSDictionary * Zizw = @{@"丑":@"紫薇",
                                @"子":@"天机",
                                @"戌":@"太阳",
                                @"酉":@"武曲",
                                @"申":@"天同",
                                @"巳":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"卯":@"天府",
                                  @"辰":@"太陰",
                                  @"巳":@"貪狼",
                                  @"午":@"巨門",
                                  @"未":@"天相",
                                  @"申":@"天梁",
                                  @"酉":@"七殺",
                                  @"丑":@"破軍"};
      
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"寅"]){
        
        NSDictionary * Zizw = @{@"寅":@"紫薇",
                                @"丑":@"天机",
                                @"亥":@"太阳",
                                @"戌":@"武曲",
                                @"酉":@"天同",
                                @"午":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"寅":@"天府",
                                  @"卯":@"太陰",
                                  @"辰":@"貪狼",
                                  @"巳":@"巨門",
                                  @"午":@"天相",
                                  @"未":@"天梁",
                                  @"申":@"七殺",
                                  @"子":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"卯"]){
        
        NSDictionary * Zizw = @{@"卯":@"紫薇",
                                @"寅":@"天机",
                                @"子":@"太阳",
                                @"亥":@"武曲",
                                @"戌":@"天同",
                                @"未":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"丑":@"天府",
                                  @"寅":@"太陰",
                                  @"卯":@"貪狼",
                                  @"辰":@"巨門",
                                  @"巳":@"天相",
                                  @"午":@"天梁",
                                  @"未":@"七殺",
                                  @"亥":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"辰"]){
        
        NSDictionary * Zizw = @{@"辰":@"紫薇",
                                @"卯":@"天机",
                                @"丑":@"太阳",
                                @"子":@"武曲",
                                @"亥":@"天同",
                                @"申":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"子":@"天府",
                                  @"丑":@"太陰",
                                  @"寅":@"貪狼",
                                  @"卯":@"巨門",
                                  @"辰":@"天相",
                                  @"巳":@"天梁",
                                  @"午":@"七殺",
                                  @"戌":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"巳"]){
        
        NSDictionary * Zizw = @{@"巳":@"紫薇",
                                @"辰":@"天机",
                                @"寅":@"太阳",
                                @"丑":@"武曲",
                                @"子":@"天同",
                                @"酉":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"亥":@"天府",
                                  @"子":@"太陰",
                                  @"丑":@"貪狼",
                                  @"寅":@"巨門",
                                  @"卯":@"天相",
                                  @"辰":@"天梁",
                                  @"巳":@"七殺",
                                  @"酉":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"午"]){
        
        NSDictionary * Zizw = @{@"子":@"紫薇",
                                @"亥":@"天机",
                                @"酉":@"太阳",
                                @"申":@"武曲",
                                @"未":@"天同",
                                @"辰":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"辰":@"天府",
                                  @"巳":@"太陰",
                                  @"午":@"貪狼",
                                  @"未":@"巨門",
                                  @"申":@"天相",
                                  @"酉":@"天梁",
                                  @"戌":@"七殺",
                                  @"寅":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"未"]){
        
        NSDictionary * Zizw = @{@"未":@"紫薇",
                                @"午":@"天机",
                                @"辰":@"太阳",
                                @"卯":@"武曲",
                                @"寅":@"天同",
                                @"亥":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"酉":@"天府",
                                  @"戌":@"太陰",
                                  @"亥":@"貪狼",
                                  @"子":@"巨門",
                                  @"丑":@"天相",
                                  @"寅":@"天梁",
                                  @"卯":@"七殺",
                                  @"未":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"申"]){
        
        NSDictionary * Zizw = @{@"申":@"紫薇",
                                @"未":@"天机",
                                @"巳":@"太阳",
                                @"辰":@"武曲",
                                @"卯":@"天同",
                                @"子":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"申":@"天府",
                                  @"酉":@"太陰",
                                  @"戌":@"貪狼",
                                  @"亥":@"巨門",
                                  @"子":@"天相",
                                  @"丑":@"天梁",
                                  @"寅":@"七殺",
                                  @"午":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"酉"]){
        
        NSDictionary * Zizw = @{@"酉":@"紫薇",
                                @"申":@"天机",
                                @"午":@"太阳",
                                @"巳":@"武曲",
                                @"辰":@"天同",
                                @"丑":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"未":@"天府",
                                  @"申":@"太陰",
                                  @"酉":@"貪狼",
                                  @"戌":@"巨門",
                                  @"亥":@"天相",
                                  @"子":@"天梁",
                                  @"丑":@"七殺",
                                  @"巳":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"戌"]){
        
        NSDictionary * Zizw = @{@"戌":@"紫薇",
                                @"酉":@"天机",
                                @"未":@"太阳",
                                @"午":@"武曲",
                                @"巳":@"天同",
                                @"寅":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"午":@"天府",
                                  @"未":@"太陰",
                                  @"申":@"貪狼",
                                  @"酉":@"巨門",
                                  @"戌":@"天相",
                                  @"亥":@"天梁",
                                  @"子":@"七殺",
                                  @"辰":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }else if ([gStr isEqualToString:@"亥"]){
        
        NSDictionary * Zizw = @{@"亥":@"紫薇",
                                @"戌":@"天机",
                                @"申":@"太阳",
                                @"未":@"武曲",
                                @"午":@"天同",
                                @"卯":@"廉贞"};
        
        NSDictionary  * Zitf  = @{@"巳":@"天府",
                                  @"午":@"太陰",
                                  @"未":@"貪狼",
                                  @"申":@"巨門",
                                  @"酉":@"天相",
                                  @"戌":@"天梁",
                                  @"亥":@"七殺",
                                  @"卯":@"破軍"};
        
        NSDictionary * ziweitianfu = @{@"ziweiKEY":Zizw,@"tianfuKEY":Zitf};
        
        return ziweitianfu;
        
    }
    return nil;
}


/**
 *  安四桃花星，天刑星以及天马星
 *
 *  @param niandizhi 年地支
 *  @param month     出生月份
 *
 *  @return 返回四桃花星天刑星以及天马星对应地支的字典
 */
-(NSDictionary *)anSitaohuaTianxinxingAndTianmaxingNiandizhi:(NSString *)niandizhi AndShengYue:(NSInteger)month{
    
    NSDictionary * dict = [NSDictionary dictionary];
    
    NSArray * maoArray =@[@"卯",@"寅",@"丑",@"子",@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰"];
    NSArray  * tianxingArray = @[@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申"];
    
    NSDictionary * nianDizhi = @{@"子":@(0),@"丑":@(1),@"寅":@(2),@"卯":@(3),@"辰":@(4),@"巳":@(5),@"午":@(6),@"未":@(7),@"申":@(8),@"酉":@(9),@"戌":@(10),@"亥":@(11)};
    
    
    int hlweizhi = [nianDizhi[niandizhi] intValue];
    
    NSDictionary * weizhiDicttt = @{@(0):@(6),
                                    @(1):@(7),
                                    @(2):@(8),
                                    @(3):@(9),
                                    @(4):@(10),
                                    @(5):@(11),
                                    @(6):@(0),
                                    @(7):@(1),
                                    @(8):@(2),
                                    @(9):@(3),
                                    @(10):@(4),
                                    @(11):@(5)};
    
    int txweizhi = [weizhiDicttt[@(hlweizhi)] intValue];
    
    NSInteger tianyaoweizhi;
    if (month -1 + 4 > 11) {
        tianyaoweizhi = month - 1+ 4 - 12;
    }else{
        tianyaoweizhi = month - 1 + 4;
    }
    NSDictionary * xianciDict = @{
                                  @"亥":@"子",
                                  @"卯":@"子",
                                  @"未":@"子",
                                  
                                  @"申":@"酉",
                                  @"子":@"酉",
                                  @"辰":@"酉",
                                  
                                  @"巳":@"午",
                                  @"酉":@"午",
                                  @"丑":@"午",
                                  
                                  @"寅":@"卯",
                                  @"午":@"卯",
                                  @"戌":@"卯"};
    
    NSDictionary * tianmaDict = @{
                                  @"亥":@"巳",
                                  @"卯":@"巳",
                                  @"未":@"巳",
                                  
                                  @"申":@"寅",
                                  @"子":@"寅",
                                  @"辰":@"寅",
                                  
                                  @"巳":@"亥",
                                  @"酉":@"亥",
                                  @"丑":@"亥",
                                  
                                  @"寅":@"申",
                                  @"午":@"申",
                                  @"戌":@"申"};
    
    dict = @{@"红鸾":maoArray[hlweizhi],
             @"天喜":maoArray[txweizhi],
             @"天刑":tianxingArray[month -1],
             @"天姚":tianxingArray[tianyaoweizhi],
             @"咸池":xianciDict[niandizhi],
             @"天马":tianmaDict[niandizhi]};
    
    _dicForTaohuaOUT = dict;
    
    return dict;
}


/**
 *  安禄存星以及六煞星
 *
 *  @param tgstr 出生年月天干
 *  @param dzStr 出生年月地支
 *  @param cssc  出生时辰
 *
 *  @return 返回禄存星以及六煞星对应地支的字典
 */
//禄存星决定后，依“前羊后陀”，便可将此二星排入其所该入的宫位。在禄存星的前一格（即顺时针方向）即为擎羊星的所在；禄存星的后一格（即逆时针方向）则为陀罗星的所在位置。
-(NSDictionary *)anLuCunxingAndLiuShaXingCSNYtiangan:(NSString *) tgstr AndCSNYdizhi:(NSString *)dzStr AndChuShengShiChen:(NSInteger ) cssc{
    NSDictionary * dict = [NSDictionary  dictionary];
    
    NSDictionary  * tgDict = @{@"甲":@"寅",
                               @"乙":@"卯",
                               @"丙":@"巳",
                               @"丁":@"午",
                               @"戊":@"巳",
                               @"己":@"午",
                               @"庚":@"申",
                               @"辛":@"酉",
                               @"壬":@"亥",
                               @"癸":@"子"};
    
    NSDictionary * huoDict = @{@"寅":@"丑",
                               @"午":@"丑",
                               @"戌":@"丑",
                               
                               @"巳":@"卯",
                               @"酉":@"卯",
                               @"丑":@"卯",
                               
                               @"申":@"寅",
                               @"子":@"寅",
                               @"辰":@"寅",
                               
                               @"亥":@"酉",
                               @"卯":@"酉",
                               @"未":@"酉"};
    
    
    NSDictionary * lingDict = @{
                                @"寅":@"卯",
                                @"午":@"卯",
                                @"戌":@"卯",
                                
                                @"巳":@"戌",
                                @"酉":@"戌",
                                @"丑":@"戌",
                                
                                @"申":@"戌",
                                @"子":@"戌",
                                @"辰":@"戌",
                                
                                @"亥":@"戌",
                                @"卯":@"戌",
                                @"未":@"戌"};
    NSString * huoQiShi = huoDict[dzStr];
    NSString * lingQishi = lingDict[dzStr];
    
    NSString *  huodzstr;
    NSString  * lingdzStr;
    
    NSArray  * chouArray = @[@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子"];
    NSArray  * maoArray = @[@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅"];
    NSArray  * yinArray = @[@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑"];
    NSArray  * youArray = @[@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申"];
    NSArray  * xuArray = @[@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉"];
    
    if ([huoQiShi isEqualToString:chouArray[0]]) {
        
        huodzstr = chouArray[cssc - 1];
        
    }else if ([huoQiShi isEqualToString:maoArray[0]]){
        huodzstr = maoArray[cssc - 1];
        
    }else if ([huoQiShi isEqualToString:yinArray[0]]){
        
        huodzstr = yinArray[cssc - 1];
    }else if ([huoQiShi isEqualToString:youArray[0]]){
        huodzstr = youArray[cssc -1];
    }
    
    if ([lingQishi isEqualToString:maoArray[0]]) {
        lingdzStr = maoArray[cssc -1];
        
    }else if ([lingQishi isEqualToString:xuArray[0]]){
        lingdzStr = xuArray[cssc -1];
    }
    //NSLog(@"%@",huodzstr);
    //NSLog(@"%@",lingdzStr);
    
    NSArray  * dijieArray = @[@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌"];
    
    NSArray  * dikongArray = @[@"亥",@"戌",@"酉",@"申",@"未",@"午",@"巳",@"辰",@"卯",@"寅",@"丑",@"子"];
    NSArray  * qingyangAndTuoluoArray = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
    
    NSUInteger index = [qingyangAndTuoluoArray indexOfObject:tgDict[tgstr]];
    NSUInteger  qingyangIndex;
    NSUInteger  tuoluoIndex;
    
    if (index == 0) {
        qingyangIndex =  11;
    }else{
        qingyangIndex = index -1;
    }
    if (index  == 11) {
        tuoluoIndex = 0;
    }else{
        tuoluoIndex = index +1;
    }
    dict = @{@"禄存":tgDict[tgstr],
             @"火星":huodzstr,
             @"铃星":lingdzStr,
             @"地空":dikongArray[cssc -1],
             @"地劫":dijieArray[cssc -1],
             @"擎羊":qingyangAndTuoluoArray[qingyangIndex],
             @"陀罗":qingyangAndTuoluoArray[tuoluoIndex]};
    
    //NSLog(@"dict = %@",[dict allValues]);
    
    return  dict;
};


/**
 *  安四化
 *
 *  @param dict 传一个主星对应的字典
 *  @param nianTiangan 传一个主星对应的字典
 *  @return 返回四化对应地支的字典
 */
-(NSDictionary * )anSihuaxingAndZhuxingDict:(NSDictionary * ) dict  andLjxDict:(NSDictionary * )ljwDict nianTiangan:(NSString *)Str{
    
    NSDictionary * sihuaDict = @{
                                 @"甲":@[@"廉贞",@"破軍",@"武曲",@"太阳"],
                                 @"戊":@[@"貪狼",@"太陰",@"右弼",@"天机"],
                                 @"庚":@[@"太阳",@"武曲",@"太陰",@"天同"],
                                 @"丙":@[@"天同",@"天机",@"文昌",@"廉贞"],
                                 @"丁":@[@"太陰",@"天同",@"天机",@"巨門"],
                                 @"乙":@[@"天机",@"天梁",@"紫薇",@"太陰"],
                                 @"己":@[@"武曲",@"貪狼",@"天梁",@"文曲"],
                                 @"壬":@[@"天梁",@"紫薇",@"左辅",@"武曲"],
                                 @"癸":@[@"破軍",@"巨門",@"太陰",@"貪狼"],
                                 @"辛":@[@"巨門",@"太阳",@"文曲",@"文昌"]};
    
    NSArray * arrar1 = sihuaDict[Str];
    NSDictionary * tianfudict = dict[@"tianfuKEY"];
    NSDictionary * ziweidict = dict[@"ziweiKEY"];
    
    NSMutableDictionary  * ddict = [NSMutableDictionary dictionary];
    NSArray  * dizhiArray = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
    for (int i  = 0; i < 12; i++) {
        for (int j = 0; j < 4; j++) {
            if ([arrar1[j] isEqualToString:tianfudict[dizhiArray[i]]]) {
                //NSLog(@"%@ = %@",tianfudict[dizhiArray[i]],dizhiArray[i]);
                
                [ddict setObject:dizhiArray[i] forKey:tianfudict[dizhiArray[i]]];
            }
            if ([arrar1[j] isEqualToString:ziweidict[dizhiArray[i]]]) {
                // NSLog(@"%@ = %@",ziweidict[dizhiArray[i]],dizhiArray[i]);
                [ddict setObject:dizhiArray[i] forKey:ziweidict[dizhiArray[i]]];
                
                
            }
        }
        
    }
    for (int p = 0;p < 6; p++ ) {
        for (int j = 0; j < 4; j++) {
            if ([arrar1[j] isEqualToString:ljwDict.allKeys[p]]) {
                //NSLog(@"%@ = %@",ljwDict.allKeys[p],ljwDict[arrar1[j]]);
                [ddict setObject:ljwDict[arrar1[j]] forKey:ljwDict.allKeys[p]];
                
            }
        }
    }
    //NSLog(@"%@",ddict);
    NSMutableArray * huahuaArra = [NSMutableArray array];
    for (int q =  0 ; q < 4; q ++) {
        [huahuaArra addObject:ddict[arrar1[q]]];
    }
  //  NSLog(@"%@",huahuaArra);
    NSDictionary  * huahuahuahua = @{@"禄":huahuaArra[0],
                                     @"权":huahuaArra[1],
                                     @"科":huahuaArra[2],
                                     @"忌":huahuaArra[3]};

    _dicForSihuaOUT = huahuahuahua;
    
    return huahuahuahua;
}


/**
 *  安生年旬空星
 *
 *  @param nTg 传出生年天干
 *  @param ndzStr 传出生年地支
 *
 *  @return 返回年旬空星所在的地支的字典
 */
-(NSDictionary * )anXunkongxingAndNianTiangan:(NSString *) nTg AndNdz:(NSString *) ndzStr{
    
    NSArray * duiyinArray = [NSArray array];//@[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
    NSArray  *a = @[@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸"];
    
    
    if ([ndzStr isEqualToString:@"子"]) {
        /**
         *  子开始
         */
        duiyinArray = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
        
        
    }else if ([ndzStr isEqualToString:@"丑"]){
        /**
         *  丑开始
         */
        duiyinArray = @[@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子"];
        
    }else if ([ndzStr isEqualToString:@"寅"]){
        /**
         *  寅开始
         */
        duiyinArray = @[@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑"];
        
    }else if ([ndzStr isEqualToString:@"卯"]){
        /**
         *  卯开始
         */
        duiyinArray = @[@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅"];
        
    }else if ([ndzStr isEqualToString:@"辰"]){
        /**
         *  辰开始
         */
        duiyinArray = @[@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯"];
        
    }else if ([ndzStr isEqualToString:@"巳"]){
        /**
         *  巳开始
         */
        duiyinArray = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];
        
    }else if ([ndzStr isEqualToString:@"午"]){
        /**
         *  午开始
         */
        duiyinArray = @[@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳"];
        
    }else if ([ndzStr isEqualToString:@"未"]){
        /**
         *  未开始
         */
        duiyinArray = @[@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午"];
        
        
    }else if ([ndzStr isEqualToString:@"申"]){
        /**
         *  申开始
         */
        duiyinArray = @[@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未"];
        
        
    }else if ([ndzStr isEqualToString:@"酉"]){
        /**
         *  酉开始
         */
        duiyinArray = @[@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申"];
        
    }else if ([ndzStr isEqualToString:@"戌"]){
        /**
         *  戌开始
         */
        duiyinArray = @[@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉"];
        
        
    }else if ([ndzStr isEqualToString:@"亥"]){
        /**
         *  亥开始
         */
        duiyinArray = @[@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌"];
        
    }
    
    NSUInteger   tgindex = [a indexOfObject:nTg];
    
    // NSLog(@"*****************************************%@",duiyinArray[10 - tgindex]);
    
    NSDictionary* dict = @{@"荀空":duiyinArray[9 - tgindex]};

    _dicForXunkongOUT = dict;
    
    return dict;
}


/**
 *  安生年博士十二神
 *
 *  @param lucunxingDict 传禄存星所在地支的字典
 *
 *  @return 返回对应地支的字典
 */
-(NSDictionary *) anShengNianBoshiShiershenAndlucunxing:(NSDictionary *)lucunxingDict withYinyang:(NSString *)yiyang{
    
    NSString * lucunxingDizhiStr = lucunxingDict[@"禄存"];
    
    if ([yiyang isEqualToString:@"阳男"] || [yiyang isEqualToString:@"阴女"]) {
        
        NSArray * duiyinArray =[NSArray array];
        if ([lucunxingDizhiStr isEqualToString:@"子"]) {
            /**
             *  子开始
             */
            duiyinArray = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
            
            
        }else if ([lucunxingDizhiStr isEqualToString:@"丑"]){
            /**
             *  丑开始
             */
            duiyinArray = @[@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子"];
            
        }else if ([lucunxingDizhiStr isEqualToString:@"寅"]){
            /**
             *  寅开始
             */
            duiyinArray = @[@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑"];
            
        }else if ([lucunxingDizhiStr isEqualToString:@"卯"]){
            /**
             *  卯开始
             */
            duiyinArray = @[@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅"];
            
        }else if ([lucunxingDizhiStr isEqualToString:@"辰"]){
            /**
             *  辰开始
             */
            duiyinArray = @[@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯"];
            
        }else if ([lucunxingDizhiStr isEqualToString:@"巳"]){
            /**
             *  巳开始
             */
            duiyinArray = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];
            
        }else if ([lucunxingDizhiStr isEqualToString:@"午"]){
            /**
             *  午开始
             */
            duiyinArray = @[@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳"];
            
        }else if ([lucunxingDizhiStr isEqualToString:@"未"]){
            /**
             *  未开始
             */
            duiyinArray = @[@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午"];
            
            
        }else if ([lucunxingDizhiStr isEqualToString:@"申"]){
            /**
             *  申开始
             */
            duiyinArray = @[@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未"];
            
            
        }else if ([lucunxingDizhiStr isEqualToString:@"酉"]){
            /**
             *  酉开始
             */
            duiyinArray = @[@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申"];
            
        }else if ([lucunxingDizhiStr isEqualToString:@"戌"]){
            /**
             *  戌开始
             */
            duiyinArray = @[@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉"];
            
            
        }else if ([lucunxingDizhiStr isEqualToString:@"亥"]){
            /**
             *  亥开始
             */
            duiyinArray = @[@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌"];
            
        }
        
        
        NSDictionary * dict = @{@"博士":duiyinArray[0],
                                @"力士":duiyinArray[1],
                                @"青龙":duiyinArray[2],
                                @"小耗":duiyinArray[3],
                                @"将军":duiyinArray[4],
                                @"奏书":duiyinArray[5],
                                @"飞廉":duiyinArray[6],
                                @"喜神":duiyinArray[7],
                                @"病符":duiyinArray[8],
                                @"大耗":duiyinArray[9],
                                @"伏兵":duiyinArray[10],
                                @"官符":duiyinArray[11]};
        
       // _dicForBOSHI = dict;
        
        return dict;

        
    }else{
      //  arrForMingpan = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];

        NSArray *arrForBo = @[@"博士",@"力士",@"青龙",@"小耗",@"将军",@"奏书",@"飞廉",@"喜神",@"病符",@"大耗",@"伏兵",@"官符"];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < 12; i++) {
            
            NSString *strForBoDizhi = arrForMingpan[i];
            
            if ([strForBoDizhi isEqualToString:lucunxingDizhiStr]) {
                
                for (int j = 0; j < 12; j++) {
                    
                    NSString *dizhiSTR;
                    if (i >= j) {
                        
                        dizhiSTR = arrForMingpan[i - j];
                        
                    }else{
                       
                        dizhiSTR = arrForMingpan[ 12 - (j - i)];
                    
                        
                    }
                    
                    [dict setObject:dizhiSTR forKey:arrForBo[j]];
                    
                }
                
            }
            
            
        }
        
       
       // _dicForChangchengOUT = dict
        
        return dict;
        
    }
    
 
    

    
    
    
}


/**
 *  安生年岁前十二星
 *
 *  @param ndzStr 传年地支
 *
 *  @return 返回岁前十二星对应地支字典
 */
-(NSDictionary *) anShengSuiQianShierxingAndnianDizhi:(NSString *) ndzStr{
    
    
    NSArray *duiyinArray = [NSArray array];
    if ([ndzStr isEqualToString:@"子"]) {
        /**
         *  子开始
         */
        duiyinArray = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
        
        
    }else if ([ndzStr isEqualToString:@"丑"]){
        /**
         *  丑开始
         */
        duiyinArray = @[@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子"];
        
    }else if ([ndzStr isEqualToString:@"寅"]){
        /**
         *  寅开始
         */
        duiyinArray = @[@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑"];
        
    }else if ([ndzStr isEqualToString:@"卯"]){
        /**
         *  卯开始
         */
        duiyinArray = @[@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅"];
        
    }else if ([ndzStr isEqualToString:@"辰"]){
        /**
         *  辰开始
         */
        duiyinArray = @[@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯"];
        
    }else if ([ndzStr isEqualToString:@"巳"]){
        /**
         *  巳开始
         */
        duiyinArray = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];
        
    }else if ([ndzStr isEqualToString:@"午"]){
        /**
         *  午开始
         */
        duiyinArray = @[@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳"];
        
    }else if ([ndzStr isEqualToString:@"未"]){
        /**
         *  未开始
         */
        duiyinArray = @[@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午"];
        
        
    }else if ([ndzStr isEqualToString:@"申"]){
        /**
         *  申开始
         */
        duiyinArray = @[@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未"];
        
        
    }else if ([ndzStr isEqualToString:@"酉"]){
        /**
         *  酉开始
         */
        duiyinArray = @[@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申"];
        
    }else if ([ndzStr isEqualToString:@"戌"]){
        /**
         *  戌开始
         */
        duiyinArray = @[@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉"];
        
        
    }else if ([ndzStr isEqualToString:@"亥"]){
        /**
         *  亥开始
         */
        duiyinArray = @[@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌"];
        
    }
    
   //龙池凤阁,天哭天虚,孤辰寡宿,天月天巫,白虎丧门,阴煞台辅,封诰华盖,劫煞破碎，大耗天德，龙德月德，天空蜚廉，天官天福，截空三台，八座天贵，恩光天才，天寿天伤，天使。
    NSDictionary * dict = @{@"岁建":duiyinArray[0],
                            @"晦气":duiyinArray[1],
                            @"丧门":duiyinArray[2],
                            @"贯索":duiyinArray[3],
                            @"官符":duiyinArray[4],
                            @"小耗":duiyinArray[5],
                            @"岁破":duiyinArray[6],
                            @"龙德":duiyinArray[7],
                            @"白虎":duiyinArray[8],
                            @"天德":duiyinArray[9],
                            @"吊客":duiyinArray[10],
                            @"病符":duiyinArray[11]};
   //传出
    _dicForSuiqianOUT = dict;
    
    return dict;
}


/**
 *  安生年将前十二星
 *
 *  @param ndzstr 传年地支
 *
 *  @return 返回生年将前十二星对应地支字典
 */
-(NSDictionary *)anShengNianJiangQIanShierxingAndNianDizhi:(NSString *)ndzstr{
    
    NSDictionary * nianDizhi = @{@"子":@"子",
                                 @"丑":@"酉",
                                 @"寅":@"午",
                                 @"卯":@"卯",
                                 @"辰":@"子",
                                 @"巳":@"酉",
                                 @"午":@"午",
                                 @"未":@"卯",
                                 @"申":@"子",
                                 @"酉":@"酉",
                                 @"戌":@"午",
                                 @"亥":@"卯"};
    NSString * str = nianDizhi[ndzstr];
    NSArray  * duiyinArray = [NSArray array];
    
    if ([str isEqualToString:@"子"]) {
        /**
         *  子开始
         */
        duiyinArray = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
        
        
    }else if ([str isEqualToString:@"卯"]){
        /**
         *  卯开始
         */
        duiyinArray = @[@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅"];
        
    }else if ([str isEqualToString:@"午"]){
        /**
         *  午开始
         */
        duiyinArray = @[@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳"];
        
    }else if ([str isEqualToString:@"酉"]){
        /**
         *  酉开始
         */
        duiyinArray = @[@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申"];
        
    }
    NSDictionary * dict = @{@"将星":duiyinArray[0],
                            @"攀鞍":duiyinArray[1],
                            @"岁驿":duiyinArray[2],
                            @"息神":duiyinArray[3],
                            @"华盖":duiyinArray[4],
                            @"劫煞":duiyinArray[5],
                            @"灾煞":duiyinArray[6],
                            @"天煞":duiyinArray[7],
                            @"指背":duiyinArray[8],
                            @"咸池":duiyinArray[9],
                            @"月煞":duiyinArray[10],
                            @"亡神":duiyinArray[11]};
    
    NSArray * jiangqianArray = @[@"将星",@"攀鞍",@"岁驿",@"息神",@"华盖",@"劫煞",@"灾煞",@"天煞",@"指背",@"咸池",@"月煞",@"亡神"];
    
    for (int b = 0; b < 12; b++) {
        [yiqiDict setObject:jiangqianArray[b] forKey:dict[jiangqianArray[b]]];
    }
    NSLog(@"%ld",yiqiDict.allKeys.count);
    return dict;
}



@end
