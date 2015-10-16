//
//  LiunianJPViewController.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/30.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "LiunianJPViewController.h"
#import "LiuNianView.h"
#import "LiuNianSliderView.h"
#import "CountScrollView.h"
#import "ViewForCountG.h"
#import "AFNetworking.h"
#import "SuanxingTool.h"


#define shadowColorForText [UIColor colorWithRed:177 / 255.0 green:137 / 255.0 blue:122 / 255.0 alpha:0.5].CGColor
#define pageHeightBtn 20 / 1334.0 * kScreenHeight

//文字宽度
#define widthForCount 569 / 750.0 * kScreenWidth
#define xForLabelCount 36 / 750.0 * kScreenWidth
#define yForCount 22 / 1334.0 * kScreenHeight
#define pageForGongAndCount 89 / 1334.0 * kScreenHeight

//提示label frame
#define yForPrompt 533 / 1334.0 * kScreenHeight
#define xForPrompt 87 / 750.0 * kScreenWidth
#define heightForPrompt 29 / 1334.0 * kScreenHeight


#define kWidthForSliderView 60.0                          //边栏按钮的宽度
#define kYforSliderView 50                                //边栏的Y

#define kCountViewWidth (kScreenWidth - 60 - 15 * 3) / 2  //灰色View的宽度
#define kXforCountView 30                                 //灰色View的X在变的时候
#define kYforCountView 60                                 //灰色View的Y

#define pageForLabel 20 / 1334.0 * kScreenHeight //小仙按钮

#define widthForSliderView 101 / 750.0 * kScreenWidth
#define yForSliderView 128 / 1334.0 * kScreenHeight
#define heightForSliderView 180 / 1334.0 * kScreenHeight


#define widthForBtn 223 / 750.0 * kScreenWidth
#define heightForBtn 88 / 1334.0 * kScreenHeight
#define yFotBtn (128 / 2.0 - 88 / 2.0) / 1334.0 * kScreenHeight

//俩个宫视图的frame
#define heightForGongView 502 / 1334.0 * kScreenHeight

//装在内容的背景颜色
#define colorForCountView [UIColor colorWithRed:252 / 255.0 green:249 / 255.0 blue:244 / 255.0 alpha:1]

//没解锁之前的视图
#define heightForLockView 616 / 1334.0 * kScreenHeight

#define xForLockBtn 145 / 750.0 * kScreenWidth
#define yForLockBtn 46 / 1334.0 * kScreenHeight
#define widthForLockBtn 356 / 750.0 * kScreenWidth
#define heightForLockBtn 80 / 1334.0 * kScreenHeight
#define pageForLockBtn 107 / 1334.0 * kScreenHeight
#define pageForLockLabel 42 / 1334.0 * kScreenHeight
#define pageForLockBtnImage 56 / 750.0 * kScreenWidth


@interface LiunianJPViewController ()
{
    UIImageView *bgImageView;
    
    LiuNianView *countViewForLiunian;
    
    LiuNianSliderView *liunianSlider;
    
    ViewForCountG *_viewForG;
    
    CountScrollView *bgScrollView;
    
    UILabel *_labelForPrompt;
    
    UIView       *_labelForAllText;
    
    CGFloat  _xForCountView;
    CGFloat  _yForScrollView;
    CGFloat  _widthForPrompt;
    NSInteger _numberNow;
    
    UIView  *_viewForLock;
    UILabel *_labelForCountText;
    
    NSMutableArray *_arrForAllLabel;  //存储之前创建的Label,之后在请求的时候删除掉
    NSMutableArray *_arrForAllView;  //存储之前分割线
    NSMutableArray *_arrForLockView; //存储没解锁之前的View
    CGFloat _heightForBg;
    BOOL _isBack;
    
    BOOL _isMoneyAlready;        //点击一次以后不能再次点击
    BOOL _isMoney;
    
    UIImageView *_viewForClickNeigou;  //点击内购以后
    UIButton *btnForBack;         //返回按钮
    UIButton *btnForShare;        //分享按钮
    
    BOOL _isNet;
}
@end

@implementation LiunianJPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numberNow = 1;
    
    [self netAction];
    
    //之前购买了直接可以看内容
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:self.name] && [defaults objectForKey:self.burnDay]) {
        
        _isMoney = YES;
        
    }


    _arrForAllLabel = [NSMutableArray array];
    _arrForAllView = [NSMutableArray array];
    _arrForLockView = [NSMutableArray array];
    
   
    
    bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgImageView.image = [UIImage imageNamed:@"背景主页"];
    [self.view addSubview:bgImageView];
    
    //中间的内容视图
    _labelForCountText = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_labelForCountText];
    
    //请求网络获取数据
    [self requestAction];

  
}

#pragma mark 检测网络方法
- (void)netAction
{
    //检测网络的方法
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //检测网络的单例，网络变化的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        /**
         AFNetworkReachabilityStatusUnknown          = -1,  // 未知
         AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
         AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
         AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
         */
        
        if (status == 0 || status == -1) {
            
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"无网络" message:@"您当前没有网络，请检查网络情况后在尝试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: @"取消",nil];
            
            [alterView show];
            
            _isNet = NO;
            
            return ;
            
        }else{
        
            _isNet = YES;
        }
        
        NSLog(@"%ld",(long)status);
        
    }];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"点击确定了");
    
    if (buttonIndex == 0) {
        
        [self returnLabelCount:_numberNow];

    }else{
     
        NSLog(@"取消了");
    }
    
    

}
/**
 *  请求网络的方法
 */
