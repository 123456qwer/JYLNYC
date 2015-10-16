//
//  PanView.m
//  ziweidoushu
//
//  Created by 吴冬 on 15/7/6.
//  Copyright (c) 2015年 吴冬. All rights reserved.
//

#import "PanView.h"
#import "JiepanViewController.h"
#import "sys/sysctl.h"
#define pageHeightBtn 20 / 1334.0 * kScreenHeight

//巧克力色
#define colorForBG [UIColor colorWithRed:139 / 255.0 green:97 / 255.0 blue:22 / 255.0 alpha:1]
//浅色的巧克力色
#define colorForQian [UIColor colorWithRed:151 / 255.0  green:130 / 255.0 blue:127 / 255.0 alpha:1.000]

//四化
#define widthForSihua 28 / 750.0 * kScreenWidth

//中间label
#define xForNameLabel 197 / 750.0 * kScreenWidth
#define yForNameLabel 318 / 1334.0 * kScreenHeight
#define pageForLabel 18 / 1334.0 * kScreenHeight
#define widthForNameLabel 64 / 750.0 * kScreenWidth
#define widthZinianLabel 122 / 750.0 * kScreenWidth
#define heightForLabel 26 / 1334.0 * kScreenHeight


//宫位（小格子,命宫）
#define xForGongSmall 55 / 750.0 * kScreenWidth
#define yForGongSmall (190 + 38 + 3) / 1334.0 * kScreenHeight
#define widthForGongSmall 79 / 750.0 * kScreenWidth
#define heightForGongSmall 38 / 1334.0 * kScreenHeight

//宫位（小格子,流年宫）
#define xForGongLiunian 40 / 750.0 * kScreenWidth
#define yForGongLiunian 190 / 1334.0 * kScreenHeight

//大限
#define yForDaxian (190 + 38  + 38 - 3) / 1334.0 * kScreenHeight

//安博
#define yForAnbo 237 / 1334.0 * kScreenHeight
#define xForAnbo 7 / 750.0 * kScreenWidth
#define heightForAnbo 60 / 1334.0 * kScreenHeight

//天干

#define widthForGongLiunian (kScreenWidth / 4.0 - 40) / 750.0 * kScreenWidth
#define heightForGongLiunian 38 / 1334.0 * kScreenHeight

//星星高度
//#define heightForStar 150 / 1334.0 * kScreenHeight

//小仙
#define xForXiaoxian 198 / 750.0 * kScreenWidth
#define yForXiaoxian (980 - 140) / 1334.0 * kScreenHeight


//中间的星
#define yForMiddleStar 314 / 1334.0 * kScreenHeight
//中间的label
#define yForMiddleXiaoxian 574 / 1334.0 * kScreenHeight
#define widthForMiddleXiaoxian 120 / 750.0 * kScreenWidth
#define heightForMiddleXiaoxian 50 / 1334.0 * kScreenHeight

#define yForTiangandizhi 630 / 1334.0 * kScreenHeight

//解盘按钮
#define xForPushBtn 224 / 750.0 * kScreenWidth
#define yForPushBtn (881 - 128) / 1334.0 * kScreenHeight
#define widthForPushBtn 302 / 750.0 * kScreenWidth
#define heightForPushBtn 72 / 1334.0 * kScreenHeight


@implementation PanView

{
    
    NSInteger _minggongIndex;

    UIView *smallViewForForm;
    CGFloat _heightForForm;
    UIView *lineView;
    UIView *lineView1;
    UIView *verticalLineView;
    UIView *verticalLineView1;
   
    UILabel *_name;
    UILabel *_age;
    UILabel *_yangli;
    UILabel *_yinli;
    
    UILabel *_ageText;
    UILabel *_nameText;
    
    
    UILabel *_panlei;
    UILabel *_mingju;
    UILabel *_mingzhu;
    UILabel *_shenzhu;
    UILabel *_ziniandoujun;
    
    
    
    UILabel *_panleiText;
    UILabel *_mingjuText;
    UILabel *_mingzhuText;
    UILabel *_shenzhuText;
    UILabel *_ziniandoujunText;
    
    
    CGFloat _yForLabel;
    CGFloat _xForLabel;
    CGFloat _heightForLabel;
    CGFloat _pageForLabelBig;
    CGFloat _pageForLabelSmall;
    CGFloat _pageForBTN;
    CGFloat _heightForTop;
    CGFloat _widthForForm;
    CGFloat _widthForFontLabel;
    CGFloat _xForTiangan;
    //俩个格的高度
    CGFloat _heightFor2Star;
    //三个格的高度
    CGFloat _heightFor3Star;
    //字格子的宽度
    CGFloat _widthForStar;
    //适配文字的大小
    UIFont *_starFont;
    UIFont *_middleStarFont;
    //适配中间的宫
    CGFloat _heightForGong;
    //适配大图中间label字的大小
    CGFloat _widthForStarBig;
    //宽度
    CGFloat _heightForStarBig;
    //适配中间宫label的大小
    CGFloat _widthForBigGong;
    //适配中间大限的大小
    CGFloat _widthForBigDaxian;
    //天干地支label大小
    CGFloat _widthForTiangandizhi;
    //选中的宫的index
    CGFloat _indexForSelectedGong;
    CGFloat _heightForStarSmall;
    //适配打团中间的label的字体
    //中间的小限
    NSMutableArray *_arrForImage;
    //圆角
    CGFloat _forMiddle;
    CGFloat heightForStar;
    
    UILabel *_labelForXiaoxian;
    UIFont  *_bigFont;
    UILabel *labelForZiwei; //中间的Label
    UILabel *labelForTianfu; //
    UILabel *labelForLucun;
    UILabel *labelForLiuji;
    UILabel *labelForTaohua;
    UILabel *labelForZaxing;
    UILabel *labelForGong;
    UILabel *labelForGongXiaoxian;
    UILabel *labelForDaxian;
    UILabel *labelForTianganAndDizhi;
    UILabel *labelForSuiqian;
    UILabel *labelForBoshi;
    UILabel *labelForChangsheng;
    UILabel *labelForXunkong;
    UIButton *jiepanBtn;
    UIButton *_middleBTN;
    
    NSMutableArray *_arrForALLgong;
    NSString *_mingDZ;   //通过命地之起大限
    NSArray *_arrForSanfangsizheng; //三方线arr
    NSArray *_arrForAllGong;
    NSArray *_arrForMingpan;   //命盘arr
    NSDictionary *_tianganduiyinDict;  //根据这个字典判断天干,传进来的对比，然后从寅开始算起
    NSArray *_tiangan;    //算天干的数组
    NSMutableDictionary *_tianganDic; //存储地支对应的天干字典
    
    UIButton *_pushBTN;
    UIButton *_btnForView;    //每一个表格中的按钮
    UIView   *_sanfangsizhengView; //中间的view
    //图片
    NSMutableDictionary  *dicForAllStar; //所有的星
    NSMutableDictionary  *dicForDaxianD; //大限所需要的dic
    NSString *_forIPhoneType;
    
    BOOL  _isLiunian;  //判断是否是流年
    NSArray *_arrForLiunian; //流年盘的arr
    NSDictionary *_dicForXiaoxianG;  //流年宫
    NSDictionary *_dicForTianpanG;   //天盘宫
    NSMutableDictionary *_dicForLN;  //存储流年
    
    UIFont *_yinyangFont;
    UIFont *_xiaoxianFont;
    UIFont *_anboFont;
    UIFont *_sihuaFont;
    
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _dicForLN = [NSMutableDictionary dictionary];
        _arrForImage = [NSMutableArray array];
        _arrForALLgong = [NSMutableArray array];
        _dicForSanfangsizheng = [NSMutableDictionary dictionary];
        _dicForAllStarandG = [NSMutableDictionary dictionary];
         _arrForSanfangsizheng = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"010",@"011",@"012"];
         _arrForAllGong = @[@"命宫",@"兄弟",@"夫妻",@"子女",@"财帛",@"疾厄",@"迁移",@"奴仆",@"官禄",@"田宅",@"福德",@"父母"];
         _arrForLiunian = @[@"小限命宫",@"小限兄弟",@"小限夫妻",@"小限子女",@"小限财帛",@"小限疾厄",@"小限迁移",@"小限奴仆",@"小限官禄",@"小限田宅",@"小限福德",@"小限父母"];
         _arrForMingpan = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];
         _tianganduiyinDict = @{@"甲":@"丙",@"己":@"丙",@"乙":@"戊",@"庚":@"戊",@"丙":@"庚",@"辛":@"庚",@"丁":@"壬",@"壬":@"壬",@"戊":@"甲",@"癸":@"甲"};
         _tiangan = @[@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸"];
        dicForDaxianD = [NSMutableDictionary dictionary];
        _tianganDic = [NSMutableDictionary dictionary];

        //创建能用到的Frame
        [self creatForFrame];
        
        //创建命盘轮廓
        [self creatViewForMingpan];
        
        //创建姓名等label；
        [self creatLabelForMingpan];
        
        //创建地之
        [self creatForDizhi];
        
        
     
    }

    return self;
    
}


/**
 *  工具方法，把所有星归类
 *
 *  @param dicForAllStar 所存的总字典
 *  @param dicForStar    当前星的字典
 */
- (void)returnAllDic:(NSMutableDictionary *)dicForAllStar111
                     andNowDic:(NSDictionary *)dicForStar
{

    for (int i = 0 ; i<dicForStar.count; i++) {
        
        NSString *keySTR = dicForStar.allKeys[i];
        NSString *valueSTR = dicForStar[dicForStar.allKeys[i]];
        
        [dicForAllStar111 setObject:valueSTR forKey:keySTR];
        
    }
    
}

/**
 *  排紫薇星系
 *
 *  @param dicForStar
 */
- (void)setDicForZiwei:(NSDictionary *)dicForZiwei
{
    
    if (_dicForZiwei != dicForZiwei) {
        
        _dicForZiwei = dicForZiwei;
        
         // NSArray * zhuxingArray = @[@"紫薇",@"天机",@"太阳",@"武曲",@"天同",@"廉贞",@"天府星",@"太陰星",@"貪狼星",@"巨門星",@"天相星",@"天梁星",@"七殺星",@"破軍星"];

        NSMutableDictionary *dicFOrZi = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < 12; i++) {

                for (int j = 0; j < _dicForZiwei.count; j++) {

                    if ([_dicForZiwei[_dicForZiwei.allKeys[j]] isEqualToString:_arrForMingpan[i]]){

                        //顶头用
                        NSString *Str;
                        NSUInteger a =  [_dicForZiwei.allKeys[j] length];
                        
                        if (a == 3) {
                            
                            Str = _dicForZiwei.allKeys[j];
                            
                        }else{
                            
                            Str = [NSString stringWithFormat:@"%@\n\t",_dicForZiwei.allKeys[j]];
                            
                        }
                        
                        NSMutableAttributedString *strForZwei = [[NSMutableAttributedString alloc]initWithString:Str];
                        [strForZwei addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
                        [strForZwei addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
                        
                        //存储紫薇星
                        NSString *strForZZZ = [Str substringWithRange:NSMakeRange(0, 2)];
                        if ([strForZZZ isEqualToString:@"紫薇"]) {
                            
                            [dicFOrZi setObject:_arrForMingpan[i] forKey:@"紫薇"];
                            
                            _dicForZiweiOnly = dicFOrZi;
                        }
                       

                    UIView *view123 = [self viewWithTag:i + 500];
                    
                    UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - _widthForStar, 0 , _widthForStar , heightForStar)];
                    labelForxing.attributedText = strForZwei;
                    [view123 addSubview:labelForxing];
                 //   labelForxing.backgroundColor = [UIColor orangeColor];
                    labelForxing.numberOfLines = 0;
                    labelForxing.textAlignment = NSTextAlignmentCenter;
                    labelForxing.font = _bigFont;

                }
                    
          
            }
    
        }
        
        
    }

}


/**
 *  排天府星系
 *
 *  @param dicForTianfu
 */
