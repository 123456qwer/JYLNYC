//
//  HomePageView.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/11.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "HomePageView.h"
#import "SuanxingTool.h"

#define heightForTitle 128 /1334.0 * kScreenHeight //标题

#define xForSliderBtn  30 / 750.0 * kScreenWidth    //侧栏按钮
#define yForSliderBtn

#define heightForBigView 530 / 1334.0 * kScreenHeight  //存姓名Label的图
#define yForBigView  128 /1334.0 * kScreenHeight       //y

#define xForName  30 / 750.0 * kScreenWidth            //姓名label
#define yForName  36 / 1334.0 * kScreenHeight
#define xForGeju  (750 - 332) / 750.0 * kScreenWidth     //X格局
#define pageForLabel  36 / 1334.0 * kScreenHeight      //俩个label之间的距离
#define widthForLabel 100 / 750.0 * kScreenWidth     //文字宽度
#define heightForLabel 34 / 1334.0 * kScreenHeight  //文字高度
#define xForTextLabel 30 / 750.0 * kScreenWidth + widthForLabel + 5
#define WidthForTextLabel 300

#define pageForXiaoxian 20 / 1334.0 * kScreenHeight //小仙按钮
#define heightForXiaoxian 170 / 1334.0 * kScreenHeight
#define xForXiaoxianBTN 30 / 750.0 * kScreenWidth
#define widthForXiaoxian 110 / 1334.0 * kScreenHeight
#define xForXiaoxianLabel 32 / 750.0 * kScreenWidth
#define widthForPeopleBtn 70 / 1334.0 * kScreenHeight
#define yForXiaoxianLabel 45 / 1334.0 * kScreenHeight
#define xForGuanyinBtn 610 / 750.0 * kScreenWidth
#define yForGuanyinBtn 615 / 2.0 / 1334.0 * kScreenHeight
#define widthForGuanyinBtn 74 / 750.0 * kScreenWidth
#define heightForGuanyinBtn 200 / 1334.0 * kScreenHeight

//选人按钮
#define widthForBtn 223 / 750.0 * kScreenWidth
#define heightForBtn 88 / 1334.0 * kScreenHeight
#define yFotBtn (128 / 2.0 - 88 / 2.0) / 1334.0 * kScreenHeight

#define labelColor  [UIColor colorWithRed:112 / 255.0 green:21 / 255.0 blue:21 / 255.0 alpha:1]
#define colorForText [UIColor colorWithRed:30 / 255.0 green:30 / 255.0 blue:30 / 255.0 alpha:1]
#define colorForBtnText [UIColor colorWithRed:70 / 255.0 green:15 / 255.0 blue:15 / 255.0 alpha:1]
#define shadowColorForText [UIColor colorWithRed:177 / 255.0 green:137 / 255.0 blue:122 / 255.0 alpha:0.5].CGColor
#define pageHeightBtn 20 / 1334.0 * kScreenHeight

@implementation HomePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIFont *textFont;
        UIFont *labelFont;
        
       NSString *strForIPhone = [SuanxingTool getCurrentDeviceModel];
        
        if ([strForIPhone isEqualToString:@"iPhone 4"] || [strForIPhone isEqualToString:@"iPhone 4S"]) {
            
            textFont = [UIFont systemFontOfSize:12];
            labelFont = [UIFont systemFontOfSize:14];
            
        }else if([strForIPhone isEqualToString:@"iPhone 5"] || [strForIPhone isEqualToString:@"iPhone 5c"] || [strForIPhone isEqualToString:@"iPhone 5s"]){
            
            textFont = [UIFont systemFontOfSize:13];
            labelFont = [UIFont systemFontOfSize:15];

            
        }else if([strForIPhone isEqualToString:@"iPhone 6"]){

            textFont = [UIFont systemFontOfSize:15];
            labelFont = [UIFont systemFontOfSize:17];
            
        }else if([strForIPhone isEqualToString:@"iPhone 6 Plus"]){
            
            textFont = [UIFont systemFontOfSize:17];
            labelFont = [UIFont systemFontOfSize:19];
        
        }
        
        //模拟器的数据