- (void)requestAction
{


    NSLog(@"%@",_arrForZM);
    
    //是否有缓存，有缓存走缓存方法
    NSString *strKey = [NSString stringWithFormat:@"%@_1",self.name];
 
    if ([[NSUserDefaults standardUserDefaults] objectForKey:strKey]) {
        
        [self createViewAction];
        
        [self acitonForContent:[[NSUserDefaults standardUserDefaults] objectForKey:strKey]];
        
        return;
        
    }
 
    
    //检测网络
    [self netAction];
    
    //NSString *strForURL = [NSString stringWithFormat:@"http://xuanji.jyhd.com/year2016/queryPan?ziWei=%@&mingGong=%@&fortuneNum=1",strForZiwei,strForMinggong];
    
    NSString *strForZiwei = _arrForZM[0];
    NSString *strForMinggong = _arrForZM[1];
    
    NSString *str=[NSString stringWithFormat:@"http://xuanji.jyhd.com/year2016/queryPan?ziWei=%@&mingGong=%@&fortuneNum=1",strForZiwei,strForMinggong];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    从URL获取json数据
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        
        NSString *keyStr = [NSString stringWithFormat:@"%@_1",self.name];
        NSDictionary *dic = dict;
        
        /**
         *  做一下存储，有存储直接读取
         */
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:keyStr];
        
        NSString *str = dic[@"advice"];
        NSArray *arrForG = dic[@"gong"];
        
        NSMutableArray *arrForM = [NSMutableArray array];
        NSMutableArray *arrForHeight = [NSMutableArray array];
        NSMutableArray *arrForString = [NSMutableArray array];
        
        /**
         *  创建内容
         */
        for (int i = 0; i < arrForG.count; i++) {
            
            NSDictionary *dicForG = arrForG[i];
            
            NSArray *arrForConunt = [dicForG objectForKey:dicForG.allKeys[0]];
            
            NSDictionary *dicForCount1 = arrForConunt[0];
            
            
            NSString *gongName = dicForG.allKeys[0];
            NSString *gongBazi = dicForCount1.allKeys[0];
            NSString *gongCount = [dicForCount1 objectForKey:dicForCount1.allKeys[0]];
          
            
            //宫名字、八字
            NSString *aStrForGNmae = [NSString stringWithFormat:@"%@\n%@\n%@",gongName,gongBazi,gongCount];
            NSMutableAttributedString *strGong1111 = [[NSMutableAttributedString alloc]initWithString:aStrForGNmae];
            [strGong1111 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, gongName.length + gongBazi.length + 1 )];
           CGFloat heightForCount = [self returnCountHeight:strGong1111 andNSString:aStrForGNmae];
            
            [arrForString addObject:aStrForGNmae];
            [arrForM addObject:strGong1111];
            [arrForHeight addObject:@(heightForCount)];
            
            
            NSLog(@"建议：%@",str);
            NSLog(@"宫：%@",dicForG.allKeys[0]);
            NSLog(@"宫%d标题：%@",i,dicForCount1.allKeys[0]);
            NSLog(@"宫%d内容：%@",i,[dicForCount1 objectForKey:dicForCount1.allKeys[0]]);
   
        }

        /**
         *  建议的内容
         */
        NSString *gongAdvance = [NSString stringWithFormat:@"开运建议:%@",dic[@"advice"]];
        [arrForString addObject:gongAdvance];
        
        NSMutableAttributedString *strGong1111 = [[NSMutableAttributedString alloc]initWithString:gongAdvance];
     
         
        [strGong1111 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
        [arrForM addObject:strGong1111];

        CGFloat heightForAdvice = [self returnCountHeight:strGong1111 andNSString:gongAdvance];
        
        [arrForHeight addObject:@(heightForAdvice)];
        
        
        //根据高度创建label
        for (int i = 0; i < arrForHeight.count; i++) {
            
            if (i == 0) {
                
                UIView *viewForBack = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0 - 10, yForCount - 10, widthForCount + 20, [arrForHeight[i] floatValue] + 20)];
                viewForBack.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:249 / 255.0 blue:244 / 255.0 alpha:1];
                viewForBack.layer.shadowOpacity = 1;
                viewForBack.tag = 1111+i;
                viewForBack.layer.shadowOffset = CGSizeMake(0, 2);
                viewForBack.layer.shadowColor = shadowColorForText;
                [_labelForAllText addSubview:viewForBack];
                [_arrForAllView addObject:viewForBack];
                
                UILabel *labelForCount = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0,yForCount, widthForCount, [arrForHeight[i] floatValue])];
                labelForCount.attributedText = arrForM[i];
                labelForCount.numberOfLines = 0;
                labelForCount.font = [UIFont systemFontOfSize:16];
                labelForCount.textAlignment = NSTextAlignmentJustified;
                [_labelForAllText addSubview:labelForCount];
                [_arrForAllLabel addObject:labelForCount];
             

            }else{
            
                UIView *viewForNext = [_labelForAllText viewWithTag:1111 + i - 1];
                UIView *viewForBack = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0 - 10, viewForNext.bottom + pageForLabel, widthForCount + 20, [arrForHeight[i] floatValue] + 20)];
                viewForBack.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:249 / 255.0 blue:244 / 255.0 alpha:1];
                viewForBack.layer.shadowOpacity = 1;
                viewForBack.tag = 1111+i;
                viewForBack.layer.shadowOffset = CGSizeMake(0, 2);
                viewForBack.layer.shadowColor = shadowColorForText;
                [_labelForAllText addSubview:viewForBack];
                [_arrForAllView addObject:viewForBack];
                
                UILabel *labelForCount = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0,viewForNext.bottom + pageForLabel + 10, widthForCount,[arrForHeight[i] floatValue])];
                labelForCount.attributedText = arrForM[i];
                labelForCount.numberOfLines = 0;
                labelForCount.font = [UIFont systemFontOfSize:16];
                labelForCount.textAlignment = NSTextAlignmentJustified;
                [_labelForAllText addSubview:labelForCount];
                [_arrForAllLabel addObject:labelForCount];
                _heightForBg = viewForBack.bottom;
                
            }
            
            
            
        }
        

         _labelForAllText.frame = CGRectMake(0, countViewForLiunian.bottom + pageForGongAndCount, kScreenWidth - widthForSliderView, _heightForBg);
        _labelForAllText.backgroundColor = [UIColor clearColor];
  


        bgScrollView.contentSize = CGSizeMake(kScreenWidth + kWidthForSliderView + 1, _labelForAllText.bottom + 20);
        

        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
      
        
        NSLog(@"请求失败");
        
        
    }];
    
    [self createViewAction];

    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
   
 
}