- (void)setDicForTianfu:(NSDictionary *)dicForTianfu
{
    
    if (_dicForTianfu != dicForTianfu) {
        
        _dicForTianfu = dicForTianfu;
        
        
        
        for (int i = 0; i < 12; i++) {
        
            int k = 0;
          
            for (int l = 0; l < 6; l++) {
                
                if ([_dicForZiwei[_dicForZiwei.allKeys[l]] isEqualToString:_arrForMingpan[i]]) {
                    
                    k = 1;
                }
                
            }
            
            for (int j = 0; j < _dicForTianfu.count; j++) {
                
                //NSLog(@"%@",_dicForStar[_dicForStar.allKeys[j]]);
                
                if ([_dicForTianfu[_dicForTianfu.allKeys[j]] isEqualToString:_arrForMingpan[i]]){
                    
                    UIView *view123 = [self viewWithTag:i + 500];
                    
                 

                    
                    NSUInteger a =  [_dicForTianfu.allKeys[j] length];
                    NSString *Str;
                    if (a == 3) {
                      
                        Str = _dicForTianfu.allKeys[j];
                        
                    }else{
                        
                        Str = [NSString stringWithFormat:@"%@\n\t",_dicForTianfu.allKeys[j]];
                    }
                    
                    NSMutableAttributedString *strForTianf = [[NSMutableAttributedString alloc]initWithString:Str];
                    [strForTianf addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
                    [strForTianf addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
                    
                    UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - _widthForStar - _widthForStar * k, 0 , _widthForStar , heightForStar)];
                    labelForxing.attributedText = strForTianf;
                    [view123 addSubview:labelForxing];
                   // labelForxing.backgroundColor = [UIColor yellowColor];
                    labelForxing.numberOfLines = 0;
                    labelForxing.textAlignment = NSTextAlignmentCenter;
                    labelForxing.font = _bigFont;
                    
                }
                
                
            }
            
        }

        
    }
    
}


/**
 *  排禄存星系
 *
 *  @param dicForLucun
 */

- (void)setDicForLucun:(NSDictionary *)dicForLucun
{
    
    if (_dicForLucun != dicForLucun) {
        
        _dicForLucun = dicForLucun;
        
        NSMutableDictionary *dicForAll = [NSMutableDictionary dictionary];
        
       
        [self returnAllDic:dicForAll andNowDic:_dicForZiwei];
        
        [self returnAllDic:dicForAll andNowDic:_dicForTianfu];

        for (int i = 0; i < 12; i++) {
            
            int k = 0;
            
            for (int j = 0; j < dicForAll.count; j++) {
                
                if ([dicForAll[dicForAll.allKeys[j]] isEqualToString:_arrForMingpan[i]]) {
                    
                    k++;
   
                }
  
            }

            for (int l = 0; l < _dicForLucun.count; l++) {
                
                
                if ([_dicForLucun[_dicForLucun.allKeys[l]] isEqualToString:_arrForMingpan[i]] ) {
                    
                    UIView *view123 = [self viewWithTag:i + 500];
                    
                    NSString *Str;

                  
                    NSUInteger a =  [_dicForLucun.allKeys[l] length];
                    
                    if (a == 3) {
                        
                        Str = _dicForLucun.allKeys[l];
                        
                    }else{
                    
                        Str = [NSString stringWithFormat:@"%@\n\t",_dicForLucun.allKeys[l]];
                        
                    }
                    
                    NSMutableAttributedString *strForLucun = [[NSMutableAttributedString alloc]initWithString:Str];
                    [strForLucun addAttribute:NSForegroundColorAttributeName value:colorForAll range:NSMakeRange(0, 2)];
                    [strForLucun addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
                    
                    UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - _widthForStar - _widthForStar * k, 0 , _widthForStar , heightForStar)];
                    labelForxing.attributedText = strForLucun;
                    [view123 addSubview:labelForxing];
                   // labelForxing.backgroundColor = [UIColor cyanColor];
                    labelForxing.numberOfLines = 0;
                    labelForxing.textAlignment = NSTextAlignmentCenter;
                    labelForxing.font = _bigFont;
                    
                    k++;
                    
                }
 
            }
            
        }
   
    }

}


/**
 *  排六吉星系
 *
 *  @param dicForLiuji
 */
- (void)setDicForLiuji:(NSDictionary *)dicForLiuji
{

    if (_dicForLiuji != dicForLiuji) {
        
        _dicForLiuji = dicForLiuji;
        
        NSMutableDictionary *dicForAll = [NSMutableDictionary dictionary];
        
        [self returnAllDic:dicForAll andNowDic:_dicForZiwei];
        [self returnAllDic:dicForAll andNowDic:_dicForTianfu];
        [self returnAllDic:dicForAll andNowDic:_dicForLucun];
        
        
        for (int i = 0; i < 12; i++) {
            
            int k = 0;
            
            for (int j = 0; j < dicForAll.count; j++) {
                
                if ([dicForAll[dicForAll.allKeys[j]] isEqualToString:_arrForMingpan[i]]) {
                    
                    k++;
                    
                }
                
            }
            
            for (int l = 0; l < _dicForLiuji.count; l++) {
                
                
                if ([_dicForLiuji[_dicForLiuji.allKeys[l]] isEqualToString:_arrForMingpan[i]] ) {
                    
                    UIView *view123 = [self viewWithTag:i + 500];
                    
                    NSString *Str;

                    
                    NSUInteger a =  [_dicForLiuji.allKeys[l] length];
                    
                    if (a == 3) {
                        
                        Str = _dicForLiuji.allKeys[l];
                        
                    }else{
                        
                      
                        Str = [NSString stringWithFormat:@"%@\n\t",_dicForLiuji.allKeys[l]];
                    }
                    
                    
                    NSMutableAttributedString *strForLiuji = [[NSMutableAttributedString alloc]initWithString:Str];
                    [strForLiuji addAttribute:NSForegroundColorAttributeName value:colorForAll range:NSMakeRange(0, 2)];
                    [strForLiuji addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
                    

                    
                    UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - _widthForStar - _widthForStar * k, 0, _widthForStar , heightForStar)];
                    labelForxing.attributedText = strForLiuji;
                    [view123 addSubview:labelForxing];
                  //  labelForxing.backgroundColor = [UIColor redColor];
                    labelForxing.numberOfLines = 0;
                    labelForxing.textAlignment = NSTextAlignmentCenter;
                    labelForxing.font = _bigFont;
                    
                    k++;
                    
                }
                
            }
            
        }
        
        
    }

}

/**
 *  排桃花星系
 *
 *  @param dicForTaohua
 */
- (void)setDicForTaohua:(NSDictionary *)dicForTaohua
{
    
    if (_dicForTaohua != dicForTaohua) {
        
        _dicForTaohua = dicForTaohua;
        
        NSMutableDictionary *dicForAll = [NSMutableDictionary dictionary];
        
        [self returnAllDic:dicForAll andNowDic:_dicForZiwei];
        [self returnAllDic:dicForAll andNowDic:_dicForTianfu];
        [self returnAllDic:dicForAll andNowDic:_dicForLucun];
        [self returnAllDic:dicForAll andNowDic:_dicForLiuji];
        
        for (int i = 0; i < 12; i++) {
            
            int k = 0;
            
            for (int j = 0; j < dicForAll.count; j++) {
                
                if ([dicForAll[dicForAll.allKeys[j]] isEqualToString:_arrForMingpan[i]]) {
                    
                    k++;
                    
                }
                
            }
            
            for (int l = 0; l < _dicForTaohua.count; l++) {
                
                
                if ([_dicForTaohua[_dicForTaohua.allKeys[l]] isEqualToString:_arrForMingpan[i]] ) {
                    
                    if (k >= 5) {
                        
                        //return;
                        
                    }else{
                    
                        UIView *view123 = [self viewWithTag:i + 500];
                        
                        NSString *Str;
                        
                        NSUInteger a =  [_dicForTaohua.allKeys[l] length];
                        
                        if (a == 3) {
                      
                            Str = _dicForTaohua.allKeys[l];
                            
                        }else{
                            
                            Str = [NSString stringWithFormat:@"%@\n\t",_dicForTaohua.allKeys[l]];
                        }
                        
                        NSMutableAttributedString *strForTaohua = [[NSMutableAttributedString alloc]initWithString:Str];
                        [strForTaohua addAttribute:NSForegroundColorAttributeName value:colorForQian range:NSMakeRange(0, 2)];
                        [strForTaohua addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
                        

                        
                        UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - _widthForStar - _widthForStar * k, 0, _widthForStar , heightForStar)];
                        labelForxing.attributedText = strForTaohua;
                        [view123 addSubview:labelForxing];
                        //labelForxing.backgroundColor = [UIColor whiteColor];
                        labelForxing.numberOfLines = 0;
                        labelForxing.textAlignment = NSTextAlignmentCenter;
                        labelForxing.font = _bigFont;
                        
                        k++;
                        
                    }
  
                }
                
            }
            
        }
        

        
    }

}


/**
 *  旬空星
 *
 *  @param dicForXunkong
 */
- (void)setDicForXunkong:(NSDictionary *)dicForXunkong
{
   
    if (_dicForXunkong != dicForXunkong) {
        
        _dicForXunkong = dicForXunkong;
        
        NSMutableDictionary *dicForAll = [NSMutableDictionary dictionary];
        
        [self returnAllDic:dicForAll andNowDic:_dicForZiwei];
        [self returnAllDic:dicForAll andNowDic:_dicForTianfu];
        [self returnAllDic:dicForAll andNowDic:_dicForLucun];
        [self returnAllDic:dicForAll andNowDic:_dicForLiuji];
        [self returnAllDic:dicForAll andNowDic:_dicForTaohua];
        
        for (int i = 0; i< 12; i++) {
            
            int k = 0;
            
            for (int j = 0; j < dicForAll.count; j++) {
                
                if ([dicForAll[dicForAll.allKeys[j]] isEqualToString:_arrForMingpan[i]]) {
                    
                    k++;
                    
                }
                
            }
            
            for (int l = 0; l < _dicForXunkong.count; l++) {
                
                
                if ([_dicForXunkong[_dicForXunkong.allKeys[l]] isEqualToString:_arrForMingpan[i]] ) {
                    
                    UIView *view123 = [self viewWithTag:i + 500];
                    
                    NSString *Str = [NSString stringWithFormat:@"%@\n\t",_dicForXunkong.allKeys[l]];
                    
                    UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - _widthForStar - _widthForStar * k, 0 , _widthForStar , heightForStar)];
                    labelForxing.text = Str;
                    [view123 addSubview:labelForxing];
               //     labelForxing.backgroundColor = [UIColor greenColor];
                    labelForxing.numberOfLines = 0;
                    labelForxing.textColor = [UIColor colorWithRed:151 / 255.0  green:130 / 255.0 blue:127 / 255.0 alpha:1.000];
                    labelForxing.textAlignment = NSTextAlignmentCenter;
                    labelForxing.font = _bigFont;
                    
                    k++;
                    
                }
                
            }
            
        }
        
    }

}

/**
 *  长生12神
 *
 *  @param dicForChangsheng
 */
- (void)setDicForChangsheng:(NSDictionary *)dicForChangsheng
{
   
    if (_dicForChangsheng != dicForChangsheng) {
        
        _dicForChangsheng = dicForChangsheng;
        
        for (int i = 0; i < 12; i++) {
            
            NSString *strForChangsheng = _arrForMingpan[i];
            
            for (int j = 0; j < 12; j++) {
                
                NSString *strForNowCS = _dicForChangsheng[_dicForChangsheng.allKeys[j]];
                
                if (strForChangsheng == strForNowCS) {
                    
                    UIView *view123 = [self viewWithTag:i + 500];
                    
                    UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - _widthForStar, _heightForForm - _heightFor2Star , _widthForStar, _heightFor2Star)];
                 //   labelForxing.text = _dicForChangsheng.allKeys[j];
                    [view123 addSubview:labelForxing];
                 //   labelForxing.backgroundColor = [UIColor greenColor];
                    labelForxing.numberOfLines = 0;
                    labelForxing.textColor = colorForQian;
                    labelForxing.textAlignment = NSTextAlignmentCenter;
                    labelForxing.font = _starFont;

                }
                
            }
            
            
        }
        
    }

}


/**
 *  四化
 *
 *  @param dicForSihua 
 */
- (void)setDicForSihua:(NSDictionary *)dicForSihua
{
    
    if (_dicForSihua != dicForSihua) {
        
        _dicForSihua = dicForSihua;
        
        for (int i = 0;  i < 12 ; i++) {
            
            NSString *strForSihua = _arrForMingpan[i];
            
            int k = 0;
            
            for (int j = 0; j < _dicForSihua.count; j++) {
                
                
                NSString *strForNowSihua = _dicForSihua[_dicForSihua.allKeys[j]];
                
                if (strForNowSihua == strForSihua) {
                    
                    UIView *view123 = [self viewWithTag:i + 500];
                    
                    UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - (widthForSihua + 3) - (widthForSihua + 3) * k , heightForStar   , widthForSihua , widthForSihua)];
                    labelForxing.text = _dicForSihua.allKeys[j];
                    [view123 addSubview:labelForxing];
                    labelForxing.backgroundColor = colorForAll;
                    labelForxing.numberOfLines = 0;
                    labelForxing.textColor = [UIColor whiteColor];
                    [labelForxing sizeThatFits:CGSizeMake(widthForSihua, widthForSihua)];
                    labelForxing.textAlignment = NSTextAlignmentCenter;
                    labelForxing.font = _sihuaFont;
                    
                    k++;

                }
                
   
                
            }
            
        }
        
    }

}

