//
//  HomePageView.h
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/11.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageView;
@protocol HomePageViewDelegate <NSObject>

//流年
- (void)clickXiaoxianLiulian;
//生肖
- (void)clickShengxiao;
//侧边栏
- (void)clickSliderView;
//大讲堂
- (void)clickDajiangtang;


@end


@interface HomePageView : UIView

@property (strong, nonatomic)UILabel *name1;
@property (strong, nonatomic)UILabel *geju1;
@property (strong, nonatomic)UILabel *age1;
@property (strong, nonatomic)UILabel *shuxiang1;

@property (strong, nonatomic)UILabel *yangli1;

@property (strong, nonatomic)UILabel *wuxing1;

@property (strong, nonatomic)UILabel *today1;
@property (strong, nonatomic)UILabel *title;

@property (strong, nonatomic)UIButton *sliderBtn;

@property (strong, nonatomic)UILabel *right1;
@property (strong, nonatomic)UILabel *wrong1;
@property (strong, nonatomic)UIView *bigView1;

@property (strong, nonatomic)UILabel *nameLabel;
@property (strong, nonatomic)UILabel *ageLabel;
@property (strong, nonatomic)UILabel *yangliLabel;
@property (strong, nonatomic)UILabel *wuxingLabel;
@property (strong, nonatomic)UILabel *todayLabel;
@property (strong, nonatomic)UILabel *rightLabel;
@property (strong, nonatomic)UILabel *wrongLabel;
@property (strong, nonatomic)UILabel *gejuLabel;
@property (strong, nonatomic)UILabel *shengxiaoLabel;





@property (nonatomic ,strong)UIButton *guanyinBtn;
@property (strong, nonatomic)UIButton *dajiangtang;
@property (strong, nonatomic)UIButton *xiaoxianliunian;
@property (strong, nonatomic)UIButton *shengxiaodizhi;
@property (strong, nonatomic)UIButton *forPeopleBtn;

@property (nonatomic ,weak)id<HomePageViewDelegate>homeDelegate;
@end