/**
 *  返回文字的高度
 *
 *  @param strForCount
 *
 *  @return
 */
- (CGFloat )returnCountHeight:(NSMutableAttributedString *)strForCount andNSString:(NSString *)countStr
{
   
    UIFont *font = [UIFont systemFontOfSize:16];
    NSMutableParagraphStyle *mutableStyle = [[NSMutableParagraphStyle alloc]init];
    [mutableStyle setLineSpacing:5.f];
    [strForCount addAttribute:NSParagraphStyleAttributeName value:mutableStyle range:NSMakeRange(0, [strForCount length])];
    
    NSDictionary* dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:mutableStyle};
    
    CGSize size = [countStr boundingRectWithSize:CGSizeMake(widthForCount, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
    
}

/**
 *  创建UI
 */
- (void)createViewAction
{
    //背景可以滚动的视图
    bgScrollView = [[CountScrollView alloc]initWithFrame:CGRectMake(0, yForSliderView, kScreenWidth + kWidthForSliderView , kScreenHeight - yForSliderView )];
    bgScrollView.contentSize = CGSizeMake(kScreenWidth + kWidthForSliderView + 1, kScreenHeight * 2);
    bgScrollView.contentOffset = CGPointMake(1, 0);
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.delegate = self;
    bgScrollView.bounces = NO;
    [self.view addSubview:bgScrollView];
    
    
    NSString *str = [SuanxingTool getCurrentDeviceModel];
   
    UIFont *fontForLabel;
    if ([str isEqualToString:@"iPhone 4"] || [str isEqualToString:@"iPhone 4S"]) {
        
        fontForLabel = [UIFont systemFontOfSize:12];
        
        
    }else if([str isEqualToString:@"iPhone 5"] || [str isEqualToString:@"iPhone 5c"] || [str isEqualToString:@"iPhone 5s"]){
        
        fontForLabel = [UIFont systemFontOfSize:12];

        
    }else if([str isEqualToString:@"iPhone 6"]){

        fontForLabel = [UIFont systemFontOfSize:14];

        
    }else if([str isEqualToString:@"iPhone 6 Plus"]){
 
        fontForLabel = [UIFont systemFontOfSize:16];

        
    }else{
     
        fontForLabel = [UIFont systemFontOfSize:14];

        
    }
    

    
    //提示Label
    
    CGFloat widthForPrompt = [self returnStrHeight:@"（精确分析运势需结合对宫的格局）" andFont:fontForLabel andWidth:MAXFLOAT andHeight:heightForPrompt].width;
    _widthForPrompt = widthForPrompt;
    
    _labelForPrompt = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForPrompt) /2.0, yForPrompt, widthForPrompt, heightForPrompt)];
    _labelForPrompt.font = fontForLabel;
    // _labelForPrompt.backgroundColor = [UIColor orangeColor];
    _labelForPrompt.text = @"（精确分析运势需结合对宫的格局）";
    _labelForPrompt.textColor = [UIColor redColor];
    _labelForPrompt.textAlignment = NSTextAlignmentCenter;
    [bgScrollView addSubview:_labelForPrompt];
    
    //装载俩个宫视图的View
    countViewForLiunian = [[LiuNianView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - widthForSliderView, heightForGongView) andAllGongAndStar:_dicForAllStarandG andArrForZM:_arrForZM];
    countViewForLiunian.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:countViewForLiunian];
    
    //宫的解释内容视图
    _viewForG = [[ViewForCountG alloc]initWithFrame:CGRectMake(0, countViewForLiunian.bottom, kScreenWidth, kScreenHeight)];
    countViewForLiunian.liunianDelegate = _viewForG; //侧栏传给宫内容视图的代理
    _viewForG.delegateForCount = self;   //宫内容视图传给控制器
    [bgScrollView addSubview:_viewForG];
    
    
    //总的内容视图
    _labelForAllText = [[UIView alloc]initWithFrame:CGRectMake(0, _viewForG.bottom + 20, kScreenWidth - widthForSliderView, 400)];
    _labelForAllText.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:249 / 255.0 blue:244 / 255.0 alpha:1];
    [bgScrollView addSubview:_labelForAllText];
    
    
    //侧栏按钮的创建
    NSArray *arr = @[@"综合运势",@"感情运势",@"事业运势",@"财运运势",@"健康运势",@"家庭运势",@"人际运势"];
    liunianSlider = [[LiuNianSliderView alloc]initWithFrame:CGRectMake(kScreenWidth - widthForSliderView, yForSliderView , widthForSliderView, kScreenHeight - yForSliderView) andCountForGong:nil andSanfangsizheng:nil andBtnArr:arr andHeight:heightForSliderView];
    liunianSlider.sliderDelegate = countViewForLiunian;
    [self.view addSubview:liunianSlider];

    UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, yForSliderView)];
    viewBG.backgroundColor = colorForAll;
    [self.view addSubview:viewBG];
    
    //顶头的label
    UILabel *labelFor = [[UILabel alloc]initWithFrame:CGRectMake(0, pageHeightBtn, kScreenWidth, yForSliderView)];
    labelFor.text = @"流年分析";
    //labelFor.backgroundColor = colorForAll;
    labelFor.textColor = [UIColor whiteColor];
    labelFor.font = [UIFont boldSystemFontOfSize:21];
    labelFor.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelFor];
    
    btnForBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnForBack setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [btnForBack addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    btnForBack.frame = CGRectMake(0, yFotBtn + pageHeightBtn, widthForBtn, heightForBtn);
    [self.view addSubview:btnForBack];
    
    btnForShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnForShare setImage:[UIImage imageNamed:@"分享按钮"] forState:UIControlStateNormal];
    [btnForShare addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    btnForShare.frame = CGRectMake(kScreenWidth - widthForBtn, yFotBtn + pageHeightBtn, widthForBtn, heightForBtn);
    [self.view addSubview:btnForShare];

    
}