/**
 *  杂星
 *
 *  @param dicForZaxing
 */

- (void)setDicForZaxing:(NSDictionary *)dicForZaxing
{
   
    if (_dicForZaxing != dicForZaxing) {
 
        _dicForZaxing = dicForZaxing;
        
        NSMutableDictionary *dicForAll123 = [NSMutableDictionary dictionary];
        
        [self returnAllDic:dicForAll123 andNowDic:_dicForZiwei];
        [self returnAllDic:dicForAll123 andNowDic:_dicForTianfu];
        [self returnAllDic:dicForAll123 andNowDic:_dicForLucun];
        [self returnAllDic:dicForAll123 andNowDic:_dicForLiuji];
        [self returnAllDic:dicForAll123 andNowDic:_dicForTaohua];
        [self returnAllDic:dicForAll123 andNowDic:_dicForXunkong];
        
        for (int i = 0; i < 12; i++) {
            
            NSString *strForZaxing = _arrForMingpan[i];
            
            int k = 0;
            
            for (int j = 0; j <dicForAll123.count; j++) {
                
                if ([dicForAll123[dicForAll123.allKeys[j]] isEqualToString:_arrForMingpan[i]]) {
                    
                    k++;
                    
                }
                
            }
            
            for (int j = 0; j < _dicForZaxing.count; j++) {
                
                if ([_dicForZaxing[_dicForZaxing.allKeys[j]] isEqualToString:strForZaxing]) {
                    
                    if (k >= 5) {
                        
                        //NSLog(@"我超出了显示范围了");
                        
                    }else{
                    
                        UIView *view123 = [self viewWithTag:i + 500];
                        
                        NSString *Str = [NSString stringWithFormat:@"%@\n\t",_dicForZaxing.allKeys[j]];
                        
                        UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - _widthForStar - _widthForStar * k, 0  , _widthForStar , heightForStar)];
                        labelForxing.text = Str;
                        [view123 addSubview:labelForxing];
                        //labelForxing.backgroundColor = [UIColor magentaColor];
                        labelForxing.numberOfLines = 0;
                        labelForxing.textColor = [UIColor colorWithRed:151 / 255.0  green:130 / 255.0 blue:127 / 255.0 alpha:1.000];
                        labelForxing.textAlignment = NSTextAlignmentCenter;
                        labelForxing.font = _bigFont;
                        
                        k++;
                    }
                    
               
                    
                  
   
                }
                
                
            }
            
            
        }
        
    }
  

}


/**
 *  岁前星
 *
 *  @param dicForSuiqian
 */
- (void)setDicForSuiqian:(NSDictionary *)dicForSuiqian
{

    if (_dicForSuiqian != dicForSuiqian) {
        
        _dicForSuiqian = dicForSuiqian;
        
   
        NSMutableDictionary *dicForAll123 = [NSMutableDictionary dictionary];
        
        [self returnAllDic:dicForAll123 andNowDic:_dicForZiwei];
        [self returnAllDic:dicForAll123 andNowDic:_dicForTianfu];
        [self returnAllDic:dicForAll123 andNowDic:_dicForLucun];
        [self returnAllDic:dicForAll123 andNowDic:_dicForLiuji];
        [self returnAllDic:dicForAll123 andNowDic:_dicForTaohua];
        [self returnAllDic:dicForAll123 andNowDic:_dicForXunkong];
        [self returnAllDic:dicForAll123 andNowDic:_dicForZaxing];

        for (int i = 0 ; i< 12; i++) {
            
            NSString *strForSuiqian = _arrForMingpan[i];
            
            int k = 0;
            
            for (int j = 0; j <dicForAll123.count; j++) {
                
                if ([dicForAll123[dicForAll123.allKeys[j]] isEqualToString:_arrForMingpan[i]]) {
                    
                    k++;
                    
                }
                
            }
            
            
            for (int j = 0; j < _dicForSuiqian.count; j++) {
                
                if ([_dicForSuiqian[_dicForSuiqian.allKeys[j]] isEqualToString:strForSuiqian]) {
                    
                    if (k >= 5) {
                        
                       // NSLog(@"我超出了显示范围");
                        
                    }else{
                        
                        NSString *Str;
                        
                        Str = [NSString stringWithFormat:@"%@\n\t",_dicForSuiqian.allKeys[j]];
                        
                        UIView *view123 = [self viewWithTag:i + 500];
                        
                        UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - _widthForStar - _widthForStar * k, 0 , _widthForStar , heightForStar)];
                        labelForxing.text = Str;
                        [view123 addSubview:labelForxing];
                   //     labelForxing.backgroundColor = [UIColor magentaColor];
                        labelForxing.numberOfLines = 0;
                        labelForxing.textColor = [UIColor colorWithRed:151 / 255.0  green:130 / 255.0 blue:127 / 255.0 alpha:1.000];
                        labelForxing.textAlignment = NSTextAlignmentCenter;
                        labelForxing.font = _bigFont;
                        
                        k++;
                    
                    }
                    
               
                    
                }
                
                
            }
            
        }
        
        
    }
    

}

/**
 *  算天干排位 ,在这里拼串
 */
- (void)setTianganSTR:(NSString *)tianganSTR
{
    
    if (_tianganSTR != tianganSTR) {
        
        _tianganSTR = tianganSTR;
        
        NSString  * tg = [_tianganduiyinDict objectForKey:tianganSTR];//根据传进来的STR判断天干对应的寅天干
        NSMutableArray *firstTiangan = [NSMutableArray array];
        NSMutableArray *secondQuanArr = [NSMutableArray array];
        NSInteger tagForView = 0;//数组里天干的个数
        NSInteger tagForTiangan = 0;//剩下天干的个数
        
        
        for (int i = 0; i < 10; i++) {
            
            NSString * str = [_tiangan objectAtIndex:i];
            
            if ([tg isEqualToString:str]) {
                
                tagForTiangan = 12-(10- i);
                tagForView = 10 - i;
                for (int k = i;k <10 ; k ++) {
                    NSString * tem = [_tiangan objectAtIndex:k];
                    [firstTiangan addObject:tem];
                    
                }
                for (int p  = 0; p < tagForTiangan; p++) {
                    NSString * shengxiaTem = [_tiangan objectAtIndex:p];
                    [secondQuanArr addObject:shengxiaTem];
                }
            }
            
        }
        //
        NSInteger fuck = 0;
        NSInteger fuckyou = 0;
        
        for (int r = 0; r < tagForView; r++) {
            
            
            
            if (r + 9 >= 12) {
                
                fuck = r + 9 - 12;
                
            }else if(r + 9 < 12 ){
                
                fuck = r + 9;
            }
            
            UIView *view11 = [self viewWithTag:fuck + 500];
            UILabel *tianganLabel = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - xForAnbo - 16, yForAnbo , 15, heightForAnbo)];
            NSString *strForTiangan = [firstTiangan objectAtIndex:r];
            NSString *strForDizhi = _arrForMingpan[fuck];
            NSString *strForZuhe = [NSString stringWithFormat:@"%@\n%@",strForTiangan,strForDizhi];
            tianganLabel.text = strForZuhe;
            [_tianganDic setObject:[firstTiangan objectAtIndex:r] forKey:_arrForMingpan[fuck]];
            tianganLabel.textAlignment = NSTextAlignmentCenter;
            tianganLabel.font = _anboFont;
            tianganLabel.numberOfLines = 0;
            [tianganLabel sizeThatFits:CGSizeMake(15, heightForAnbo)];
            tianganLabel.textColor = colorForQian;
           // tianganLabel.backgroundColor = [UIColor orangeColor];
            [view11 addSubview:tianganLabel];
            
        }
        
        for (int f = 0; f < tagForTiangan; f++) {
            
            if (9 + tagForView < 12) {
                
                fuckyou = 9 + f + tagForView;
                
            }else if(9 + tagForView >=12 ){
                
                fuckyou = 9 +tagForView - 12 + f;
                
            }
            
            
            
            if (fuckyou >= 12) {
                
                fuckyou = fuckyou - 12;
            }
            
            UIView *view11 = [self viewWithTag:fuckyou + 500];
            UILabel *tianganLabel = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - xForAnbo - 16, yForAnbo , 15, heightForAnbo)];
            NSString *strForTiangan = [secondQuanArr objectAtIndex:f];
            NSString *strForDizhi = _arrForMingpan[fuckyou];
            NSString *strForZuhe = [NSString stringWithFormat:@"%@\n%@",strForTiangan,strForDizhi];
            tianganLabel.text = strForZuhe;
            [_tianganDic setObject:[secondQuanArr objectAtIndex:f] forKey:_arrForMingpan[fuckyou]];
            tianganLabel.textAlignment = NSTextAlignmentCenter;
            tianganLabel.font = _anboFont;
            [tianganLabel sizeThatFits:CGSizeMake(15, heightForAnbo)];
            tianganLabel.textColor = colorForQian;
            tianganLabel.numberOfLines = 0;
          //  tianganLabel.backgroundColor = [UIColor orangeColor];
            [view11 addSubview:tianganLabel];
            
        }
        
    }

}


/**
 *  创建地之
 */
- (void)creatForDizhi
{

    for (int i = 0 ; i < 12; i++) {
        
        UIView *dizhiView = [self viewWithTag:500 + i];
        
        UILabel *dizhiLabel = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm - 13 - 15,_heightFor2Star + _heightFor3Star + _heightForGong + 15, 13, 15)];
    //    dizhiLabel.backgroundColor = [UIColor orangeColor];
        dizhiLabel.textAlignment = NSTextAlignmentCenter;
        dizhiLabel.font = _starFont;
      //  dizhiLabel.text = _arrForMingpan[i];
        [dizhiView addSubview:dizhiLabel];

    }
    
}


//获得设备型号
- (NSString *)getCurrentDeviceModel{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}



/**
 *  初始化大小距离
 */
