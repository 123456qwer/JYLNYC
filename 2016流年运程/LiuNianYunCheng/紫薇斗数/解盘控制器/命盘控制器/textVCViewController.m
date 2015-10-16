//
//  textVCViewController.m
//  ziweidoushu
//
//  Created by 吴冬 on 15/7/6.
//  Copyright (c) 2015年 吴冬. All rights reserved.
//

#import "textVCViewController.h"
#import "SuanxingModel.h"
#import "PanView.h"
#import "JiepanViewController.h"
#import "LiunianJPViewController.h"
#import "TianpanJPViewController.h"

#pragma mark frame

#define xForPushBtn 224 / 750.0 * kScreenWidth
#define yForPushBtn 881 / 1334.0 * kScreenHeight
#define widthForPushBtn 302 / 750.0 * kScreenWidth
#define heightForPushBtn 72 / 1334.0 * kScreenHeight
#define YforBackBtn 64 / 1334.0 * kScreenHeight

#define widthForBtn 223 / 750.0 * kScreenWidth
#define heightForBtn 88 / 1334.0 * kScreenHeight
#define yFotBtn (128 / 2.0 - 88 / 2.0) / 1334.0 * kScreenHeight
#define pageHeightBtn 20 / 1334.0 * kScreenHeight


@interface textVCViewController ()
{

    CGFloat _heightForTop;
    PanView *_panView;
    SuanxingModel *_suanxingModel;
    UIButton *_backBTN;
    UIButton *_shareBTN;
    UIButton *_pushBTN;
    UIButton *_middleBTN;
    UIButton *_turnBtn;
    
    CGFloat      _xForBackBtn;
    CGFloat      _yForBackBtn;
    CGFloat      _widthForBackBtn;
    CGFloat      _heightForBackBtn;
    UIImageView *bgImage;
    NSMutableArray *_arrForZM; //紫薇和命宫的位置
    
    BOOL       _isLiunian;
}
@end

@implementation textVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _heightForTop= 128 / 1334.0 * kScreenHeight;

    //创建frame
    [self createForFrame];
    

    
    bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgImage.image = [UIImage imageNamed:@"天盘背景.jpg"];
    [self.view addSubview:bgImage];
    
    //初始化盘
    _panView = [[PanView alloc]initWithFrame:CGRectMake(0, _heightForTop, kScreenWidth, kScreenHeight)];
    _panView.delegateForPan = self;
    [self.view addSubview:_panView];
    
    //初始化星算法
    _suanxingModel = [[SuanxingModel alloc]initWithMonth:_month andHours:_hours andTiangan:_tiangan andDay:_day andYinyang:_yinyang  andShengxiao:_dizhiSTR andName:_name andAge:_age];
    
    /**
     *  中间label赋值方法
     */
    [self fuzhiAction];
    
    
    
    /**
     *  各个宫位  //注：先算宫位，有了命宫位置才可以起大限  ,也要有阴阳
     */
    [self gongAction];
    
    //赋值阴阳
    _panView.yinyang = _suanxingModel.yinyang;
    
    /**
     *  起大限
     */
    [self daxianAction];
    
    /**
     *  安博12神
     */
    [self actionFor12shen];
    
    /**
     *  安放天干，需要获取天干
     */
    [self actionForTiangan];
    
    /**
     *  放星星
     */
    [self actionForStar];
    
    /**
     *  创建返回和分享按钮
     */
    [self creatBackBtnAndShareBtn];
}

//创建适配的frame
- (void)createForFrame
{
    
    _yForBackBtn = 57 / 1136.0 * kScreenHeight;
    _xForBackBtn = 10 / 640.0 * kScreenWidth;
    _widthForBackBtn = 116 / 640.0 * kScreenWidth;
    _heightForBackBtn = 52 / 1136.0 * kScreenHeight;
}

/**
 *  放星星以及流年盘的字典
 */