//返回高度
- (CGSize )returnStrHeight:(NSString *)str andFont:(UIFont *)font andWidth:(CGFloat )width andHeight:(CGFloat )height
{
    NSMutableParagraphStyle *mutableStyle = [[NSMutableParagraphStyle alloc]init];
    
    NSDictionary* dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:mutableStyle};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}

/**
 *  分享方法
 */
- (void)shareAction:(UIButton *)sender
{
    
    NSLog(@"分享");
    UIImage * image = [UIImage imageNamed:@"9.png"];
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"测试流年运程霸气不霸气";
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"" image:image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }else{
            
        }
    }];

}

/**
 *  返回方法
 */
- (void)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];


}

#pragma mark - 给View赋值的方法
- (void)acitonForContent:(NSDictionary *)dic
{
  
    //删除之前view上的内容
    
    if (_arrForAllLabel.count != 0 ) {
        
        for (int i = 0; i < _arrForAllLabel.count; i++) {
            
            UILabel *labelForBefore = [_arrForAllLabel objectAtIndex:i];
            [labelForBefore removeFromSuperview];
            
        }
        
        [_arrForAllLabel removeAllObjects];
        
        
    }
    if(_arrForAllView.count != 0){
        
        for (int i = 0; i < _arrForAllView.count; i++) {
            
            UIView *viewForBefore = _arrForAllView[i];
            
            [viewForBefore removeFromSuperview];
            
        }
        
        [_arrForAllView removeAllObjects];
        
    }
    if (_arrForLockView.count != 0) {
        
        for (int i = 0; i < _arrForLockView.count; i++) {
            
            UIView *viewForLock = _arrForLockView[i];
            
            [viewForLock removeFromSuperview];
            
        }
        
        [_arrForLockView removeAllObjects];
    }

    
    NSString *str = dic[@"advice"];
    
    NSArray *arrForG = dic[@"gong"];
    
    NSMutableArray *arrForM = [NSMutableArray array];
    NSMutableArray *arrForHeight = [NSMutableArray array];
    NSMutableArray *arrForString = [NSMutableArray array];
    
    /**
     *  创建内容
     */
    for (int i = 0; i < arrForG.count; i++) {
        
        NSDictionary *dicForG = arrForG[i];
        
        NSArray *arrForConunt = [dicForG objectForKey:dicForG.allKeys[0]];
        
        NSDictionary *dicForCount1 = arrForConunt[0];
        
        
        NSString *gongName = dicForG.allKeys[0];
        NSString *gongBazi = dicForCount1.allKeys[0];
        NSString *gongCount = [dicForCount1 objectForKey:dicForCount1.allKeys[0]];
        
        
        //宫名字、八字
        NSString *aStrForGNmae = [NSString stringWithFormat:@"%@\n%@\n%@",gongName,gongBazi,gongCount];
        NSMutableAttributedString *strGong1111 = [[NSMutableAttributedString alloc]initWithString:aStrForGNmae];
        [strGong1111 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, gongName.length + gongBazi.length + 1 )];
        CGFloat heightForCount = [self returnCountHeight:strGong1111 andNSString:aStrForGNmae];
        
        [arrForString addObject:aStrForGNmae];
        [arrForM addObject:strGong1111];
        [arrForHeight addObject:@(heightForCount)];
        
        
//        NSLog(@"建议：%@",str);
//        NSLog(@"宫：%@",dicForG.allKeys[0]);
//        NSLog(@"宫%d标题：%@",i,dicForCount1.allKeys[0]);
//        NSLog(@"宫%d内容：%@",i,[dicForCount1 objectForKey:dicForCount1.allKeys[0]]);
//        
    }
    
    /**
     *  建议的内容
     */
    NSString *gongAdvance = [NSString stringWithFormat:@"开运建议:%@",dic[@"advice"]];
    [arrForString addObject:gongAdvance];
    
    NSMutableAttributedString *strGong1111 = [[NSMutableAttributedString alloc]initWithString:gongAdvance];
    
    
    [strGong1111 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
    [arrForM addObject:strGong1111];
    
    CGFloat heightForAdvice = [self returnCountHeight:strGong1111 andNSString:gongAdvance];
    
    [arrForHeight addObject:@(heightForAdvice)];
    
    
    //根据高度创建label
    for (int i = 0; i < arrForHeight.count; i++) {
        
        if (i == 0) {
            
            UIView *viewForBack = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0 - 10, yForCount - 10, widthForCount + 20, [arrForHeight[i] floatValue] + 20)];
            viewForBack.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:249 / 255.0 blue:244 / 255.0 alpha:1];
            viewForBack.layer.shadowOpacity = 1;
            viewForBack.tag = 1111+i;
            viewForBack.layer.shadowOffset = CGSizeMake(0, 2);
            viewForBack.layer.shadowColor = shadowColorForText;
            [_labelForAllText addSubview:viewForBack];
            [_arrForAllView addObject:viewForBack];
            
            UILabel *labelForCount = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0,yForCount, widthForCount, [arrForHeight[i] floatValue])];
            labelForCount.attributedText = arrForM[i];
            labelForCount.numberOfLines = 0;
            // labelForCount.backgroundColor = [UIColor orangeColor];
            labelForCount.font = [UIFont systemFontOfSize:16];
            labelForCount.textAlignment = NSTextAlignmentJustified;
            [_labelForAllText addSubview:labelForCount];
            [_arrForAllLabel addObject:labelForCount];
            
            
        }else{
            
            UIView *viewForNext = [_labelForAllText viewWithTag:1111 + i - 1];
            UIView *viewForBack = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0 - 10, viewForNext.bottom + pageForLabel, widthForCount + 20, [arrForHeight[i] floatValue] + 20)];
            viewForBack.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:249 / 255.0 blue:244 / 255.0 alpha:1];
            viewForBack.layer.shadowOpacity = 1;
            viewForBack.tag = 1111+i;
            viewForBack.layer.shadowOffset = CGSizeMake(0, 2);
            viewForBack.layer.shadowColor = shadowColorForText;
            [_labelForAllText addSubview:viewForBack];
            [_arrForAllView addObject:viewForBack];
            
            UILabel *labelForCount = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0,viewForNext.bottom + pageForLabel + 10, widthForCount,[arrForHeight[i] floatValue])];
            labelForCount.attributedText = arrForM[i];
            labelForCount.numberOfLines = 0;
            //    labelForCount.backgroundColor = [UIColor orangeColor];
            labelForCount.font = [UIFont systemFontOfSize:16];
            labelForCount.textAlignment = NSTextAlignmentJustified;
            [_labelForAllText addSubview:labelForCount];
            [_arrForAllLabel addObject:labelForCount];
            _heightForBg = viewForBack.bottom;
            
        }
        
        
        
    }
    
    
    _labelForAllText.frame = CGRectMake(0, countViewForLiunian.bottom + pageForGongAndCount, kScreenWidth - widthForSliderView, _heightForBg);
    _labelForAllText.backgroundColor = [UIColor clearColor];
    
    
    
    bgScrollView.contentSize = CGSizeMake(kScreenWidth + kWidthForSliderView + 1, _labelForAllText.bottom + 20);
    
    
    
    

}