- (void)creatForFrame
{
    
    //表格宽度
    _widthForForm = (kScreenWidth - 5 * 0.5) / 4.0;

    
    //字的宽度
    _widthForStar = _widthForForm / 5.0;
    
    //中间大字宽度
    _widthForStarBig = (_widthForForm * 2 - 15 - 6 * 5) / 7.0;
    _heightForStarSmall = 68 / 1136.0 * kScreenHeight;
    //中间宫字的宽度
    _widthForBigGong = _widthForStarBig * 3 + 4 * 5;
    
    //中间大限的宽度
    _widthForBigDaxian = _widthForBigGong ;
    
    //中间小label的宽度
    _widthForTiangandizhi = _widthForStarBig * 2 + 5;
    
    //字体大小
    
    // 4 - > 9  5 - > 10  6 - > 12
    NSString *str =  [self getCurrentDeviceModel];
    
    _forIPhoneType = str;
    
    if ([str isEqualToString:@"iPhone 4"] || [str isEqualToString:@"iPhone 4S"]) {
        
        _anboFont = [UIFont systemFontOfSize:8];
        _yinyangFont = [UIFont systemFontOfSize:11];
        _xiaoxianFont = [UIFont systemFontOfSize:11];
        _starFont = [UIFont systemFontOfSize:9];
        _bigFont = [UIFont systemFontOfSize:10];
        _middleStarFont = [UIFont systemFontOfSize:13];
        _forMiddle = 7;
        _widthForFontLabel = 30;

        
    }else if([str isEqualToString:@"iPhone 5"] || [str isEqualToString:@"iPhone 5c"] || [str isEqualToString:@"iPhone 5s"]){
    
        _anboFont = [UIFont systemFontOfSize:10];
        _yinyangFont = [UIFont systemFontOfSize:11];
        _xiaoxianFont = [UIFont systemFontOfSize:11];
        _starFont = [UIFont systemFontOfSize:10];
        _bigFont = [UIFont systemFontOfSize:12];
        _forMiddle = 10;
        _middleStarFont = [UIFont systemFontOfSize:15];
        _widthForFontLabel = 35;
        
    }else if([str isEqualToString:@"iPhone 6"]){
    
        _sihuaFont = [UIFont systemFontOfSize:11];
        _anboFont = [UIFont systemFontOfSize:10];
        _yinyangFont = [UIFont systemFontOfSize:11];
        _xiaoxianFont = [UIFont systemFontOfSize:11];
        _starFont = [UIFont systemFontOfSize:12];
        _bigFont = [UIFont systemFontOfSize:14];
        _middleStarFont = [UIFont systemFontOfSize:18];
        _forMiddle = 12;
        _widthForFontLabel = 40;
        
    }else if([str isEqualToString:@"iPhone 6 Plus"]){
      
        _sihuaFont = [UIFont systemFontOfSize:11];
        _yinyangFont = [UIFont systemFontOfSize:11];
        _xiaoxianFont = [UIFont systemFontOfSize:11];
        _anboFont = [UIFont systemFontOfSize:11];
        _starFont = [UIFont systemFontOfSize:13];
        _bigFont = [UIFont systemFontOfSize:16];
        _middleStarFont = [UIFont systemFontOfSize:20];
        _forMiddle = 12;
        _widthForFontLabel = 45;
        
    }else{
        
        _sihuaFont = [UIFont systemFontOfSize:11];
        _anboFont = [UIFont systemFontOfSize:11];
        _yinyangFont = [UIFont systemFontOfSize:13];
        _xiaoxianFont = [UIFont systemFontOfSize:13];
        _starFont = [UIFont systemFontOfSize:13];
        _bigFont = [UIFont systemFontOfSize:16];
        _middleStarFont = [UIFont systemFontOfSize:20];
        _forMiddle = 12;
        _widthForFontLabel = 45;
        
    }
    
    
    //距离顶部高度
    _heightForTop= 128 / 1334.0 * kScreenHeight;

    //表格高度
    _heightForForm = (kScreenHeight - _heightForTop - 5 * 0.5) / 4.0 ;
    //星的高度
    heightForStar = [self returnStrHeight:@"紫\n微\n星" andFont:_bigFont andWidth:_widthForStar andHeight:MAXFLOAT].height;
    //中间星的高度
    _heightForStarBig = [self returnStrHeight:@"紫\n微\n星" andFont:_middleStarFont andWidth:_widthForStarBig  andHeight:MAXFLOAT].height;
    
    
    //字的高度
    _heightFor2Star = _heightForForm / 5.0;
    //子的高度3
    _heightFor3Star = _heightForForm / 3.3;
    //宫的高度
    _heightForGong = _heightForForm / 5.0;
 
    
    //label Y X坐标
    _yForLabel = 287/ 1136.0 * kScreenHeight;
    _xForLabel = 177 / 640.0 * kScreenWidth;
    
    
    //label的高度
   // _heightForLabel = 16 / 1136.0 *
    
    //label 间距
    _pageForLabelBig = 36 / 1136.0 * kScreenHeight;
    _pageForLabelSmall = 16 / 1136.0 * kScreenHeight - 10;
    
    //按钮与label间距
    _pageForBTN = 24 / 1136.0 * kScreenHeight;
    
    
    //创建解盘按钮
    //解盘按钮
    _pushBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    _pushBTN.frame = CGRectMake(xForPushBtn, yForPushBtn, widthForPushBtn, heightForPushBtn);
    [_pushBTN addTarget:self action:@selector(pushJiepanView) forControlEvents:UIControlEventTouchUpInside];
    [_pushBTN setTitle:@"小限流年分析" forState:UIControlStateNormal];
    [_pushBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pushBTN.backgroundColor = colorForAll;
    _pushBTN.layer.cornerRadius = 13;
    [self addSubview:_pushBTN];
  

}

//返回高度
- (CGSize )returnStrHeight:(NSString *)str andFont:(UIFont *)font andWidth:(CGFloat )width andHeight:(CGFloat )height
{
    NSMutableParagraphStyle *mutableStyle = [[NSMutableParagraphStyle alloc]init];
    
    NSDictionary* dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:mutableStyle};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}


//
- (void)pushJiepanView
{
   
    if ([self.delegateForPan respondsToSelector:@selector(pushJiepanView)]) {
        
        [self.delegateForPan pushJiepanView];
        
    }

}

/**
 *  创建姓名、年龄等Label
 */
- (void)creatLabelForMingpan
{
    //姓名
    _name = [[UILabel alloc]initWithFrame:CGRectMake(xForNameLabel, yForNameLabel, _widthForFontLabel, heightForLabel)];
    _name.text = @"姓名:";
   // _name.backgroundColor = [UIColor orangeColor];
    _name.font = _bigFont;
    _name.textColor = colorForBG;
    [self addSubview:_name];
    //可改变姓名属性
    _nameText = [[UILabel alloc]initWithFrame:CGRectMake(_name.right, _name.origin.y, 100, heightForLabel)];
    _nameText.text = @"雷老虎";
 //   _nameText.backgroundColor = [UIColor orangeColor];
    _nameText.font = _bigFont;
    _nameText.textColor = [UIColor blackColor];
    [self addSubview:_nameText];
    
    
    //年龄
    _age = [[UILabel alloc]initWithFrame:CGRectMake(_name.origin.x, _name.bottom + pageForLabel, _widthForFontLabel, heightForLabel)];
    _age.text = @"年龄:";
  //  _age.backgroundColor = [UIColor orangeColor];
    _age.font = _bigFont;
    _age.textColor = colorForBG;
    [self addSubview:_age];
    //可改变的年龄属性
    _ageText = [[UILabel alloc]initWithFrame:CGRectMake(_age.right, _age.origin.y, 100, heightForLabel)];
    _ageText.text = @"25";
  //  _ageText.backgroundColor = [UIColor orangeColor];
    _ageText.font = _bigFont;
    _ageText.textColor = [UIColor blackColor];
    [self addSubview:_ageText];
    
    //阳历
    _yangli = [[UILabel alloc]initWithFrame:CGRectMake(_name.origin.x, _age.bottom + pageForLabel , _widthForFontLabel, heightForLabel)];
    _yangli.numberOfLines = 0;
    _yangli.text = @"阳历:";
  //  _yangli.backgroundColor = [UIColor orangeColor];
    _yangli.textColor = colorForBG;
    _yangli.font = _bigFont;
    [self addSubview:_yangli];
    
    _yangliText = [[UILabel alloc]initWithFrame:CGRectMake(_yangli.right, _yangli.origin.y, 200, heightForLabel)];
    _yangliText.text = @"";
    _yangliText.font = _yinyangFont;
    [self addSubview:_yangliText];
    
    
    //阴历
    _yinli = [[UILabel alloc]initWithFrame:CGRectMake(_name.origin.x, _yangli.bottom + pageForLabel, _widthForFontLabel, heightForLabel)];
    _yinli.text = @"阴历:";
    _yinli.textColor = colorForBG;
    _yinli.font = _bigFont;
    [self addSubview:_yinli];
    
    _yinliText = [[UILabel alloc]initWithFrame:CGRectMake(_yinli.right, _yinli.origin.y, 200, heightForLabel)];
    _yinliText.font = _yinyangFont;
    [self addSubview:_yinliText];
    
    
    //盘类
    _panlei = [[UILabel alloc]initWithFrame:CGRectMake(_name.origin.x, _yinli.bottom + pageForLabel , _widthForFontLabel, heightForLabel)];
    _panlei.text = @"盘类:";
   // _panlei.backgroundColor = [UIColor orangeColor];
    _panlei.font = _bigFont ;
    _panlei.textColor = colorForBG;
    [self addSubview:_panlei];
    //可变的盘类属性
    _panleiText = [[UILabel alloc]initWithFrame:CGRectMake(_panlei.right, _panlei.origin.y, 100, heightForLabel)];
    _panleiText.text = @"小限盘";
  //  _panleiText.backgroundColor = [UIColor orangeColor];
    _panleiText.font = _bigFont;
    _panleiText.textColor = [UIColor blackColor];
    [self addSubview:_panleiText];
    
    
    
    //命局
    _mingju = [[UILabel alloc]initWithFrame:CGRectMake(_name.origin.x, _panlei.bottom + pageForLabel, _widthForFontLabel, heightForLabel)];
    _mingju.text = @"命局:";
 //   _mingju.backgroundColor = [UIColor orangeColor];
    _mingju.font = _bigFont;
    _mingju.textColor = colorForBG;
    [self addSubview:_mingju];
    //可变的命局属性
    _mingjuText = [[UILabel alloc]initWithFrame:CGRectMake(_mingju.right, _panlei.bottom + pageForLabel, 100, heightForLabel)];
    _mingjuText.text = @"木三局";
  //  _mingjuText.backgroundColor = [UIColor orangeColor];
    _mingjuText.font = _bigFont;
    _mingjuText.textColor = [UIColor blackColor];
    [self addSubview:_mingjuText];
    
    
    //命主
    _mingzhu = [[UILabel alloc]initWithFrame:CGRectMake(_name.origin.x, _mingju.bottom + pageForLabel, _widthForFontLabel, heightForLabel)];
    _mingzhu.text = @"命主:";
  //  _mingzhu.backgroundColor = [UIColor orangeColor];
    _mingzhu.font = _bigFont;
    _mingzhu.textColor = colorForBG;
    [self addSubview:_mingzhu];
    //可变的命主属性
    _mingzhuText = [[UILabel alloc]initWithFrame:CGRectMake(_mingzhu.right, _mingju.bottom + pageForLabel, 100, heightForLabel)];
    _mingzhuText.text = @"巨门";
  //  _mingzhuText.backgroundColor = [UIColor orangeColor];
    _mingzhuText.font = _bigFont;
    _mingzhuText.textColor = [UIColor blackColor];
    [self addSubview:_mingzhuText];
    
    
    //身主
    _shenzhu = [[UILabel alloc]initWithFrame:CGRectMake(_name.origin.x, _mingzhu.bottom + pageForLabel, _widthForFontLabel, heightForLabel)];
    _shenzhu.text = @"身主:";
 //   _shenzhu.backgroundColor = [UIColor orangeColor];
    _shenzhu.font = _bigFont;
    _shenzhu.textColor = colorForBG;
    [self addSubview:_shenzhu];
    //可变的身主属性
    _shenzhuText = [[UILabel alloc]initWithFrame:CGRectMake(_shenzhu.right, _mingzhu.bottom + pageForLabel, 100, heightForLabel)];
    _shenzhuText.text = @"天相";
  //  _shenzhuText.backgroundColor = [UIColor orangeColor];
    _shenzhuText.font = _bigFont;
    _shenzhuText.textColor = [UIColor blackColor];
    [self addSubview:_shenzhuText];
    
    
    //子年斗君
    _ziniandoujun = [[UILabel alloc]initWithFrame:CGRectMake(_name.origin.x, _shenzhu.bottom + pageForLabel, _widthForFontLabel * 2 - 10, heightForLabel)];
    _ziniandoujun.text = @"子年斗君:";
  //  _ziniandoujun.backgroundColor = [UIColor orangeColor];
    _ziniandoujun.font = _bigFont;
    _ziniandoujun.textColor = colorForBG;
    [self addSubview:_ziniandoujun];
    //子年斗君的身主属性
    _ziniandoujunText = [[UILabel alloc]initWithFrame:CGRectMake(_ziniandoujun.right, _shenzhu.bottom + pageForLabel, 40, heightForLabel)];
    _ziniandoujunText.text = @"卯";
   // _ziniandoujunText.backgroundColor = [UIColor orangeColor];
    _ziniandoujunText.font = _bigFont;
    _ziniandoujunText.textColor = [UIColor blackColor];
    [self addSubview:_ziniandoujunText];
    
    //回复中间的btn
    _middleBTN = [[UIButton alloc]initWithFrame:CGRectMake(_widthForForm + 0.5, _heightForForm + 0.5, _widthForForm * 2, _heightForForm + _heightForForm / 2.0)];
    [_middleBTN addTarget:self action:@selector(returnMiddlelabelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_middleBTN];
    
    //中间的小限
    _labelForXiaoxian = [[UILabel alloc]initWithFrame:CGRectMake(_widthForForm, yForXiaoxian, _widthForForm * 2, 20)];
    _labelForXiaoxian.font = _xiaoxianFont;
    _labelForXiaoxian.textColor = colorForQian;
   // _labelForXiaoxian.backgroundColor = [UIColor orangeColor];
    _labelForXiaoxian.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_labelForXiaoxian];
    
}



/**
 *  恢复中间的视图
 */
