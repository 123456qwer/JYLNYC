//
//  PanView.h
//  ziweidoushu
//
//  Created by 吴冬 on 15/7/6.
//  Copyright (c) 2015年 吴冬. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PanView;
@protocol panDelegate <NSObject>

- (void)pushJiepanView;

@end


@interface PanView : UIView

//枚举,选中的View所对应的tag
typedef NS_ENUM(NSInteger, FormView){

    siForView = 600,
    wuForView = 601,
    weiForView = 602,
    shenForView = 603,
    youForView = 604,
    xuForView = 605,
    haiForView = 606,
    ziForView = 607,
    chouForView = 608,
    yinForView = 609,
    maoForView = 610,
    chenForView = 601,


};

@property (nonatomic ,strong)UILabel *ageText;      //年龄
@property (nonatomic ,strong)UILabel *nameText;     //名字
@property (nonatomic ,strong)UILabel *panleiText;   //盘类
@property (nonatomic ,strong)UILabel *mingjuText;   //五行局
@property (nonatomic ,strong)UILabel *mingzhuText;  //命主
@property (nonatomic ,strong)UILabel *ziniandoujunText; //子年斗君

@property (nonatomic ,strong)UILabel *shenzhuText; //身主
@property (nonatomic ,strong)UILabel *yinliText;
@property (nonatomic ,strong)UILabel *yangliText;

/**
 *  通过重写set方法赋值
 */
@property (nonatomic ,assign)NSInteger indexForMingGong;   //命宫所在的具体位置，从巳开始算起
@property (nonatomic ,strong)NSArray *daxianArray;         //大限
@property (nonatomic ,copy)NSString *yinyang;              //大限需要阴阳判断
@property (nonatomic ,strong)NSDictionary *dicFor12Shen;   //安博12神
@property (nonatomic ,copy)NSString *tianganSTR;
@property (nonatomic ,strong)NSDictionary *dicForZiwei; //6吉，14主，8禄存
@property (nonatomic ,strong)NSDictionary *dicForTianfu; //天府星 7
@property (nonatomic ,strong)NSDictionary *dicForLucun;  //禄存星 7
@property (nonatomic ,strong)NSDictionary *dicForLiuji;  //六吉星 6
@property (nonatomic ,strong)NSDictionary *dicForTaohua; //桃花星 6
@property (nonatomic ,strong)NSDictionary *dicForXunkong; //旬空星
@property (nonatomic ,strong)NSDictionary *dicForChangsheng; //长生
@property (nonatomic ,strong)NSDictionary *dicForSihua;    //四化
@property (nonatomic ,strong)NSDictionary *dicForZaxing;   //杂星
@property (nonatomic ,strong)NSDictionary *dicForSuiqian;  //岁前
@property (nonatomic ,strong)NSDictionary *dicForGong;     //宫位
@property (nonatomic ,strong)NSMutableDictionary *dicForAllStarandG; //所有的宫和星星
@property (nonatomic ,strong)NSMutableDictionary *dicForSanfangsizheng; //三方四正，1对3关系
@property (nonatomic ,strong)NSDictionary *dicForXiaoxian;
@property (nonatomic ,strong)UIImageView *imageForSanfang;  //需要改变图片
@property (nonatomic ,strong)UILabel *labelForXiaoxian;
@property (nonatomic ,strong)NSDictionary *dicForZiweiOnly;  //只是获取紫薇在哪个地址


@property (nonatomic ,weak)id<panDelegate>delegateForPan;

- (void)returnMiddlelabelAction;

@end