#pragma mark - 侧栏代理方法
//请求侧边栏的方法
- (void)returnLabelCount:(NSInteger)number
{
    _numberNow = number;
    
    [self netAction];
    
    //是否有缓存，有缓存走缓存的方法        人名字和按钮tag做key存储 return
    NSString *strKey = [NSString stringWithFormat:@"%@_%ld",self.name,_numberNow];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:strKey]) {
        
        
        [self acitonForContent:[[NSUserDefaults standardUserDefaults] objectForKey:strKey]];
        
        return;
    }
    
    if (number == 1) {

        
    }else{
    
      //先删除之前label上的所有内容
        
        if (_arrForAllLabel.count != 0 ) {
            
            for (int i = 0; i < _arrForAllLabel.count; i++) {
                
                UILabel *labelForBefore = [_arrForAllLabel objectAtIndex:i];
                [labelForBefore removeFromSuperview];
                
            }
           
            [_arrForAllLabel removeAllObjects];
            
            
        }
        if(_arrForAllView.count != 0){
            
            for (int i = 0; i < _arrForAllView.count; i++) {
                
                UIView *viewForBefore = _arrForAllView[i];
                
                [viewForBefore removeFromSuperview];
                
            }
            
            [_arrForAllView removeAllObjects];
            
        }
        if (_arrForLockView.count != 0) {
            
            for (int i = 0; i < _arrForLockView.count; i++) {
                
                UIView *viewForLock = _arrForLockView[i];
                
                [viewForLock removeFromSuperview];
                
            }
            
            [_arrForLockView removeAllObjects];
        }
        
        
        //没有付钱，则显示出这个画面 return
        if (_isMoney == NO) {
            

            _viewForLock = [[UIView alloc] initWithFrame:CGRectMake(0, countViewForLiunian.bottom + pageForGongAndCount, kScreenWidth - widthForSliderView, heightForLockView)];
            _viewForLock.backgroundColor = colorForCountView;
            _viewForLock.layer.shadowOpacity = 1;
            _viewForLock.layer.shadowOffset = CGSizeMake(0, 2);
            _viewForLock.layer.shadowColor = shadowColorForText;
            [bgScrollView addSubview:_viewForLock];
            [_arrForLockView addObject:_viewForLock];
            bgScrollView.contentSize = CGSizeMake(kScreenWidth + kWidthForSliderView + 1, _viewForLock.bottom + 20);
            
            //解锁按钮相当于整个view
            UIButton *btnForLockAl = [UIButton buttonWithType:UIButtonTypeSystem];
            btnForLockAl.frame = CGRectMake(0, 0,  kScreenWidth - widthForSliderView, heightForLockView);
            [btnForLockAl addTarget:self action:@selector(actionForLock) forControlEvents:UIControlEventTouchUpInside];
            [_viewForLock addSubview:btnForLockAl];
            
            //解锁按钮
            UIButton *btnForLock = [UIButton buttonWithType:UIButtonTypeCustom];
            btnForLock.frame = CGRectMake(xForLockBtn, yForLockBtn, widthForLockBtn, heightForLockBtn);
            [btnForLock setImage:[UIImage imageNamed:@"解锁"] forState:UIControlStateNormal];
            //[btnForLock addTarget:self action:@selector(actionForLock) forControlEvents:UIControlEventTouchUpInside];
            btnForLock.userInteractionEnabled = NO;
            [_viewForLock addSubview:btnForLock];
            [_arrForLockView addObject:btnForLock];
            
            UILabel *labelForBtn = [[UILabel alloc]initWithFrame:CGRectMake(0, btnForLock.bottom + pageForLockLabel, kScreenWidth - widthForSliderView, 15)];
            labelForBtn.text = @"解锁可查看以下内容";
            labelForBtn.font = [UIFont systemFontOfSize:13];
            labelForBtn.textColor = [UIColor redColor];
            labelForBtn.textAlignment = NSTextAlignmentCenter;
            [_viewForLock addSubview:labelForBtn];
            [_arrForLockView addObject:labelForBtn];
            
            
            
            //感情
            UIImageView *imageViewForGanqing = [[UIImageView alloc] initWithFrame:CGRectMake(xForLockBtn, btnForLock.bottom + pageForLockBtn, widthForLockBtn, heightForLockBtn)];
            imageViewForGanqing.image = [UIImage imageNamed:@"感情"];
            [_viewForLock addSubview:imageViewForGanqing];
            [_arrForLockView addObject:imageViewForGanqing];
            
            UILabel *labelForGanqing = [[UILabel alloc]initWithFrame:CGRectMake(0, imageViewForGanqing.bottom + pageForLockLabel, kScreenWidth - widthForSliderView, 15)];
            labelForGanqing.text = @"现今状况以及以后的变化";
            labelForGanqing.font = [UIFont systemFontOfSize:14];
            labelForGanqing.textAlignment = NSTextAlignmentCenter;
            [_viewForLock addSubview:labelForGanqing];
            [_arrForLockView addObject:labelForGanqing];
            
            
            
            //开运
            UIImageView *imageViewForKaiyun = [[UIImageView alloc]initWithFrame:CGRectMake(xForLockBtn, imageViewForGanqing.bottom + pageForLockBtn, widthForLockBtn, heightForLockBtn)];
            imageViewForKaiyun.image = [UIImage imageNamed:@"开运"];
            [_viewForLock addSubview:imageViewForKaiyun];
            [_arrForLockView addObject:imageViewForKaiyun];
            
            
            UILabel *labelForKaiyun = [[UILabel alloc]initWithFrame:CGRectMake(0, imageViewForKaiyun.bottom + pageForLockLabel, kScreenWidth - widthForSliderView, 15)];
            labelForKaiyun.textAlignment = NSTextAlignmentCenter;
            labelForKaiyun.text = @"生活中需要注意";
            labelForKaiyun.font = [UIFont systemFontOfSize:14];
            [_viewForLock addSubview:labelForKaiyun];
            [_arrForLockView addObject:labelForKaiyun];
            
            
            return;
            
        }
        
        
        //付钱以后走的方法
        NSString *strForZiwei = self.arrForZM[0];
        NSString *strForMinggong = self.arrForZM[1];
        NSLog(@"紫薇在%@",self.arrForZM[0]);
        NSLog(@"命宫在%@",self.arrForZM[1]);
        
        NSString *str = [NSString stringWithFormat:@"http://xuanji.jyhd.com/year2016/queryPan?ziWei=%@&mingGong=%@&fortuneNum=%ld",strForZiwei,strForMinggong,number];
        
        
        NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
       
        //从URL获取json数据
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            NSString *html = operation.responseString;
            NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
            id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
            NSLog(@"获取到的数据为：%@",dict);
            
            NSDictionary *dic = dict;
            
            NSString *strKey = [NSString stringWithFormat:@"%@_%ld",self.name,_numberNow];
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:strKey];
            
            NSString *str = dic[@"advice"];
            
            NSArray *arrForG = dic[@"gong"];
            
            NSMutableArray *arrForM = [NSMutableArray array];
            NSMutableArray *arrForHeight = [NSMutableArray array];
            NSMutableArray *arrForString = [NSMutableArray array];
            
            /**
             *  创建内容
             */
            for (int i = 0; i < arrForG.count; i++) {
                
                NSDictionary *dicForG = arrForG[i];
                
                NSArray *arrForConunt = [dicForG objectForKey:dicForG.allKeys[0]];
                
                NSDictionary *dicForCount1 = arrForConunt[0];
                
                
                NSString *gongName = dicForG.allKeys[0];
                NSString *gongBazi = dicForCount1.allKeys[0];
                NSString *gongCount = [dicForCount1 objectForKey:dicForCount1.allKeys[0]];
                
                
                //宫名字、八字
                NSString *aStrForGNmae = [NSString stringWithFormat:@"%@\n%@\n%@",gongName,gongBazi,gongCount];
                NSMutableAttributedString *strGong1111 = [[NSMutableAttributedString alloc]initWithString:aStrForGNmae];
                [strGong1111 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, gongName.length + gongBazi.length + 1 )];
                CGFloat heightForCount = [self returnCountHeight:strGong1111 andNSString:aStrForGNmae];
                
                [arrForString addObject:aStrForGNmae];
                [arrForM addObject:strGong1111];
                [arrForHeight addObject:@(heightForCount)];
                
                
                NSLog(@"建议：%@",str);
                NSLog(@"宫：%@",dicForG.allKeys[0]);
                NSLog(@"宫%d标题：%@",i,dicForCount1.allKeys[0]);
                NSLog(@"宫%d内容：%@",i,[dicForCount1 objectForKey:dicForCount1.allKeys[0]]);
                
            }
            
            
            /**
             *  建议的内容
             */
            NSString *gongAdvance = [NSString stringWithFormat:@"开运建议:%@",dic[@"advice"]];
            [arrForString addObject:gongAdvance];
            
            NSMutableAttributedString *strGong1111 = [[NSMutableAttributedString alloc]initWithString:gongAdvance];
            
            
            [strGong1111 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
            [arrForM addObject:strGong1111];
            
            CGFloat heightForAdvice = [self returnCountHeight:strGong1111 andNSString:gongAdvance];
            [arrForHeight addObject:@(heightForAdvice)];
            
            
            //根据高度创建label
            for (int i = 0; i < arrForHeight.count; i++) {
                
                if (i == 0) {
                    
                    UIView *viewForBack = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0 - 10, yForCount - 10, widthForCount + 20, [arrForHeight[i] floatValue] + 40)];
                    viewForBack.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:249 / 255.0 blue:244 / 255.0 alpha:1];
                    viewForBack.layer.shadowOpacity = 1;
                    viewForBack.tag = 1111+i;
                    viewForBack.layer.shadowOffset = CGSizeMake(0, 2);
                    viewForBack.layer.shadowColor = shadowColorForText;
                    [_labelForAllText addSubview:viewForBack];
                    [_arrForAllView addObject:viewForBack];
                    
                    UILabel *labelForCount = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0,yForCount, widthForCount, [arrForHeight[i] floatValue] + 20)];
                    labelForCount.attributedText = arrForM[i];
                    labelForCount.numberOfLines = 0;
                    labelForCount.font = [UIFont systemFontOfSize:16];
                 //   labelForCount.backgroundColor = [UIColor orangeColor];
                    labelForCount.textAlignment = NSTextAlignmentJustified;
                    [_labelForAllText addSubview:labelForCount];
                    [_arrForAllLabel addObject:labelForCount];
                    
                    
                }else{
                    
                    UIView *viewForNext = [_labelForAllText viewWithTag:1111 + i - 1];
                    UIView *viewForBack = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0 - 10, viewForNext.bottom + pageForLabel, widthForCount + 20, [arrForHeight[i] floatValue] + 40)];
                    viewForBack.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:249 / 255.0 blue:244 / 255.0 alpha:1];
                    viewForBack.layer.shadowOpacity = 1;
                    viewForBack.tag = 1111+i;
                    viewForBack.layer.shadowOffset = CGSizeMake(0, 2);
                    viewForBack.layer.shadowColor = shadowColorForText;
                    [_labelForAllText addSubview:viewForBack];
                    [_arrForAllView addObject:viewForBack];
                    
                    UILabel *labelForCount = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - widthForSliderView - widthForCount) / 2.0,viewForNext.bottom + pageForLabel + 10, widthForCount,[arrForHeight[i] floatValue] + 20)];
                    labelForCount.attributedText = arrForM[i];
                    labelForCount.numberOfLines = 0;
                   // labelForCount.backgroundColor = [UIColor orangeColor];

                    labelForCount.font = [UIFont systemFontOfSize:16];
                    labelForCount.textAlignment = NSTextAlignmentJustified;
                    [_labelForAllText addSubview:labelForCount];
                    [_arrForAllLabel addObject:labelForCount];
                    _heightForBg = viewForBack.bottom;
                    
                }
   
            }
            
            
            _labelForAllText.frame = CGRectMake(0, countViewForLiunian.bottom + pageForGongAndCount, kScreenWidth - widthForSliderView, _heightForBg);
            _labelForAllText.backgroundColor = [UIColor clearColor];
            bgScrollView.contentSize = CGSizeMake(kScreenWidth + kWidthForSliderView + 1, _labelForAllText.bottom + 20);
 
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"请求失败");
            
        }];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperation:operation];
        
    }

}