- (void)returnMiddlelabelAction
{
    UIView *selectedView = [self viewWithTag:_indexForSelectedGong];
    
    selectedView.backgroundColor = [UIColor clearColor];

    [self removeAllStarAction];
    
    for (int i = 0; i < _arrForImage.count; i++) {
        
        UIImageView *imageV = _arrForImage[i];
        
        [imageV removeFromSuperview];
        
    }
    
   
    [_arrForImage removeAllObjects];
    
    
    NSLog(@"123,点击我跳转回去咯");
    _name.hidden = NO;
    _nameText.hidden = NO;
    _age.hidden = NO;
    _ageText.hidden = NO;
    _yangli.hidden = NO;
    _yinliText.hidden = NO;
    _yangliText.hidden = NO;
    _yinli.hidden = NO;
    _panlei.hidden = NO;
    _panleiText.hidden = NO;
    _mingju.hidden = NO;
    _mingjuText.hidden = NO;
    _mingzhu.hidden = NO;
    _mingzhuText.hidden = NO;
    _shenzhu.hidden = NO;
    _shenzhuText.hidden = NO;
    _ziniandoujun.hidden = NO;
    _ziniandoujunText.hidden = NO;
   // _jiepanBTN.hidden = NO;

}


/**
 *  push出解盘的视图
 *
 *  @param sender 按钮
 */
- (void)jiepanAction:(UIButton *)sender
{
    UIResponder *next = [self nextResponder];
    
    do {
        if ([next isKindOfClass:[UINavigationController class]]) {
            
            JiepanViewController *vc = [[JiepanViewController alloc]init];
            UINavigationController *vc123 = (UINavigationController *)next;
            
            [vc123 pushViewController:vc animated:YES];
            
            return;
            
        }
        next = [next nextResponder];
    } while (next != nil);

    
    
}


/**
 *  创建命盘的轮廓
 */
- (void)creatViewForMingpan
{
  
    CGFloat height = _heightForForm;
    CGFloat heightForVline = _heightForForm * 4 + 0.5 * 5;
    
    //整个表盘，寅在第九格
    for (int i = 0; i < 12; i++) {
        
        if (i < 4) {
            
            
            smallViewForForm = [[UIView alloc]initWithFrame:CGRectMake( _widthForForm * i + 0.5 * i + 0.5 , 0.5, _widthForForm, height)];
            smallViewForForm.tag = 500 + i;
            _btnForView = [UIButton buttonWithType:UIButtonTypeSystem];
            [_btnForView addTarget:self action:@selector(selectForFromView:) forControlEvents:UIControlEventTouchUpInside];
            _btnForView.frame = CGRectMake(0, 0, _widthForForm, height);
            _btnForView.tag = 600 + i;
            [smallViewForForm addSubview:_btnForView];
            
            
            
        }else if(i >= 4 && i <= 6 ){
            
            
            smallViewForForm = [[UIView alloc]initWithFrame:CGRectMake(3 * _widthForForm + 0.5 * 3 + 0.5,  0.5 + 0.5 * (i - 3) +height * (i - 3) , _widthForForm, height)];
            smallViewForForm.tag = 500 +i;
            _btnForView = [UIButton buttonWithType:UIButtonTypeSystem];
            [_btnForView addTarget:self action:@selector(selectForFromView:) forControlEvents:UIControlEventTouchUpInside];
            _btnForView.frame = CGRectMake(0, 0, _widthForForm, height);
            _btnForView.tag = 600 + i;
            [smallViewForForm addSubview:_btnForView];
            
            
        }else if(i > 6 && i <=9){
            
            
            smallViewForForm = [[UIView alloc]initWithFrame:CGRectMake((-(i - 9))*0.5 +0.5 + (-(i - 9)) * _widthForForm, 3 * height + 0.5 + 0.5*3, _widthForForm, height)];
            smallViewForForm.tag = 500 +i;
            _btnForView = [UIButton buttonWithType:UIButtonTypeSystem];
            [_btnForView addTarget:self action:@selector(selectForFromView:) forControlEvents:UIControlEventTouchUpInside];
            _btnForView.frame = CGRectMake(0, 0, _widthForForm, height);
            _btnForView.tag = 600 + i;
            [smallViewForForm addSubview:_btnForView];
            
            
        }else{
            
            
            smallViewForForm = [[UIView alloc]initWithFrame:CGRectMake(0.5, (-(i-12))*0.5+0.5+ (-(i-12)) * height, _widthForForm, height)];
            smallViewForForm.tag = 500 +i;
            _btnForView = [UIButton buttonWithType:UIButtonTypeSystem];
            [_btnForView addTarget:self action:@selector(selectForFromView:) forControlEvents:UIControlEventTouchUpInside];
            _btnForView.frame = CGRectMake(0, 0, _widthForForm, height);
            _btnForView.tag = 600 + i;
            [smallViewForForm addSubview:_btnForView];
            
        }
        
        
        [self addSubview:smallViewForForm];

        
    }
    
    /**
     *  创建线
     */
    for (int i = 0 ; i < 5; i++) {
        
        if (i == 2) {
            
            for (int j = 0; j < 2; j++) {
                
                if (j == 0) {
                    
                    lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 + i * 0.5 + height * i, _widthForForm, 0.5)];
                    verticalLineView = [[UIView alloc]initWithFrame:CGRectMake(0 + i * 0.5 + _widthForForm * i, 0, 0.5, 0.5 + height)];
                    
                }else{
                
                    lineView1 = [[UIView alloc]initWithFrame:CGRectMake(3 * 0.5 + 3 * _widthForForm, 0 + i * 0.5 + height * i, _widthForForm, 0.5)];
                    verticalLineView1 = [[UIView alloc]initWithFrame:CGRectMake(0 + i * 0.5 + _widthForForm * i, 3 * 0.5 + 3 * height, 0.5, height + 0.5)];
                    
                }

            }
            

            
        }else{
           
            lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 + i * 0.5 + height * i, kScreenWidth, 0.5)];
            verticalLineView = [[UIView alloc]initWithFrame:CGRectMake(0 + i * 0.5 + _widthForForm * i, 0, 0.5, heightForVline)];
        }
        
        lineView.backgroundColor = [UIColor purpleColor];
        lineView1.backgroundColor = [UIColor purpleColor];
        verticalLineView.backgroundColor = [UIColor purpleColor];
        verticalLineView1.backgroundColor = [UIColor purpleColor];
        [self addSubview:lineView];
        [self addSubview:lineView1];
        [self addSubview:verticalLineView];
        [self addSubview:verticalLineView1];
        
    }
    

}

/**
 *  创建宫对应字典,存储三方四证也在这里
 *
 *  @param dicForGong 
 */
- (void)setDicForGong:(NSDictionary *)dicForGong
{
    
    [_dicForAllStarandG removeAllObjects];
    [_dicForSanfangsizheng removeAllObjects];
    
    if (_dicForGong != dicForGong) {
        
        _dicForGong = dicForGong;
        
        //存储一下当前的宫:分开存储
        if (_isLiunian) {
            
            _dicForTianpanG = _dicForGong;

            
        }else{
        
            _dicForXiaoxianG = _dicForLN;

        }
        
    }
    
    
    dicForAllStar = [NSMutableDictionary dictionary];

    
    [self returnAllDic:dicForAllStar andNowDic:_dicForZiwei];
    [self returnAllDic:dicForAllStar andNowDic:_dicForTianfu];
    [self returnAllDic:dicForAllStar andNowDic:_dicForLucun];
    [self returnAllDic:dicForAllStar andNowDic:_dicForLiuji];
    [self returnAllDic:dicForAllStar andNowDic:_dicForTaohua];
    [self returnAllDic:dicForAllStar andNowDic:_dicForXunkong];
    [self returnAllDic:dicForAllStar andNowDic:_dicForChangsheng];
    [self returnAllDic:dicForAllStar andNowDic:_dicForSihua];
    [self returnAllDic:dicForAllStar andNowDic:_dicForZaxing];
    [self returnAllDic:dicForAllStar andNowDic:_dicForSuiqian];
    [self returnAllDic:dicForAllStar andNowDic:_dicFor12Shen];
    
   // _dicForGong = _dicForGong[@"巳"];
    
    //存储所有的View
    for (int i = 0; i < 12; i ++) {
        
        NSString *strForGong = _dicForGong[_arrForMingpan[i]];
        NSMutableArray *arrForSAN = [NSMutableArray array];
    
        NSInteger zhengHUI = i + 4;
        NSInteger daoHUI   = i - 4;
        NSInteger zhao = i + 6;
        
        if (zhao >= 12) {
            
            zhao = zhao - 12;
            
        }
        
        if (daoHUI < 0) {
            
            daoHUI = daoHUI + 12;
            
        }
        
        if (zhengHUI >= 12) {
            
            zhengHUI = zhengHUI - 12;
            
        }

        NSString *strForZhenghui = _dicForGong[_arrForMingpan[zhengHUI]];
        NSString *strForDaohui   = _dicForGong[_arrForMingpan[daoHUI]];
        NSString *strForZhao     = _dicForGong[_arrForMingpan[zhao]];
        
        [arrForSAN addObject:strForGong];
        [arrForSAN addObject:strForZhao];
        [arrForSAN addObject:strForZhenghui];
        [arrForSAN addObject:strForDaohui];
        
        /**
         *  存储三方四正的所有宫命
         */
        [_dicForSanfangsizheng setObject:arrForSAN forKey:strForGong];
        
        NSMutableArray *arrforstar = [self selectedAllStarAction:_arrForMingpan[i] andGongStr:strForGong];
        
        /**
         *  存储所有的宫对应所有的星耀
         */
        [_dicForAllStarandG setObject:arrforstar forKey:strForGong];
        
        
    }

    NSLog(@"123   :%@",_dicForAllStarandG[@"命宫"]);
    NSLog(@"234   :%@",_dicForSanfangsizheng[@"命宫"]);
    
}



/**
 *  选中所有星的工具方法
 *
 *  @param dizhiStr <#dizhiStr description#>
 */