//        textFont = [UIFont systemFontOfSize:15];
//        labelFont = [UIFont systemFontOfSize:17];
        
        
        UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imagev.image = [UIImage imageNamed:@"背景主页"];
        [self addSubview:imagev];
        UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth ,128 /1334.0 * kScreenHeight)];
        titleView.backgroundColor  = [UIColor colorWithRed:139 / 255.0 green:97 / 255.0 blue:82 / 255.0 alpha:1.000];
        [self addSubview:titleView];
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0,pageHeightBtn,kScreenWidth,128 /1334.0 * kScreenHeight)];
        _title.text = @"流年运程";
        _title.textColor = [UIColor whiteColor];
        _title.font = [UIFont boldSystemFontOfSize:21];
       // _title.backgroundColor =  [UIColor colorWithRed:139 / 255.0 green:97 / 255.0 blue:82 / 255.0 alpha:1.000];
        _title.textAlignment = NSTextAlignmentCenter;

        
        _sliderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigView1 = [[UIView alloc]initWithFrame:CGRectZero];
        
        _name1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _name1.text = @"姓名:";
        _name1.font = labelFont;
        _name1.textColor = labelColor;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.font = textFont;
        
        _age1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _age1.text = @"年龄:";
        _age1.font = labelFont;
        _age1.textColor = labelColor;
        _ageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _ageLabel.font = textFont;
        
        _yangli1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _yangli1.text = @"阳历:";
        _yangli1.textColor = labelColor;
        _yangli1.font = labelFont;
        _yangliLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _yangliLabel.font = textFont;
        
        _wuxing1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _wuxing1.text = @"五行:";
        _wuxing1.font = labelFont;
        _wuxing1.textColor = labelColor;
        _wuxingLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _wuxingLabel.font = textFont;
        
        _today1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _today1.text = @"今日:";
        _today1.font = labelFont;
        _today1.textColor = [UIColor colorWithRed:238 / 255.0 green:85 / 255.0 blue:11 / 255.0 alpha:1];;
        _todayLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _todayLabel.font = textFont;
        
        _right1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _right1.text = @"宜:";
        _right1.font = labelFont;
        _right1.textColor = [UIColor colorWithRed:50 / 255.0 green:169 / 255.0 blue:142 / 255.0 alpha:1];
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _rightLabel.font = textFont;
        
        
        _wrong1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _wrong1.text = @"忌:";
        _wrong1.font = labelFont;
        _wrong1.textColor = [UIColor colorWithRed:255 / 255.0 green:55 / 255.0 blue:55 / 255.0 alpha:1];
        _wrongLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _wrongLabel.font = textFont;
        
        _geju1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _geju1.text = @"格局:";
        _geju1.font = labelFont;
        _geju1.textColor = labelColor;
        _gejuLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _gejuLabel.font = textFont;
        
        _shuxiang1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _shuxiang1.text = @"属相:";
        _shuxiang1.font = labelFont;
        _shuxiang1.textColor = labelColor;
        _shengxiaoLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _shengxiaoLabel.font = textFont;
        
  
        
        
        self.sliderBtn.frame = CGRectMake(xForSliderBtn, 5, 60, 60);
        self.bigView1.frame = CGRectMake(0, yForBigView, kScreenWidth, heightForBigView);
        _bigView1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        
        _bigView1.layer.shadowOffset = CGSizeMake(0, 2);
        _bigView1.layer.shadowOpacity = 1;
        _bigView1.layer.shadowColor = shadowColorForText;
        
        self.name1.frame = CGRectMake(xForName, yForName, widthForLabel, heightForLabel);
        self.nameLabel.frame = CGRectMake(xForTextLabel, yForName, WidthForTextLabel, heightForLabel);
        self.nameLabel.textColor = colorForText;
        
        self.age1.frame = CGRectMake(xForName, self.name1.bottom + pageForLabel, widthForLabel, heightForLabel);
        self.ageLabel.frame = CGRectMake(xForTextLabel, self.name1.bottom + pageForLabel, WidthForTextLabel, heightForLabel);
        self.ageLabel.textColor = colorForText;
        
        self.yangli1.frame = CGRectMake(xForName, self.age1.bottom + pageForLabel, widthForLabel, heightForLabel);
        self.yangliLabel.frame = CGRectMake(xForTextLabel, self.age1.bottom + pageForLabel, WidthForTextLabel, heightForLabel);
        self.yangliLabel.textColor = colorForText;
        
        self.wuxing1.frame = CGRectMake(xForName, self.yangli1.bottom + pageForLabel, widthForLabel, heightForLabel);
        self.wuxingLabel.frame = CGRectMake(xForTextLabel, self.yangli1.bottom + pageForLabel, WidthForTextLabel, heightForLabel);
        self.wuxingLabel.textColor = colorForText;
        
        self.today1.frame = CGRectMake(xForName, self.wuxing1.bottom + pageForLabel, widthForLabel, heightForLabel);
        self.todayLabel.frame = CGRectMake(xForTextLabel, self.wuxing1.bottom + pageForLabel, WidthForTextLabel, heightForLabel);
        self.todayLabel.textColor = colorForText;
        
        self.right1.frame = CGRectMake(xForName, self.today1.bottom + pageForLabel, widthForLabel, heightForLabel);
        self.rightLabel.frame = CGRectMake(xForTextLabel, self.today1.bottom + pageForLabel, WidthForTextLabel, heightForLabel);
        self.rightLabel.textColor = colorForText;
        
        self.wrong1.frame = CGRectMake(xForName, self.right1.bottom + pageForLabel, widthForLabel, heightForLabel);
        self.wrongLabel.frame = CGRectMake(xForTextLabel, self.right1.bottom + pageForLabel, WidthForTextLabel, heightForLabel);
        self.wrongLabel.textColor = colorForText;
        
        
        self.geju1.frame = CGRectMake(xForGeju, xForName, widthForLabel, heightForLabel);
        self.gejuLabel.frame = CGRectMake(xForGeju + widthForLabel  +5, xForName, WidthForTextLabel, heightForLabel);
        self.gejuLabel.textColor = colorForText;
        
        
        self.shuxiang1.frame = CGRectMake(xForGeju, self.geju1.bottom + pageForLabel, widthForLabel, heightForLabel);
        self.shengxiaoLabel.frame = CGRectMake(xForGeju + widthForLabel  +5, self.geju1.bottom + pageForLabel, WidthForTextLabel, heightForLabel);
        self.shengxiaoLabel.textColor = colorForText;
        
        _xiaoxianliunian = [UIButton buttonWithType:UIButtonTypeSystem];
        [_xiaoxianliunian addTarget:self action:@selector(xiaoxianAction:) forControlEvents:UIControlEventTouchUpInside];
        _xiaoxianliunian.frame = CGRectMake(0, _bigView1.bottom + pageForXiaoxian, kScreenWidth, heightForXiaoxian);
        _xiaoxianliunian.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        [self addSubview:_xiaoxianliunian];
        _xiaoxianliunian.layer.shadowOpacity = 1;
        _xiaoxianliunian.layer.shadowOffset = CGSizeMake(0, 2);
        _xiaoxianliunian.layer.shadowColor = shadowColorForText;
        
        UIImageView *xiaoxianV = [[UIImageView alloc]initWithFrame:CGRectMake(xForXiaoxianBTN, xForXiaoxianBTN, widthForXiaoxian, widthForXiaoxian)];
        xiaoxianV.image = [UIImage imageNamed:@"小限流年"];
        [_xiaoxianliunian addSubview:xiaoxianV];
        
        UILabel *labelForXi = [[UILabel alloc]initWithFrame:CGRectMake(xiaoxianV.right + xForXiaoxianLabel, yForXiaoxianLabel, 200, 40)];
        labelForXi.text = @"小限流年";
       // labelForXi.backgroundColor = [UIColor orangeColor];
        labelForXi.font = [UIFont boldSystemFontOfSize:22];
        labelForXi.textColor = colorForBtnText;
        [_xiaoxianliunian addSubview:labelForXi];
        
        
        _shengxiaodizhi = [UIButton buttonWithType:UIButtonTypeSystem];
        [_shengxiaodizhi addTarget:self action:@selector(shengxiaoAction:) forControlEvents:UIControlEventTouchUpInside];
        _shengxiaodizhi.frame = CGRectMake(0, _xiaoxianliunian.bottom + pageForXiaoxian, kScreenWidth, heightForXiaoxian);
        _shengxiaodizhi.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        [self addSubview:_shengxiaodizhi];
        _shengxiaodizhi.layer.shadowOpacity = 1;
        _shengxiaodizhi.layer.shadowOffset = CGSizeMake(0, 2);
        _shengxiaodizhi.layer.shadowColor = shadowColorForText;
        
        UIImageView *shengxiaoV = [[UIImageView alloc]initWithFrame:CGRectMake(xForXiaoxianBTN, xForXiaoxianBTN, widthForXiaoxian, widthForXiaoxian)];
        shengxiaoV.image = [UIImage imageNamed:@"十二生肖forzhuye"];
        [_shengxiaodizhi addSubview:shengxiaoV];
        
        UILabel *labelForSh = [[UILabel alloc]initWithFrame:CGRectMake(xiaoxianV.right + xForXiaoxianLabel, yForXiaoxianLabel, 200, 40)];
        labelForSh.text = @"十二生肖";
        //labelForSh.backgroundColor = [UIColor orangeColor];
        labelForSh.textColor = colorForBtnText;
        labelForSh.font = [UIFont boldSystemFontOfSize:22];
        [_shengxiaodizhi addSubview:labelForSh];
        
        _dajiangtang = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dajiangtang addTarget:self action:@selector(dajiangtangAction:) forControlEvents:UIControlEventTouchUpInside];
        _dajiangtang.frame = CGRectMake(0, _shengxiaodizhi.bottom + pageForXiaoxian, kScreenWidth, heightForXiaoxian);
        _dajiangtang.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        [self addSubview:_dajiangtang];
        _dajiangtang.layer.shadowOpacity = 1;
        _dajiangtang.layer.shadowOffset = CGSizeMake(0, 2);
        _dajiangtang.layer.shadowColor = shadowColorForText;
        
        
        UIImageView *dajiangtangV = [[UIImageView alloc]initWithFrame:CGRectMake(xForXiaoxianBTN, xForXiaoxianBTN, widthForXiaoxian, widthForXiaoxian)];
        dajiangtangV.image = [UIImage imageNamed:@"大讲堂"];
        [_dajiangtang addSubview:dajiangtangV];
        
        UILabel *labelForDi = [[UILabel alloc]initWithFrame:CGRectMake(xiaoxianV.right + xForXiaoxianLabel, yForXiaoxianLabel, 200, 40)];
        labelForDi.text = @"紫薇大讲堂";
        //labelForDi.backgroundColor = [UIColor orangeColor];
        labelForDi.textColor = colorForBtnText;
        labelForDi.font = [UIFont boldSystemFontOfSize:20];
        [_dajiangtang addSubview:labelForDi];
        
        _forPeopleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _forPeopleBtn.frame = CGRectMake(0, yFotBtn + pageHeightBtn, widthForBtn, heightForBtn);
        [_forPeopleBtn addTarget:self action:@selector(actionForSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_forPeopleBtn setImage:[UIImage imageNamed:@"弹出选人图标"] forState:UIControlStateNormal];
        //_forPeopleBtn.backgroundColor = [UIColor orangeColor];
    
        _guanyinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _guanyinBtn.frame = CGRectMake(xForGuanyinBtn, yForGuanyinBtn, widthForGuanyinBtn, heightForGuanyinBtn);
        [_guanyinBtn setBackgroundImage:[UIImage imageNamed:@"观音按钮"] forState:UIControlStateNormal];
        [_guanyinBtn addTarget:self action:@selector(actionForGuanyinqian:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bigView1 addSubview:_guanyinBtn];
        [_bigView1 addSubview:_name1];
        [_bigView1 addSubview:_shuxiang1];
        [_bigView1 addSubview:_age1];
        [_bigView1 addSubview:_yangli1];
        [_bigView1 addSubview:_wuxing1];
        [_bigView1 addSubview:_today1];
        [_bigView1 addSubview:_right1];
        [_bigView1 addSubview:_wrong1];
        [_bigView1 addSubview:_geju1];
        [_bigView1 addSubview:_nameLabel];
        [_bigView1 addSubview:_shengxiaoLabel];
        [_bigView1 addSubview:_ageLabel];
        [_bigView1 addSubview:_yangliLabel];
        [_bigView1 addSubview:_wuxingLabel];
        [_bigView1 addSubview:_todayLabel];
        [_bigView1 addSubview:_rightLabel];
        [_bigView1 addSubview:_wrongLabel];
        [_bigView1 addSubview:_gejuLabel];
        
        
        [self addSubview:_title];
        [self addSubview:_sliderBtn];
        [self addSubview:_bigView1];
        [self addSubview:_forPeopleBtn];

        
    }
    
    
    return self;

}