- (void)actionForStar
{
   //紫薇
    _panView.dicForZiwei = _suanxingModel.dicForZiweiOUT;
    
   //天府
    _panView.dicForTianfu = _suanxingModel.dicForTianfuOUT;
    
   //禄存星
    _panView.dicForLucun = _suanxingModel.dicForLucunOUT;
    
   //六吉星
    _panView.dicForLiuji = _suanxingModel.dicForLiujiOUT;
    
   //桃花星
    _panView.dicForTaohua = _suanxingModel.dicForTaohuaOUT;
    
    //旬空星
    _panView.dicForXunkong = _suanxingModel.dicForXunkongOUT;
    
    //长生12神
    _panView.dicForChangsheng = _suanxingModel.dicForChangchengOUT;
    
    //放四化
    _panView.dicForSihua = _suanxingModel.dicForSihuaOUT;
    
    //杂星
    _panView.dicForZaxing = _suanxingModel.dicForZaxingOUT;
    
    //岁前12行
    _panView.dicForSuiqian = _suanxingModel.dicForSuiqianOUT;
    
    //小限
    _panView.dicForXiaoxian = _suanxingModel.dicForXiaoxianOUT;
    
    //宫未字典
    _panView.dicForGong = _suanxingModel.dicForGongOUT;
    
    
    //以后如果加流年的话就需要这个
    
    //流年盘
    
    [self xiaoxianAction];
    

}



//算出小限以及小限命宫所在的位置，存入arr中
- (void)xiaoxianAction
{

    //算出小限
    NSString *ageNow = [NSString stringWithFormat:@"%ld",_suanxingModel.age];
    
    NSArray *_arrForMingpan = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];
    
    NSInteger ageFo = 0;
    
    for (int i = 0; i < _suanxingModel.dicForXiaoxianOUTforTurn.count; i++) {
        
        NSArray *arrFoRxIAO = _suanxingModel.dicForXiaoxianOUTforTurn[_suanxingModel.dicForXiaoxianOUTforTurn.allKeys[i]];
        
        for (int j = 0; j < arrFoRxIAO.count; j++) {
            
            NSString *strFoa = arrFoRxIAO[j];
            
            if ([strFoa isEqualToString:ageNow]) {
                
                NSLog(@"%@",_suanxingModel.dicForXiaoxianOUTforTurn.allKeys[i]);
                
                ageFo = [_arrForMingpan indexOfObject:_suanxingModel.dicForXiaoxianOUTforTurn.allKeys[i]];
                
                NSLog(@"%ld",ageFo);
                
            }
            
        }
        
        
        
    }
    
    _arrForZM = [NSMutableArray array];
    
    NSString *ziwei = [NSString stringWithFormat:@"%@",_panView.dicForZiweiOnly[@"紫薇"]];
    NSString *minggong = [NSString stringWithFormat:@"%@",_arrForMingpan[ageFo]];
    [_arrForZM addObject:ziwei];
    [_arrForZM addObject:minggong];
    
    NSLog(@": %@",_panView.dicForZiweiOnly[@"紫薇"]);
    NSLog(@": %@",_arrForMingpan[ageFo]);
    
    
    _panView.indexForMingGong = ageFo;
    bgImage.image = [UIImage imageNamed:@"背景主页"];
    _panView.dicForGong = [_suanxingModel gongChange:ageFo];
    
    UIView *viewForTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _heightForTop)];
    viewForTitle.backgroundColor = [UIColor colorWithRed:139 / 255.0 green:97 / 255.0 blue: 82 / 255.0 alpha:1];
    [self.view addSubview:viewForTitle];
    
    UILabel *labelForTitlt = [[UILabel alloc]initWithFrame:CGRectMake(0, pageHeightBtn, kScreenWidth, _heightForTop)];
    labelForTitlt.text = @"小限盘";
    labelForTitlt.textColor = [UIColor whiteColor];
    labelForTitlt.font = [UIFont boldSystemFontOfSize:21];
    labelForTitlt.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelForTitlt];
    
    
    //删除选中效果
    [_panView returnMiddlelabelAction];
    


}


/**
 *  返回方法
 *
 *  @param sender
 */
- (void)actionForBtn:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *  分享方法
 *
 *  @param sender
 */
- (void)actionForShare:(UIButton *)sender
{

    NSLog(@"分享成功");
}