- (NSMutableArray *)selectedAllStarAction:(NSString *)dizhiSTR
                               andGongStr:(NSString *)strForXiaoxianG
{
    //总的数组
    NSMutableArray *arrForGongStar = [NSMutableArray array];
    
    //存星的字典
    NSMutableDictionary *dicForXing = [NSMutableDictionary dictionary];
    //存星的数组
    NSMutableArray *arrForAls = [NSMutableArray array];
    
    //存大限的字典
    NSMutableDictionary *dicForDaxian = [NSMutableDictionary dictionary];

    
    //存长生的字典
    NSMutableDictionary *dicForChangsheng = [NSMutableDictionary dictionary];

    
    //存博士的字典
    NSMutableDictionary *dicForBoshi = [NSMutableDictionary dictionary];

    
    //生肖时辰的字典
    NSMutableDictionary *dicForShengxiao = [NSMutableDictionary dictionary];

    //小限的字典
    NSMutableDictionary *dicForXiaoxianN = [NSMutableDictionary dictionary];
    
    //存中间宫的字典
    NSMutableDictionary *dicForMingpanG = [NSMutableDictionary dictionary];
    
    /**
     *  中间命盘宫
     */
    NSString *strForGong = _dicForTianpanG[dizhiSTR];
    [dicForMingpanG setObject:strForGong forKey:strForXiaoxianG];
    
    
    /**
     *  放紫微星
     */
    int k = 0;

    
    for (int i = 0; i < _dicForZiwei.count; i++) {
        
        if ([_dicForZiwei[_dicForZiwei.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            NSString *Str;
            
            if ([_dicForZiwei.allKeys[i] length] == 3) {
                
                Str = _dicForZiwei.allKeys[i];
                
            }else{
                
                Str = [NSString stringWithFormat:@"%@\n\t",_dicForZiwei.allKeys[i]];
                
            }
            
            NSMutableAttributedString *strForZwei = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForZwei addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
            [strForZwei addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];

            [arrForAls addObject:strForZwei];
       
        }
        
    }
    
    /**
     *  放天府星
     */
    for (int i = 0 ; i < _dicForTianfu.count; i++) {
        
        if ([_dicForTianfu[_dicForTianfu.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            
            NSString *Str;
            
            if ([_dicForTianfu.allKeys[i] length] == 3) {
                
                Str = _dicForTianfu.allKeys[i];
                
            }else{
                
                Str = [NSString stringWithFormat:@"%@\n\t",_dicForTianfu.allKeys[i]];
                
            }
            
            NSMutableAttributedString *strForTianf = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForTianf addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
            [strForTianf addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];

            [arrForAls addObject:strForTianf];
        
        }
        
    }
    
    /**
     *  禄存星
     */
    for (int i = 0; i < _dicForLucun.count;i++ ){
        
        if ([_dicForLucun[_dicForLucun.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            
            NSString *Str;
            
            if ([_dicForLucun.allKeys[i] length] == 3) {
                
                Str = _dicForLucun.allKeys[i];
                
            }else{
                
                Str = [NSString stringWithFormat:@"%@\n\t",_dicForLucun.allKeys[i]];
            }
            
            NSMutableAttributedString *strForLucun = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForLucun addAttribute:NSForegroundColorAttributeName value:colorForBG range:NSMakeRange(0, 2)];
            [strForLucun addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
            

            
            [arrForAls addObject:strForLucun];

            
        }
        
    }
    
    /**
     *  六吉星
     */
    for (int i = 0; i < _dicForLiuji.count; i++) {
        
        if ([_dicForLiuji[_dicForLiuji.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            NSString *Str;
            if ([_dicForLiuji.allKeys[i] length] == 3) {
                
                Str = _dicForLiuji.allKeys[i];
                
            }else{
                
                Str = [NSString stringWithFormat:@"%@\n\t",_dicForLiuji.allKeys[i]];
            }
            
            
            NSMutableAttributedString *strForLiuji = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForLiuji addAttribute:NSForegroundColorAttributeName value:colorForBG range:NSMakeRange(0, 2)];
            [strForLiuji addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
 
            [arrForAls addObject:strForLiuji];

            
            
        }
        
    }
    
    /**
     *  四桃花星
     */
    for (int i = 0; i < _dicForTaohua.count; i++) {
        
        if ([_dicForTaohua[_dicForTaohua.allKeys[i]] isEqualToString:dizhiSTR]) {
            

            NSString *Str = [NSString stringWithFormat:@"%@\n\t",_dicForTaohua.allKeys[i]];
            
            NSMutableAttributedString *strForTaohua = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForTaohua addAttribute:NSForegroundColorAttributeName value:colorForQian range:NSMakeRange(0, 2)];
            [strForTaohua addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
            

            [arrForAls addObject:strForTaohua];

        }
        
    }
    
    /**
     *旬空星
     */
    for (int i = 0 ; i < _dicForXunkong.count; i++) {
        
        if ([_dicForXunkong[_dicForXunkong.allKeys[i]] isEqualToString:dizhiSTR]) {
        
            NSString *Str = [NSString stringWithFormat:@"%@\n\t",_dicForXunkong.allKeys[i]];
            NSMutableAttributedString *strForXun = [[NSMutableAttributedString alloc] initWithString:Str];
            [strForXun addAttribute:NSForegroundColorAttributeName value:colorForQian range:NSMakeRange(0, 2)];
            
            [arrForAls addObject:strForXun];

           
        }
        
    }
    

    
    /**
     *  中间的大限
     */
    
    NSString *strForDaxian = dicForDaxianD[dizhiSTR];
    [dicForDaxian setObject:strForDaxian forKey:@"大限"];
   
    NSString *strForXiaoxian = _dicForXiaoxian[dizhiSTR];
    [dicForXiaoxianN setObject:strForXiaoxian forKey:@"小限"];
    
    /**
     *  天干和地支
     */
    
    NSString *tianganDizhi = [NSString stringWithFormat:@"%@%@",_tianganDic[dizhiSTR],dizhiSTR];
    [dicForShengxiao setObject:tianganDizhi forKey:@"生肖"];

    
    /**
     * 博士
     */

    for (int i = 0; i < _dicFor12Shen.count; i++) {
        
        if ([_dicFor12Shen[_dicFor12Shen.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            NSString *strForBoshi = _dicFor12Shen.allKeys[i];
          
            [dicForBoshi setObject:strForBoshi forKey:@"博士"];

            
        }
        
    }
    
    
    /**
     *  长生12神
     */

    for (int i = 0; i < _dicForChangsheng.count; i++) {
        
        if ([_dicForChangsheng[_dicForChangsheng.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            NSString *strForChangsheng = _dicForChangsheng.allKeys[i];
         
            [dicForChangsheng setObject:strForChangsheng forKey:@"长生"];

            
        }
        
    }
    
    
    
    /**
     *  最多显示7个
     */
    if (k > 7) {
        
        return arrForGongStar;
    }
    
    /**
     *  杂星
     */
    for (int i = 0; i < _dicForZaxing.count; i++) {
        
        
        if (k >= 7) {
            
            return arrForGongStar;
        }
        
        if ([_dicForZaxing[_dicForZaxing.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            
            
            NSString *Str = [NSString stringWithFormat:@"%@\n\t",_dicForZaxing.allKeys[i]];
            NSMutableAttributedString *strForZa = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForZa addAttribute:NSForegroundColorAttributeName value:colorForQian range:NSMakeRange(0, 2)];
         
            [arrForAls addObject:strForZa];
        }
        
    }
    
    /**
     *  岁前星
     */
    for (int i = 0; i < _dicForSuiqian.count; i++) {
        
        
        if (k >= 7) {
            
            return arrForGongStar;
        }
        
        if ([_dicForSuiqian[_dicForSuiqian.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            
            
            NSString *Str = [NSString stringWithFormat:@"%@\n\t",_dicForSuiqian.allKeys[i]];
            NSMutableAttributedString *strForSui = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForSui addAttribute:NSForegroundColorAttributeName value:colorForQian range:NSMakeRange(0, 2)];
            
            [arrForAls addObject:strForSui];
        }
        
    }
    
    
    [dicForXing setObject:arrForAls forKey:@"星"];
    
    
    [arrForGongStar addObject:dicForXing];
    [arrForGongStar addObject:dicForDaxian];
    [arrForGongStar addObject:dicForChangsheng];
    [arrForGongStar addObject:dicForBoshi];
    [arrForGongStar addObject:dicForShengxiao];
    [arrForGongStar addObject:dicForXiaoxianN];
    [arrForGongStar addObject:dicForMingpanG];
    
    return arrForGongStar;

}


/**
 *  三方线
 *
 *  @param minggongIndex
 */
- (void)creatSanfangsizheng:(NSInteger )minggongIndex
{
   
    


    NSString *sanfangName = _arrForSanfangsizheng[minggongIndex];
    
    UIImageView *imageForSanfang = [[UIImageView alloc]initWithFrame:CGRectMake(_widthForForm + 0.5, 0.5 + _heightForForm, 2 * _widthForForm + 0.5 * 3, 2 * _heightForForm + 0.5 * 3)];
    imageForSanfang.image = [UIImage imageNamed:sanfangName];
    
    [self insertSubview:imageForSanfang atIndex:0];
    
    [_arrForImage addObject:imageForSanfang];
    
    
}

/**
 *  创建各个宫位
 */
- (void)setIndexForMingGong:(NSInteger)indexForMingGong
{

    CGFloat width = (kScreenWidth - 5 * 0.5) / 4.0;
    
    /**
     *  第一次进入肯定不是流年盘，所以走天盘的命宫创建整个盘，之后再次进入_isLiunnian = yes;然后命宫走的是流年的命宫位置
     */
    if (_isLiunian) {
        
        //创建命宫的同时出中间的图
        [self creatSanfangsizheng:indexForMingGong];
        
        _indexForMingGong = indexForMingGong;
        
        //记录下命宫的Index ，起大限用
        _minggongIndex = _indexForMingGong;
        
        _mingDZ = _arrForMingpan[_indexForMingGong];
        
        
        for (int i = 0; i < 12; i++) {
            
            if (i <= _indexForMingGong) {
                
                UIView *viewForGong = [self viewWithTag:_indexForMingGong - i + 500];
                
                UILabel *xiaoxianGong = [[UILabel alloc]initWithFrame:CGRectMake(0, yForGongLiunian, width , heightForGongLiunian)];
                xiaoxianGong.text = _arrForLiunian[i];
                //      labelForGong.backgroundColor = [UIColor orangeColor];
                xiaoxianGong.textAlignment = NSTextAlignmentCenter;
                xiaoxianGong.font = _bigFont;
                [viewForGong addSubview:xiaoxianGong];
                [_dicForLN setObject:_arrForLiunian[i] forKey:_arrForMingpan[_indexForMingGong - i]];
                [_arrForALLgong addObject:xiaoxianGong];
                
            }else{
                
                UIView *viewForGong = [self viewWithTag:i + 500];
                
                UILabel *xiaoxianGong = [[UILabel alloc]initWithFrame:CGRectMake(0, yForGongLiunian, width, heightForGongLiunian)];
                xiaoxianGong.text = _arrForLiunian[12 - (i - _indexForMingGong)];//倒着取出来，因为挨着命宫的是最后一个宫
                //        labelForGong.backgroundColor = [UIColor orangeColor];
                xiaoxianGong.textAlignment = NSTextAlignmentCenter;
                xiaoxianGong.font = _bigFont;
                
                [_dicForLN setObject:_arrForLiunian[12 - (i - _indexForMingGong)] forKey:_arrForMingpan[i]];

                [viewForGong addSubview:xiaoxianGong];
                
                [_arrForALLgong addObject:xiaoxianGong];
                
                
            }
            
        }
        
        _isLiunian = NO;
        
    }else{
    
        //创建命宫的同时出中间的图
        [self creatSanfangsizheng:indexForMingGong];
        
        _indexForMingGong = indexForMingGong;
        
        //记录下命宫的Index ，起大限用
        _minggongIndex = _indexForMingGong;
        
        _mingDZ = _arrForMingpan[_indexForMingGong];
        
        for (int i = 0; i < 12; i++) {
            
            if (i <= _indexForMingGong) {
                
                UIView *viewForGong = [self viewWithTag:_indexForMingGong - i + 500];
                
                UILabel *mingpanGong = [[UILabel alloc]initWithFrame:CGRectMake((_widthForForm - widthForGongSmall) / 2.0 , yForGongSmall , widthForGongSmall, heightForGongSmall)];
                mingpanGong.text = _arrForAllGong[i];
                      mingpanGong.backgroundColor = colorForAll;
                mingpanGong.textAlignment = NSTextAlignmentCenter;
                mingpanGong.font = _bigFont;
                mingpanGong.textColor = [UIColor whiteColor];
                mingpanGong.layer.cornerRadius = 6;
                mingpanGong.layer.masksToBounds = YES;
                [viewForGong addSubview:mingpanGong];
                
                [_arrForALLgong addObject:mingpanGong];
                
            }else{
                
                UIView *viewForGong = [self viewWithTag:i + 500];
                
                UILabel *mingpanGong = [[UILabel alloc]initWithFrame:CGRectMake( (_widthForForm - widthForGongSmall) / 2.0 , yForGongSmall , widthForGongSmall, heightForGongSmall)];
                mingpanGong.text = _arrForAllGong[12 - (i - _indexForMingGong)];//倒着取出来，因为挨着命宫的是最后一个宫
                mingpanGong.backgroundColor = colorForAll;
                mingpanGong.textAlignment = NSTextAlignmentCenter;
                mingpanGong.font = _bigFont;
                mingpanGong.layer.cornerRadius = 6;
                mingpanGong.layer.masksToBounds = YES;
                mingpanGong.textColor = [UIColor whiteColor];
                
                [viewForGong addSubview:mingpanGong];
                
                [_arrForALLgong addObject:mingpanGong];
                
                
            }
            
        }
        

        
        _isLiunian = YES;
    }
    
    
    
  

}


/**
 *  起大限
 */

- (void)setDaxianArray:(NSArray *)daxianArray
{
    
    CGFloat width = (kScreenWidth - 5 * 0.5) / 4.0;

    
    if (_daxianArray != daxianArray) {
        
        _daxianArray = daxianArray;
        
        
        for (int i = 0; i < 12; i++) {
            
            NSString *changshengBegin = _arrForMingpan[i];
            
            //阳男阴女顺时针  ， 阴男阳女逆时针
            if ([_yinyang isEqualToString:@"阳男"] || [_yinyang isEqualToString:@"阴女"]) {
                
                /**
                 *  算大限
                 */
                if ([changshengBegin isEqualToString:_mingDZ]) {
                    
                    
                    /**
                     *  算大限
                     */
                    
                    
                    for (int j = 0; j < 12; j++) {
                        
                        if (j < i) {
                            
                            UIView *changshenView12 = [self viewWithTag:j + 500];
                            UILabel *daxianLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, yForDaxian, width , heightForGongLiunian)];
                            daxianLabel.text = _daxianArray[12 - (i - j)];
                            //存大限
                            [dicForDaxianD setObject:_daxianArray[12 - (i - j)] forKey:_arrForMingpan[j]];
                            
                            daxianLabel.font = [UIFont systemFontOfSize:12];
                       //     daxianLabel.backgroundColor = [UIColor cyanColor];
                            daxianLabel.textAlignment = NSTextAlignmentCenter;
                            [changshenView12 addSubview:daxianLabel];
                        }else{
                            
                            UIView *changshenView12 = [self viewWithTag:j + 500];
                            UILabel *daxianLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, yForDaxian, width , heightForGongLiunian)];
                            daxianLabel.text = _daxianArray[(j - i)];
                            //存大限
                            [dicForDaxianD setObject:_daxianArray[(j - i)] forKey:_arrForMingpan[j]];
                            
                            daxianLabel.font = [UIFont systemFontOfSize:12];
                      //      daxianLabel.backgroundColor = [UIColor cyanColor];
                            daxianLabel.textAlignment = NSTextAlignmentCenter;
                            [changshenView12 addSubview:daxianLabel];
                            
                            
                        }
                        
                    }
                    
                }
                

                
                
            }else{
                
                
                if ([changshengBegin isEqualToString:_mingDZ]) {
                    
                    /**
                     *  算大限
                     */
                    
                    for (int j = 0 ; j < 12; j++) {
                        
                        if (j<=i) {
                            
                            UIView *changshenView12 = [self viewWithTag:i - j + 500];
                            
                            UILabel *daxianLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, yForDaxian, width , heightForGongLiunian)];
                            daxianLabel.text = _daxianArray[j];
                            
                            //存大限
                            [dicForDaxianD setObject:_daxianArray[j] forKey:_arrForMingpan[i - j]];
                            
                            daxianLabel.font = [UIFont systemFontOfSize:12];
                           // daxianLabel.backgroundColor = [UIColor cyanColor];
                            daxianLabel.textAlignment = NSTextAlignmentCenter;
                            [changshenView12 addSubview:daxianLabel];
                            
                        }else{
                            
                            UIView *changshenView12 = [self viewWithTag:12 - (j - i) + 500];
                            UILabel *daxianLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, yForDaxian, width , heightForGongLiunian)];
                            daxianLabel.text = _daxianArray[j];
                            
                            //存大限
                            [dicForDaxianD setObject:_daxianArray[j] forKey:_arrForMingpan[12 - (j - i)]];
                            daxianLabel.font = [UIFont systemFontOfSize:12];
                      //      daxianLabel.backgroundColor = [UIColor cyanColor];
                            daxianLabel.textAlignment = NSTextAlignmentCenter;
                            [changshenView12 addSubview:daxianLabel];
                            
                            
                        }
                        
                    }
                    
                    
                }
                
               
                
            }
            
            
        }
        
        
    }

}


/**
 *  安博12神
 */
- (void)setDicFor12Shen:(NSDictionary *)dicFor12Shen
{
   
    if (_dicFor12Shen != dicFor12Shen) {
        
        _dicFor12Shen = dicFor12Shen;
        
        for (int i = 0; i < 12; i++) {
            
            int k = 0;
            
            for (int j = 0; j < _dicFor12Shen.count; j++) {
                
                if ([_dicFor12Shen[_dicFor12Shen.allKeys[j]] isEqualToString:_arrForMingpan[i]] ) {
                    
                    UIView *view123 = [self viewWithTag:i + 500];
                    
                    UILabel *labelForxing = [[UILabel alloc]initWithFrame:CGRectMake(xForAnbo,yForAnbo, 15, heightForAnbo)];
                    labelForxing.text = _dicFor12Shen.allKeys[j];
                    labelForxing.numberOfLines = 0;
                    [view123 addSubview:labelForxing];
                  //  labelForxing.backgroundColor = [UIColor orangeColor];
                    labelForxing.textAlignment = NSTextAlignmentCenter;
                    labelForxing.textColor = colorForQian;
                    labelForxing.font = _anboFont;
                    [labelForxing sizeThatFits:CGSizeMake(15, heightForAnbo)];
                    k++;
                    
                }
                
            }
            
        }
        
}
        
    }


//--------------------------------------------选中的一些方法-----------------------------------------//

/**
 *  返回一个表格所对应的所有星星的数组
 *
 *  @param dicForStar 星星字典
 *  @param dizhiSTR   所对应的生肖
 *
 *  @return 返回一个存生肖的字典
 */
- (NSArray *)returnArrForStar:(NSDictionary *)dicForStar
                     andDizhi:(NSString *)dizhiSTR
{

 
    return nil;
}

/**
 *  选中表格的方法
 *
 *  @param sender
 */
- (void)selectForFromView:(UIButton *)sender
{
    /**
     *  存储所有的星星
     */


    
    if (sender.tag == siForView) {
        
        NSLog(@"选中巳了");

        [self changeTheSelectedViewWithTag:0 withDizhiSTR:@"巳"];
        
        
        
    }else if(sender.tag == wuForView){
    
        NSLog(@"选中了午");
        
        
        [self changeTheSelectedViewWithTag:1 withDizhiSTR:@"午"];


        
    }else if(sender.tag == weiForView){
    
        NSLog(@"选中了未");
        
        [self changeTheSelectedViewWithTag:2 withDizhiSTR:@"未"];

        
    }else if(sender.tag == shenForView){
    
        
        [self changeTheSelectedViewWithTag:3 withDizhiSTR:@"申"];

        NSLog(@"选中了申");
    }else if(sender.tag == youForView){
    
        [self changeTheSelectedViewWithTag:4 withDizhiSTR:@"酉"];

        NSLog(@"选中了酉");
    }else if(sender.tag == xuForView){
    
        [self changeTheSelectedViewWithTag:5 withDizhiSTR:@"戌"];

        NSLog(@"选中了戌");
    }else if(sender.tag == haiForView){
    
        [self changeTheSelectedViewWithTag:6 withDizhiSTR:@"亥"];

        NSLog(@"选中了亥");
    }else if(sender.tag == ziForView){
    
        [self changeTheSelectedViewWithTag:7 withDizhiSTR:@"子"];

        NSLog(@"选中了子");
    }else if(sender.tag == chouForView){
    
        [self changeTheSelectedViewWithTag:8 withDizhiSTR:@"丑"];

        NSLog(@"选中了丑");
    }else if(sender.tag == yinForView){
    
        [self changeTheSelectedViewWithTag:9 withDizhiSTR:@"寅"];

        NSLog(@"选中了寅");
    }else if(sender.tag == maoForView){
    
        [self changeTheSelectedViewWithTag:10 withDizhiSTR:@"卯"];

        NSLog(@"选中了卯");
    }else{
    
        [self changeTheSelectedViewWithTag:11 withDizhiSTR:@"辰"];

        NSLog(@"选中了辰");
    }

}

/**
 *  选中View的方法
 *
 *  @param tagForView 选中的View tag值
 */
- (void)changeTheSelectedViewWithTag:(NSInteger )tagForView
                        withDizhiSTR:(NSString *)dizhiSTR
{
    _name.hidden = YES;
    _nameText.hidden = YES;
    _age.hidden = YES;
    _ageText.hidden = YES;
    _yangli.hidden = YES;
    _yangliText.hidden = YES;
    _yinliText.hidden = YES;
    _yinli.hidden = YES;
    _panlei.hidden = YES;
    _panleiText.hidden = YES;
    _mingju.hidden = YES;
    _mingjuText.hidden = YES;
    _mingzhu.hidden = YES;
    _mingzhuText.hidden = YES;
    _shenzhu.hidden = YES;
    _shenzhuText.hidden = YES;
    _ziniandoujun.hidden = YES;
    _ziniandoujunText.hidden = YES;
    //_jiepanBTN.hidden = YES;
    
    for (int i = 0; i < _arrForImage.count; i++) {
        
        UIImageView *imageV = _arrForImage[i];
        
        [imageV removeFromSuperview];
        
    }
    
    
    [_arrForImage removeAllObjects];
    
    
    NSLog(@"%@",_dicForXiaoxian[dizhiSTR]);
    
    _indexForSelectedGong = tagForView + 500;
    
    //选中后背景颜色
    for (int i = 0; i < 12; i++) {
        
        UIView *selectedView = [self viewWithTag:i + 500];
        
        if (i + 500 == tagForView + 500) {
            
            selectedView.backgroundColor = [UIColor colorWithRed:241 / 255.0   green:223 / 255.0 blue:199 / 255.0 alpha:1.000];

            
        }else{
           
            selectedView.backgroundColor = [UIColor clearColor];
        }
        
    }
    
    //创建中间的view
    [self creatNewMidleViewWithDizhiStr:dizhiSTR];

    
    UIImageView *imageForSanfang = [[UIImageView alloc]initWithFrame:CGRectMake(_widthForForm + 0.5, 0.5 + _heightForForm, 2 * _widthForForm + 0.5 * 3, 2 * _heightForForm + 0.5 * 3)];
    //选中后中间图片改变
    NSString *str123123321 = [NSString stringWithFormat:@"0%ld",tagForView + 1];
    imageForSanfang.image = [UIImage imageNamed:str123123321];
    
//     UILabel *labelForXiaoxian = [[UILabel alloc]initWithFrame:CGRectMake(15, imageForSanfang.height - 20, _widthForForm * 2, 20)];
//    labelForXiaoxian.font = [UIFont systemFontOfSize:10];
//    labelForXiaoxian.text = _dicForXiaoxian[dizhiSTR];
    [self addSubview:imageForSanfang];
//    [imageForSanfang addSubview:labelForXiaoxian];

    
    [_arrForImage addObject:imageForSanfang];



  }


/**
 *  创建中间的label
 *
 *  @param dizhiSTR 当前地支
 */
- (void)creatNewMidleViewWithDizhiStr:(NSString *)dizhiSTR

{
   //删除之前所有的星
    [self removeAllStarAction];
    
    
    /**
     *  放紫微星
     */
    int k = 0;
    
    for (int i = 0; i < _dicForZiwei.count; i++) {
        
        if ([_dicForZiwei[_dicForZiwei.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            NSString *Str;
            
            if ([_dicForZiwei.allKeys[i] length] == 3) {
                
                Str = _dicForZiwei.allKeys[i];
                
            }else{
               
                Str = [NSString stringWithFormat:@"%@\n",_dicForZiwei.allKeys[i]];
                
            }
            
            NSMutableAttributedString *strForZwei = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForZwei addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
            [strForZwei addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
            
            
            labelForZiwei = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - _widthForStarBig - _widthForForm, yForMiddleStar , _widthForStarBig, _heightForStarBig)];
            labelForZiwei.attributedText = strForZwei;
           // labelForZiwei.backgroundColor = [UIColor orangeColor];
            labelForZiwei.numberOfLines = 0;
            labelForZiwei.textAlignment = NSTextAlignmentCenter;
            labelForZiwei.font = _middleStarFont;
            [self addSubview:labelForZiwei];
            
            k++;
            
        }
        
    }

    /**
     *  放天府星
     */
    for (int i = 0 ; i < _dicForTianfu.count; i++) {
        
        if ([_dicForTianfu[_dicForTianfu.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            
            NSString *Str;
            
            if ([_dicForTianfu.allKeys[i] length] == 3) {
                
                Str = _dicForTianfu.allKeys[i];
                
            }else{
                
                Str = [NSString stringWithFormat:@"%@\n",_dicForTianfu.allKeys[i]];
                
            }
            
            NSMutableAttributedString *strForZwei = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForZwei addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
            [strForZwei addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
        
            labelForTianfu = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - _widthForStarBig - _widthForForm - k * (_widthForStarBig + 5), yForMiddleStar, _widthForStarBig, _heightForStarBig)];
            labelForTianfu.attributedText = strForZwei;
            //labelForTianfu.backgroundColor = [UIColor yellowColor];
            labelForTianfu.numberOfLines = 0;
            labelForTianfu.textAlignment = NSTextAlignmentCenter;
            labelForTianfu.font = _middleStarFont;
            [self addSubview:labelForTianfu];
            
            k++;
        }
        
    }

    /**
     *  禄存星
     */
    for (int i = 0; i < _dicForLucun.count;i++ ){

            if ([_dicForLucun[_dicForLucun.allKeys[i]] isEqualToString:dizhiSTR]) {
                
                
                NSString *Str;
                
                if ([_dicForLucun.allKeys[i] length] == 3) {
                    
                    Str = _dicForLucun.allKeys[i];
                    
                }else{
 
                    Str = [NSString stringWithFormat:@"%@\n",_dicForLucun.allKeys[i]];
                }
                
                NSMutableAttributedString *strForLucun = [[NSMutableAttributedString alloc]initWithString:Str];
                [strForLucun addAttribute:NSForegroundColorAttributeName value:colorForBG range:NSMakeRange(0, 2)];
                [strForLucun addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
                
                
                labelForLucun = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - _widthForStarBig - _widthForForm - k * (_widthForStarBig + 5), yForMiddleStar , _widthForStarBig, _heightForStarBig)];
                labelForLucun.attributedText = strForLucun;
               // labelForLucun.backgroundColor = [UIColor cyanColor];
                labelForLucun.tag = 1900 + i;
                labelForLucun.numberOfLines = 0;
                labelForLucun.textAlignment = NSTextAlignmentCenter;
                labelForLucun.font = _middleStarFont;
                [self addSubview:labelForLucun];
                
                k++;
                
            
        }

    }
    
    /**
     *  六吉星
     */
    for (int i = 0; i < _dicForLiuji.count; i++) {
        
        if ([_dicForLiuji[_dicForLiuji.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            NSString *Str;
            if ([_dicForLiuji.allKeys[i] length] == 3) {
                
                Str = _dicForLiuji.allKeys[i];
                
            }else{
                
                Str = [NSString stringWithFormat:@"%@\n",_dicForLiuji.allKeys[i]];
            }
            
            
            NSMutableAttributedString *strForLiuji = [[NSMutableAttributedString alloc]initWithString:Str];
            [strForLiuji addAttribute:NSForegroundColorAttributeName value:colorForBG range:NSMakeRange(0, 2)];
            [strForLiuji addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
            
            labelForLiuji = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - _widthForStarBig - _widthForForm - k * (_widthForStarBig + 5), yForMiddleStar , _widthForStarBig, _heightForStarBig)];
            labelForLiuji.attributedText = strForLiuji;
            labelForLiuji.tag = 2000 + i;
            labelForLiuji.numberOfLines = 0;
            labelForLiuji.textAlignment = NSTextAlignmentCenter;
            labelForLiuji.font = _middleStarFont;
            [self addSubview:labelForLiuji];
            
            k++;
        }
        
    }
    
    /**
     *  四桃花星
     */
    for (int i = 0; i < _dicForTaohua.count; i++) {
        
        if ([_dicForTaohua[_dicForTaohua.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            labelForTaohua = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - _widthForStarBig - _widthForForm - k * (_widthForStarBig + 5), yForMiddleStar, _widthForStarBig, _heightForStarBig)];
              NSString *Str = [NSString stringWithFormat:@"%@\n",_dicForTaohua.allKeys[i]];
            labelForTaohua.text = Str;
            //labelForTaohua.backgroundColor = [UIColor colorWithRed:1.000 green:0.487 blue:0.908 alpha:1.000];
            labelForTaohua.tag = 2100 + i;
            labelForTaohua.numberOfLines = 0;
            labelForTaohua.textColor = colorForQian;
            labelForTaohua.textAlignment = NSTextAlignmentCenter;
            labelForTaohua.font = _middleStarFont;
            [self addSubview:labelForTaohua];
            
            k++;
        }
        
    }
    
    /**
     *旬空星
     */
    for (int i = 0 ; i < _dicForXunkong.count; i++) {
        
        if ([_dicForXunkong[_dicForXunkong.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            labelForXunkong = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - _widthForStarBig - _widthForForm - k * (_widthForStarBig + 5), yForMiddleStar, _widthForStarBig, _heightForStarBig)];
            NSString *Str = [NSString stringWithFormat:@"%@\n",_dicForXunkong.allKeys[i]];
            labelForXunkong.text = Str;
          //  labelForTaohua.backgroundColor = [UIColor colorWithRed:1.000 green:0.487 blue:0.908 alpha:1.000];
            labelForXunkong.tag = 2100 + i;
            labelForXunkong.numberOfLines = 0;
            labelForXunkong.textColor = colorForQian;
            labelForXunkong.textAlignment = NSTextAlignmentCenter;
            labelForXunkong.font = _middleStarFont;
            [self addSubview:labelForXunkong];
            
            k++;
        }
        
    }
    
    
    /**
     *  中间的宫：流年盘
     */
    labelForGongXiaoxian = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2.0 - _widthForBigGong / 2.0, yForMiddleXiaoxian, _widthForBigGong, 30)];
    labelForGongXiaoxian.text = _dicForXiaoxianG[dizhiSTR];
    //   labelForGong.backgroundColor = [UIColor cyanColor];
    labelForGongXiaoxian.font = _middleStarFont;
    labelForGongXiaoxian.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labelForGongXiaoxian];
    
    /**
     *  中间的宫:天盘
     */
    labelForGong = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2.0 - widthForMiddleXiaoxian / 2.0,labelForGongXiaoxian.bottom , widthForMiddleXiaoxian, heightForMiddleXiaoxian)];
    labelForGong.text = _dicForTianpanG[dizhiSTR];
    labelForGong.textColor = [UIColor whiteColor];
    labelForGong.backgroundColor = colorForBG;
    labelForGong.layer.cornerRadius = _forMiddle;
    labelForGong.layer.masksToBounds = YES;
    labelForGong.font = _middleStarFont;
    labelForGong.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:labelForGong];
    

    
    /**
     *  中间的大限
     */
    labelForDaxian = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2.0 - _widthForBigDaxian / 2.0, labelForGong.bottom + 1 , _widthForBigDaxian, 20)];
    labelForDaxian.text = dicForDaxianD[dizhiSTR];
    labelForDaxian.textColor = [UIColor blackColor];
    labelForDaxian.font = [UIFont boldSystemFontOfSize:14];
  //  labelForDaxian.backgroundColor = [UIColor orangeColor];
    labelForDaxian.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labelForDaxian];
    
    /**
     中间的小限
     */
    _labelForXiaoxian.text = _dicForXiaoxian[dizhiSTR];
    
    /**
     *  天干和地支
     */
    labelForTianganAndDizhi = [[UILabel alloc]initWithFrame:CGRectMake(labelForGong.right + 17, yForTiangandizhi, 15, 45)];
    NSString *tianganDizhi = [NSString stringWithFormat:@"%@%@",_tianganDic[dizhiSTR],dizhiSTR];
    labelForTianganAndDizhi.text = tianganDizhi;
    labelForTianganAndDizhi.numberOfLines = 0;
    labelForTianganAndDizhi.textColor = colorForQian;
    //labelForTianganAndDizhi.backgroundColor = [UIColor cyanColor];
    labelForTianganAndDizhi.font = _bigFont;
    labelForTianganAndDizhi.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labelForTianganAndDizhi];
    
    /**
     * 博士
     */
    labelForBoshi = [[UILabel alloc]initWithFrame:CGRectMake(labelForGong.left - 15 - 17, yForTiangandizhi , 15, 45)];
    for (int i = 0; i < _dicFor12Shen.count; i++) {
        
        if ([_dicFor12Shen[_dicFor12Shen.allKeys[i]] isEqualToString:dizhiSTR]) {
   
            
            labelForBoshi.text = _dicFor12Shen.allKeys[i];
       //     labelForBoshi.backgroundColor = [UIColor cyanColor];
            labelForBoshi.numberOfLines = 0;
            labelForBoshi.textColor = colorForQian;
            labelForBoshi.textAlignment = NSTextAlignmentCenter;
            labelForBoshi.font = _bigFont;
            [self addSubview:labelForBoshi];
            
        
        }

    }
    
    
    /**
     *  长生12神
     */
    labelForChangsheng = [[UILabel alloc] initWithFrame:CGRectMake(labelForGong.right + 5, labelForTianganAndDizhi.bottom + 5, _widthForTiangandizhi, 20)];
    for (int i = 0; i < _dicForChangsheng.count; i++) {
        
        if ([_dicForChangsheng[_dicForChangsheng.allKeys[i]] isEqualToString:dizhiSTR]) {

          //  labelForChangsheng.text = _dicForChangsheng.allKeys[i];
         //   labelForChangsheng.backgroundColor = [UIColor cyanColor];
            labelForChangsheng.numberOfLines = 0;
            labelForChangsheng.textColor = [UIColor blackColor];
            labelForChangsheng.textAlignment = NSTextAlignmentCenter;
            labelForChangsheng.font = _bigFont;
            [self addSubview:labelForChangsheng];
            
            
        }
        
    }
    
    
    
    /**
     *  最多显示7个
     */
    if (k > 7) {
        
        return;
    }
    
    /**
     *  杂星
     */
    for (int i = 0; i < _dicForZaxing.count; i++) {
        
        
        if (k >= 7) {
            
            return;
        }
        
        if ([_dicForZaxing[_dicForZaxing.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            labelForZaxing = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - _widthForStarBig - _widthForForm - k * (_widthForStarBig + 5), yForMiddleStar, _widthForStarBig, _heightForStarBig)];
            
            NSString *Str = [NSString stringWithFormat:@"%@\n",_dicForZaxing.allKeys[i]];
            
            labelForZaxing.text = Str;
         //   labelForZaxing.backgroundColor = [UIColor magentaColor];
            labelForZaxing.tag = 2200 + i;
            labelForZaxing.numberOfLines = 0;
            labelForZaxing.textColor = colorForQian;
            labelForZaxing.textAlignment = NSTextAlignmentCenter;
            labelForZaxing.font = _middleStarFont;
            [self addSubview:labelForZaxing];
            
            k++;
        }
        
    }
    
    /**
     *  岁前星
     */
    for (int i = 0; i < _dicForSuiqian.count; i++) {
        
        
        if (k >= 7) {
            
            return;
        }
        
        if ([_dicForSuiqian[_dicForSuiqian.allKeys[i]] isEqualToString:dizhiSTR]) {
            
            labelForSuiqian = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - _widthForStarBig - _widthForForm - k * (_widthForStarBig + 5), yForMiddleStar, _widthForStarBig, _heightForStarBig)];
            
            NSString *Str = [NSString stringWithFormat:@"%@\n",_dicForSuiqian.allKeys[i]];
            
            labelForSuiqian.text = Str;
            labelForSuiqian.textAlignment = NSTextAlignmentLeft;
         //   labelForSuiqian.backgroundColor = [UIColor magentaColor];
            labelForSuiqian.tag = 2300 + i;
            labelForSuiqian.numberOfLines = 0;
            labelForSuiqian.textColor = colorForQian;
            labelForSuiqian.textAlignment = NSTextAlignmentCenter;
            labelForSuiqian.font = _middleStarFont;
            [self addSubview:labelForSuiqian];
            
            k++;
        }
        
    }
    
}