#pragma mark - ScrollView代理方法
//减速的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  
   // scrollView.directionalLockEnabled = YES;
    //[self isBack:YES];

}

//开始滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    NSLog(@"初始值：x = %lf",scrollView.contentOffset.x);
//    NSLog(@"初始值:y = %lf",scrollView.contentOffset.y);
    
    //当ScrollView滑动的时候不接受操作
    scrollView.directionalLockEnabled = YES;


//    if (scrollView.contentOffset.y != 0) {
//        
//        [self isBack:YES];
//        
//        return;
//    }
    
    if (scrollView.contentOffset.x == 0 ) {
        
        [self isBack:YES];

    }else{
    

        [self isBack:NO];
   
    }
    
   
}

/**
 *  移动中间内容和隐藏边栏的方法
 */
- (void)isBack:(BOOL )isBackNow
{
   
    if (isBackNow) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _viewForLock.origin = CGPointMake((kScreenWidth - (kScreenWidth - widthForSliderView)) / 2.0, _viewForLock.origin.y);
            _labelForPrompt.origin = CGPointMake((kScreenWidth - _widthForPrompt) / 2.0, _labelForPrompt.origin.y);
            _labelForAllText.origin = CGPointMake((kScreenWidth - (kScreenWidth - widthForSliderView)) / 2.0, _labelForAllText.origin.y);
            liunianSlider.origin = CGPointMake(kScreenWidth, yForSliderView);
            countViewForLiunian.origin = CGPointMake((kScreenWidth - (kScreenWidth - widthForSliderView)) / 2.0, countViewForLiunian.origin.y);
            _viewForG.origin = CGPointMake(kXforCountView, _viewForG.origin.y);
        } completion:^(BOOL finished) {
            ;
        }];
        
    }else{
    
        [UIView animateWithDuration:0.2 animations:^{
            
             _viewForLock.origin = CGPointMake(0, _viewForLock.origin.y);
            _labelForPrompt.origin = CGPointMake((kScreenWidth - widthForSliderView- _widthForPrompt) / 2.0, _labelForPrompt.origin.y);
            _labelForAllText.origin = CGPointMake(0, _labelForAllText.origin.y);
            liunianSlider.origin = CGPointMake(kScreenWidth - widthForSliderView, yForSliderView);
            countViewForLiunian.origin = CGPointMake(0, countViewForLiunian.origin.y);
            _viewForG.origin = CGPointMake(0, _viewForG.origin.y);
            
        } completion:^(BOOL finished) {
            ;
        }];
    
    }

}