/**
 *  返回按钮和分享按钮和解盘按钮
 */
- (void)creatBackBtnAndShareBtn
{
    //返回按钮
    _backBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBTN.frame = CGRectMake(0, yFotBtn + pageHeightBtn, widthForBtn, heightForBtn);
    
    [_backBTN setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [_backBTN addTarget:self action:@selector(actionForBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBTN];
    
//    //分享按钮
//    _shareBTN = [UIButton buttonWithType:UIButtonTypeCustom];
//    _shareBTN.frame = CGRectMake(kScreenWidth - _xForBackBtn - _widthForBackBtn, _yForBackBtn, _widthForBackBtn, _heightForBackBtn);
//    [_shareBTN setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
//    [_shareBTN addTarget:self action:@selector(actionForShare:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_shareBTN];
    
    //解盘按钮
//    _pushBTN = [UIButton buttonWithType:UIButtonTypeCustom];
//    _pushBTN.frame = CGRectMake(xForPushBtn, yForPushBtn, widthForPushBtn, heightForPushBtn);
//    [_pushBTN addTarget:self action:@selector(pushJiepanView) forControlEvents:UIControlEventTouchUpInside];
//    [_pushBTN setTitle:@"小限流年分析" forState:UIControlStateNormal];
//    [_pushBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _pushBTN.backgroundColor = [UIColor colorWithRed:139 / 255.0 green:97 / 255.0 blue:22 / 255.0 alpha:1];
//    _pushBTN.layer.cornerRadius = 13;
//    
//    [self.view addSubview:_pushBTN];
//
    //增加天盘打开这个转盘的按钮
    /*
    //转换盘的btn
    _turnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _turnBtn.frame = CGRectMake(kScreenWidth / 2.0 - 80 / 2.0, 0, 80, 40);
    [_turnBtn addTarget:self action:@selector(turnForLiunian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_turnBtn];
    */
    
}



//以后添加天盘直接打开这个
/*************************************以后增加天盘直接打开这个***********************

//转出流年盘
- (void)turnForLiunian
{
    _pushBTN.alpha = 0;
    
    if (_arrForZM.count > 0) {
        
        [_arrForZM removeAllObjects];
        
    }
    
    //算出小限
    NSString *ageNow = [NSString stringWithFormat:@"%ld",_suanxingModel.age];
    
    NSArray *_arrForMingpan = @[@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",@"子",@"丑",@"寅",@"卯",@"辰"];
    
    NSInteger ageFo = 0;
    
    for (int i = 0; i < _suanxingModel.dicForXiaoxianOUTforTurn.count; i++) {
        
        NSArray *arrFoRxIAO = _suanxingModel.dicForXiaoxianOUTforTurn[_suanxingModel.dicForXiaoxianOUTforTurn.allKeys[i]];
        
        for (int j = 0; j < arrFoRxIAO.count; j++) {
            
            NSString *strFoa = arrFoRxIAO[j];
            
            if ([strFoa isEqualToString:ageNow]) {
                
                NSLog(@"%@",_suanxingModel.dicForXiaoxianOUTforTurn.allKeys[i]);
                
                ageFo = [_arrForMingpan indexOfObject:_suanxingModel.dicForXiaoxianOUTforTurn.allKeys[i]];
                
                NSLog(@"%ld",ageFo);

            }
            
        }
        
        
        
    }
    
    _arrForZM = [NSMutableArray array];
    
    NSString *ziwei = [NSString stringWithFormat:@"紫薇在%@",_panView.dicForZiweiOnly[@"紫薇"]];
    NSString *minggong = [NSString stringWithFormat:@"命宫在%@",_arrForMingpan[ageFo]];
    [_arrForZM addObject:minggong];
    [_arrForZM addObject:ziwei];
    
    NSLog(@": %@",_panView.dicForZiweiOnly[@"紫薇"]);
    NSLog(@": %@",_arrForMingpan[ageFo]);
    
    
    if (_isLiunian == NO) {
        
        [UIView transitionWithView:_panView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            _panView.indexForMingGong = ageFo;
            bgImage.image = [UIImage imageNamed:@"流年背景.jpg"];
            _panView.dicForGong = [_suanxingModel gongChange:ageFo];
           

            //删除选中效果
            [_panView returnMiddlelabelAction];
            
            _panView.panleiText.text = @"流年盘";
          
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                
                _pushBTN.alpha = 1;

                
            } completion:^(BOOL finished) {
                ;
            }];
        }];
        
        _isLiunian = YES;
        
    }else{
       
        [UIView transitionWithView:_panView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            
            _panView.indexForMingGong = _suanxingModel.indexForMingzhu;
            bgImage.image = [UIImage imageNamed:@"天盘背景.jpg"];
            _panView.dicForGong = _suanxingModel.dicForGongOUT;
            [_panView returnMiddlelabelAction];
            
            _panView.panleiText.text = @"天盘";
          
           

        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                
                _pushBTN.alpha = 1;
                
                
            } completion:^(BOOL finished) {
                ;
            }];
            
        }];
     
        _isLiunian = NO;
    }
    
  

}

********************************************************************************/


//push方法
- (void)pushJiepanView
{

    LiunianJPViewController *liunianVC =[[LiunianJPViewController alloc]init];
    
    liunianVC.dicForAllStarandG = _panView.dicForAllStarandG;
    
    liunianVC.arrForZM = _arrForZM;
    
    liunianVC.name = _panView.nameText.text;
    
    liunianVC.burnDay = _panView.yangliText.text;
    
    [self.navigationController pushViewController:liunianVC animated:YES];
    
}


//选择选中宫的index,以后加天盘的时候用
/*
- (void)pushWithIndexForGong:(NSInteger )indexForGong
{
    
    if (_isLiunian) {
        
        LiunianJPViewController *liunianVC =[[LiunianJPViewController alloc]init];
        
        liunianVC.dicForAllStarandG = _panView.dicForAllStarandG;
        liunianVC.arrForZM = _arrForZM;
        
        [self.navigationController pushViewController:liunianVC animated:YES];
        
        
    }else{
    
        TianpanJPViewController *tianpanVC = [[TianpanJPViewController alloc]init];
        
        tianpanVC.dicForAllStarandG = _panView.dicForAllStarandG;
        
        tianpanVC.dicForSanfangsizheng = _panView.dicForSanfangsizheng;
        
        [self.navigationController pushViewController:tianpanVC animated:YES];
    
    }
    
   
    
}
*/



/**
 *  放天干
 */
- (void)actionForTiangan
{

    _panView.tianganSTR = _suanxingModel.tiangan;
    
}

/**
 *  安博12神
 */
- (void)actionFor12shen
{

    _panView.dicFor12Shen = _suanxingModel.dicForBOSHI;

}

/**
 *  起大限
 */
- (void)daxianAction
{
    _panView.daxianArray = _suanxingModel.daxianArr;
    

}

/**
 *  宫位
 *
 *  @return nil
 */
- (void)gongAction
{

    _panView.indexForMingGong = _suanxingModel.indexForMingzhu;
    
}



/**
 *  给VIEW中间的Label赋值
 */
- (void)fuzhiAction
{
    //五行局
    _panView.mingjuText.text = _suanxingModel.wuxingSTR;
    
    //命主
    _panView.mingzhuText.text = _suanxingModel.mingzhuSTR;
    
    //身主
    _panView.shenzhuText.text = _suanxingModel.shenzhuSTR;
    
    //名字
    _panView.nameText.text = _suanxingModel.name;
    
    //年龄
    _panView.ageText.text =  [NSString stringWithFormat:@"%ld",_suanxingModel.age];
    
    //阳历出生日期
    _panView.yangliText.text = [_suanxingModel returnActionForBornWithYear:_yearsNow andMonth:_monthNow andDay:_dayNow andHours:_hoursNow];
    
    //阴历出生日期
    _panView.yinliText.text = self.yinliSTR;
    
    _panView.ziniandoujunText.text = _suanxingModel.ziniandoujunSTR;
    
}


//可能没找到的key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
   
    NSLog(@"没有找到我哦~");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