/**
 *  算添加小限
 *
 *  @param dicForXiaoxian
 */
- (void)setDicForXiaoxian:(NSDictionary *)dicForXiaoxian
{
   
    if (_dicForXiaoxian != dicForXiaoxian) {
        
        
        _dicForXiaoxian = dicForXiaoxian;
    }
    
    _labelForXiaoxian.text = _dicForXiaoxian[_arrForMingpan[_indexForMingGong]];
 
}


/**
 *  工具方法，删除所有星
 */
- (void)removeAllStarAction
{

    [labelForZiwei removeFromSuperview];
    [labelForTianfu removeFromSuperview];
    [labelForGong removeFromSuperview];
    [labelForGongXiaoxian removeFromSuperview];
    [labelForDaxian removeFromSuperview];
    [labelForTianganAndDizhi removeFromSuperview];
    [labelForBoshi removeFromSuperview];
    [labelForChangsheng removeFromSuperview];
    [labelForXunkong removeFromSuperview];
    //删除之前的禄存星
    for (int i = 0; i < _dicForLucun.count; i++) {
        
        UILabel *lucunLabel = (UILabel *)[self viewWithTag:1900 + i];
        
        [lucunLabel removeFromSuperview];
        
    }
    //删除之前的刘吉星
    for (int i = 0; i < _dicForLiuji.count; i++) {
        
        UILabel *label = (UILabel *)[self viewWithTag:2000 + i];
        
        [label removeFromSuperview];
        
    }
    //删除之前的四桃花,天马，天刑
    for (int i = 0; i < _dicForTaohua.count; i++) {
        
        UILabel *label = (UILabel *)[self viewWithTag:2100 + i];
        
        [label removeFromSuperview];
        
    }
    //删除之前的杂星
    for (int i = 0; i < _dicForZaxing.count; i++) {
        
        UILabel *label = (UILabel *)[self viewWithTag:2200 + i];
        [label removeFromSuperview];
        
    }
    //删除之前的岁星
    for (int i = 0; i < _dicForSuiqian.count; i++) {
        
        UILabel *label = (UILabel *)[self viewWithTag:2300 + i];
        [label removeFromSuperview];
    }
    
    

}




@end