/***************************交钱方法***************************************************/

/**
 *  解锁方法
 */
- (void)actionForLock
{
    
    if (_isNet) {
        
        
    }else{
    
        [self netAction];
        
        return;
    }
    
    if (_isMoneyAlready ) {
        
        NSLog(@"第一次购买还没完成呢，别点了");

        return;
    }
    
    //出现黑色的背景视图遮住主视图
    _viewForClickNeigou = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _viewForClickNeigou.backgroundColor = [UIColor blackColor];
    _viewForClickNeigou.alpha = 0.7;
    _viewForClickNeigou.userInteractionEnabled = NO;
    [self.view addSubview:_viewForClickNeigou];
    
    //当点击购买，所有功能取消
    btnForBack.userInteractionEnabled = NO;
    btnForShare.userInteractionEnabled = NO;
    liunianSlider.userInteractionEnabled = NO;
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

    
    
    NSString *product = @"com.nimei";
    if([SKPaymentQueue canMakePayments]){
        [self requestProductData:product];
        
        _isMoneyAlready = YES;
        
    }else{
        NSLog(@"不允许程序内付费");
    }
    
    NSLog(@"点击出发解锁，交钱方法");
    
    
    
}

/***************************交钱方法**********************************/

//************************购买相关的地方*********************************//
//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSArray *arr =  [response invalidProductIdentifiers];
    
    NSLog(@"无效的产品product ID = %@",arr);
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[response.products count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        if([pro.productIdentifier isEqualToString:@"com.nimei"]){
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];

    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc]initWithObjects:type,nil, nil];

    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    
    request.delegate = self;
    [request start];
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);

    
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
}