/**
 *  点击观音签
 *
 *  @param sender
 */
- (void)actionForGuanyinqian:(UIButton *)sender
{
   
    NSLog(@"弹出观音钱方法");
[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://appsto.re/cn/LTwi7.i"]];

}

/**
 *  点击隐藏侧栏按钮方法
 *
 *  @param sender
 */
- (void)actionForSelected:(UIButton *)sender {
    
    //侧边栏
    if ([self.homeDelegate respondsToSelector:@selector(clickSliderView)]) {
        
        [self.homeDelegate clickSliderView];
        
    }
    
    
}

/**
 *  点击流年按钮方法
 *
 *  @param sender
 */
- (void)xiaoxianAction:(UIButton *)sender {
    
    //点击代理方法,流年
    if ([self.homeDelegate respondsToSelector:@selector(clickXiaoxianLiulian)]) {
        
        [self.homeDelegate clickXiaoxianLiulian];
    }
    
}

/**
 *  点击生肖按钮方法
 *
 *  @param sender
 */
- (void)shengxiaoAction:(UIButton *)sender {
    
    //生肖
    if ([self.homeDelegate respondsToSelector:@selector(clickShengxiao)]) {
        
        [self.homeDelegate clickShengxiao];
    }
    
}

/**
 *  点击大讲堂按钮方法
 *
 *  @param sender
 */
- (void)dajiangtangAction:(UIButton *)sender{

    //大讲堂
    if ([self.homeDelegate respondsToSelector:@selector(clickDajiangtang)]) {
        
        [self.homeDelegate clickDajiangtang];
    }
}

@end