//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    
    for(SKPaymentTransaction *transaction in transactions){
        
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                
                NSLog(@"交易完成");
                
                _isMoneyAlready = NO;
                
                btnForBack.userInteractionEnabled = YES;
                btnForShare.userInteractionEnabled = YES;
                liunianSlider.userInteractionEnabled = YES;

                //存储购买信息
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:self.name];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:self.burnDay];
                
                _isMoney = YES;
                
                [self returnLabelCount:_numberNow];

                [_viewForClickNeigou removeFromSuperview];

                
                break;
            case SKPaymentTransactionStatePurchasing:
                
                
                NSLog(@"商品添加进列表");
                
                break;
            case SKPaymentTransactionStateRestored:
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                
                NSLog(@"已经购买过商品");
                
                _isMoneyAlready = NO;
                
                break;
            case SKPaymentTransactionStateFailed:
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                
                NSLog(@"交易失败");
                
                _isMoneyAlready = NO;
                
                btnForBack.userInteractionEnabled = YES;
                btnForShare.userInteractionEnabled = YES;
                liunianSlider.userInteractionEnabled = YES;

                
                [_viewForClickNeigou removeFromSuperview];
                
                break;
            default:
                break;
        }
    }
    
    

    
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


-(void)dealloc
{
   
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];

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
