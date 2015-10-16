//
//  ZodiacDetailedViewController.m
//  fleetingFortune
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 金源互动. All rights reserved.
//

#import "ZodiacDetailedViewController.h"
#import "YincangTableViewCell.h"
#import "NSData+Base64.h"
#import "EncryptAndDecrypt.h"
#import "UMSocial.h"
#define pageHeightBtn 20 / 1334.0 * kScreenHeight


#define shadowColorForText [UIColor colorWithRed:177 / 255.0 green:137 / 255.0 blue:122 / 255.0 alpha:0.5].CGColor

#define  shengXiaoYunChengTabView  [_zhuanHuanYuanStr isEqualToString:@"生肖运程"]
#define  liuShiJiaZhiTabView  [_zhuanHuanYuanStr isEqualToString:@"六十甲子"]
#define  liuYueTabView  [_zhuanHuanYuanStr isEqualToString:@"流月"]

#define labelColor  [UIColor colorWithRed:139 / 255.0 green:97 / 255.0 blue:82 / 255.0 alpha:1]

#define btnFontColor  [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1]

#define BtnBackColor  [UIColor colorWithRed:232/255.0 green:113/255.0 blue:113/255.0 alpha:1.0]

#define celanBackColor [UIColor colorWithRed:197/255.0 green:187/255.0 blue:174/255.0 alpha:1.0]

#define headerBackColor [UIColor colorWithRed:251/255.0 green:245/255.0 blue:237/255.0 alpha:1.0]

//#define widthForBtn 233 / 750.0 * kScreenWidth
//#define heightForBtn 88 / 1334.0 * kScreenHeight
//#define yFotBtn (160 / 2.0 - 88 / 2.0) / 1334.0 * kScreenHeight


#define widthForBtn 223 / 750.0 * kScreenWidth
#define heightForBtn 88 / 1334.0 * kScreenHeight
#define yFotBtn (128 / 2.0 - 88 / 2.0) / 1334.0 * kScreenHeight

#define HeightForSc kScreenHeight/1334.0




@interface ZodiacDetailedViewController ()

//bolck
typedef void(^dataBlock)(NSObject *result, NSData *data);

//自定义cell用于判断点击那个Cell的indexPath
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

//根据一个字符串判断应该显示的内容
@property(nonatomic,strong)NSString  * zhuanHuanYuanStr;

//生肖运程cell上显示的title数组
@property (strong,nonatomic)NSArray * shengxiaoArr;

//流年运程cell上显示的title数组
@property (strong,nonatomic)NSMutableArray * liunianyunchengArray;

//生肖运程内容array
@property(strong,nonatomic)NSArray * zodicaContentArr;

//流年运程内容array
@property(strong,nonatomic)NSMutableArray * liunianContentArr;

//流年的年份
@property(strong,nonatomic)NSMutableArray * yearArray;

//生肖婚配页面的ScrollView
@property (strong,nonatomic)UIScrollView * hunpeiScrollView;

//刑冲迫害信息
@property(strong,nonatomic)NSString * xinchongDetail;

//生肖婚配资料Str
@property(nonatomic,strong)NSString * zodicMating;
@property(nonatomic,strong)NSString * zodicMating2;

//页面的ScrollView
@property(strong,nonatomic)UIScrollView * zhuScroll;

//字体大小
@property(nonatomic)CGFloat fontSize;


@property(strong,nonatomic)NSDictionary * liuyueDict;
@end

@implementation ZodiacDetailedViewController{
    
    NSArray *liuyueArray;
    
    UIButton * shengxiaoHunpeiBtn;//生肖婚配Btn
    
    UIButton * liushijiazhiBtn;//六十甲子btn
    
    UIButton * shengxiaoYunchengBtn;//生肖运程Btn
    
    UIButton * xckhButton; //刑冲破害Btn
    
    UIButton * liuyueButton;//流月btn
    
    NSDictionary * sxmcDict;//放十二生肖与上传数字的字典
    
    UITextView * xckhTextView;//刑冲破害TextView
    
    NSMutableArray * array4;
    
    //标签栏View(四个button)
    UIView * navigationView;
    
    //titleView
    UIView  * titleView;
    
    //背景图片
    UIImageView * backImageView;
    
    //cell上面的三角
    UIImageView * imageView;
    
    BOOL isflag[20];
    
    NSMutableArray * imageArray;//十二个生肖的图片
}

#pragma 你懂得
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    _zodicaContentArr = [NSArray array];
    _liunianContentArr = [NSMutableArray array];
    _yearArray = [NSMutableArray array];
    _liunianyunchengArray = [NSMutableArray array];
    _liuyueDict = [NSDictionary dictionary];
    
    
    // 将初始页面设置为生肖运程
    _zhuanHuanYuanStr = @"生肖运程";
    
    //没请求下数据之前显示正在加载中
    [AppHelper showHUD:@"正在加载中"];
    
    //初始化生肖运程cell的title
    _shengxiaoArr = @[@"整体运势",@"事业运势",@"财富运势",@"感情运势",@"健康运势"];
    
    
    _fontSize = 17;
    if (kScreenHeight == iPhone4S) {
        
        _fontSize = 14;
    }else if (kScreenHeight == iPhone5S){
        
        _fontSize = 14;
        
    }else{
        _fontSize = 17;
    }
    
    
    sxmcDict = @{ @(0):@"鼠",
                  @(1):@"牛",
                  @(2):@"虎",
                  @(3):@"兔",
                  @(4):@"龙",
                  @(5):@"蛇",
                  @(6):@"马",
                  @(7):@"羊",
                  @(8):@"猴",
                  @(9):@"鸡",
                  @(10):@"狗",
                  @(11):@"猪"};
    
    NSString * url = [NSString stringWithFormat:@"http://xuanji.jyhd.com/year2016/queryFortuneAction?zodiacIndex=%ld",(long)self.zodiac];
    [self requestWithURL:url params:nil];
    
    imageArray = [NSMutableArray array];
    for (int i = 1; i < 13;i ++ ) {
        NSString * str = [NSString stringWithFormat:@"%d.png",i];
        UIImage * shuxiangImage = [UIImage imageNamed:str];
        [imageArray addObject:shuxiangImage];
    }

    //设置UI
    [self setUI];

    //刚开始初始侧滑栏出来状态
    [self leftSwipes:self];
    
    //出来手势
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipes:)];
    swipeGestureRecognizer.delegate = self;
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeGestureRecognizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    //回去手势
    UISwipeGestureRecognizer *rswipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipes:)];
    rswipeGestureRecognizer.delegate = self;
    rswipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    rswipeGestureRecognizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:rswipeGestureRecognizer];
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [_myTableView addGestureRecognizer:singleRecognizer];
    
}

//设置UI
- (void)setUI {
    
    titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 128 * HeightForSc)];
    titleView.backgroundColor = [UIColor colorWithRed:139 / 255.0 green:97 / 255.0 blue:82 / 255.0 alpha:1.000];
    titleView.userInteractionEnabled = YES;
    [self.view addSubview:titleView];
    
    //背景图片
    backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleView.bottom,kScreenWidth, kScreenHeight - titleView.height)];
    backImageView.userInteractionEnabled = YES;
    UIImage * backImage = [UIImage imageNamed:@"xinbeijing.png"];
    backImageView.image = backImage;
    [self.view addSubview:backImageView];

    //返回按钮
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, yFotBtn + pageHeightBtn, widthForBtn, 88 * HeightForSc)];
    UIImage * backmage = [UIImage imageNamed:@"lback.png"];
    [backButton setImage:backmage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backButton];
    
    //分享按钮
    UIButton * shareButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - widthForBtn, yFotBtn + pageHeightBtn, widthForBtn, 88 * HeightForSc)];
    UIImage * fximage = [UIImage imageNamed:@"分享按钮.png"];
    [shareButton setBackgroundImage:fximage forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(clickshare:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:shareButton];
    
    //titleLbl

    

    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, titleView.height/2 - 40* HeightForSc/2 + pageHeightBtn, kScreenWidth, 40* HeightForSc)];
    titleLbl.text = [NSString stringWithFormat:@"%@属相",sxmcDict[@(_zodiac)]];
    titleLbl.font = [UIFont systemFontOfSize:22.0];
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.textAlignment = UIBaselineAdjustmentAlignCenters;
    [titleView addSubview:titleLbl];
    
    //tableview
    _myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, backImageView.height  - 10) style:UITableViewStylePlain];
    //    _myTableView.opaque = YES;
    //     //titleView
  
    _myTableView.separatorStyle = UITextAutocapitalizationTypeNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    //_myTableView.bounces = NO;
    //_myTableView.scrollEnabled = NO;
    _myTableView.contentSize = CGSizeMake(320,960);
    _myTableView.backgroundColor = [UIColor clearColor];
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor clearColor]];

    [backImageView addSubview:_myTableView];
    
    
    //婚配ScorllView
    _zhuScroll = [[UIScrollView alloc]initWithFrame:
                  CGRectMake(0,0, kScreenWidth, kScreenHeight + 100)];
    
    _zhuScroll.backgroundColor = [UIColor clearColor];
    _zhuScroll.scrollEnabled = YES;
    
    if (kScreenHeight == iPhone4S) {
        _zhuScroll.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 250);

    }else{
        _zhuScroll.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 200);

    }
    _zhuScroll.hidden = YES;
    [backImageView addSubview:_zhuScroll];
    
    //标签栏View(四个button)
    navigationView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth, titleView.bottom, 50 * (kScreenWidth / 375), kScreenHeight - titleView.height)];
    navigationView.backgroundColor = celanBackColor;
    [self.view addSubview:navigationView];
    
    //五个选项
    //生肖运程Btn
    shengxiaoYunchengBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,navigationView.frame.size.width,90* (kScreenHeight / 667.0))];
    shengxiaoYunchengBtn.tag = 1101;
    //    UIImage * sxseleimage = [UIImage imageNamed:@"sxSel"];
    //    [shengxiaoYunchengBtn setBackgroundImage:sxseleimage forState:UIControlStateNormal];
    shengxiaoYunchengBtn.backgroundColor = BtnBackColor;
    [shengxiaoYunchengBtn setTitleColor:btnFontColor forState:UIControlStateNormal];
    [shengxiaoYunchengBtn setTitle:@"生肖\n运程" forState:UIControlStateNormal];
    shengxiaoYunchengBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    shengxiaoYunchengBtn.titleLabel.numberOfLines = 0;
    shengxiaoYunchengBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shengxiaoYunchengBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:shengxiaoYunchengBtn];
    
    
    //六十甲子Btn
    liushijiazhiBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,shengxiaoYunchengBtn.bottom, navigationView.frame.size.width, 90* (kScreenHeight / 667.0))];
    liushijiazhiBtn.tag = 1102;
    liushijiazhiBtn.backgroundColor = [UIColor clearColor];
     [liushijiazhiBtn setTitleColor:btnFontColor forState:UIControlStateNormal];
    [liushijiazhiBtn setTitle:@"六十\n甲子" forState:UIControlStateNormal];
    liushijiazhiBtn.titleLabel.numberOfLines = 0;
    liushijiazhiBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    
    [liushijiazhiBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview: liushijiazhiBtn];
    
    //流月
    liuyueButton = [[UIButton alloc]initWithFrame:CGRectMake(0, liushijiazhiBtn.bottom, navigationView.frame.size.width, 90 * (kScreenHeight / 667.0))];
    liuyueButton.tag = 1105;
      [liuyueButton setTitleColor:btnFontColor forState:UIControlStateNormal];
    liuyueButton.backgroundColor = [UIColor clearColor];
    [liuyueButton setTitle:@"流月" forState:UIControlStateNormal];
    [liuyueButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    liuyueButton.titleLabel.font = [UIFont systemFontOfSize:15];

    [navigationView addSubview:liuyueButton];
    
    
    //生肖婚配Btn
    shengxiaoHunpeiBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,liuyueButton.bottom, navigationView.frame.size.width, 90* (kScreenHeight / 667.0))];
    shengxiaoHunpeiBtn.tag = 1103;
    shengxiaoHunpeiBtn.backgroundColor = [UIColor clearColor];
      [shengxiaoHunpeiBtn setTitleColor:btnFontColor forState:UIControlStateNormal];
    shengxiaoHunpeiBtn.titleLabel.numberOfLines = 0;
    [shengxiaoHunpeiBtn setTitle:@"婚配" forState:UIControlStateNormal];
    [shengxiaoHunpeiBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    shengxiaoHunpeiBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [navigationView addSubview:shengxiaoHunpeiBtn];
    
    //刑冲破害
    xckhButton = [[UIButton alloc]initWithFrame:CGRectMake(0,shengxiaoHunpeiBtn.bottom, navigationView.frame.size.width, 90* (kScreenHeight / 667.0))];
    xckhButton.tag = 1104;
    xckhButton.titleLabel.numberOfLines = 0;
      [xckhButton setTitleColor:btnFontColor forState:UIControlStateNormal];
    xckhButton.backgroundColor = [UIColor clearColor];
    [xckhButton setTitle:@"刑破" forState:UIControlStateNormal];
    xckhButton.titleLabel.font = [UIFont fontWithName:@"STHeitiK-Medium" size:15];
    [xckhButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:xckhButton];
    
    
}

//出来手势
-(void)leftSwipes:(id) sender{
    
    if (navigationView.frame.origin.x == kScreenWidth) {
        NSLog(@"出来手势");

        [UIView animateWithDuration:0.2 animations:^{
            navigationView.frame = CGRectMake(kScreenWidth - 50* (kScreenWidth / 375),titleView.bottom, 50* (kScreenWidth / 375), kScreenHeight - titleView.height);
            backImageView.frame = CGRectMake(0 - 50* (kScreenWidth / 375),titleView.bottom,kScreenWidth , kScreenHeight - titleView.height);
        }];
    }
  
}

//点击手势
-(void)handleSingleTapFrom{
    [self rightSwipes:self];
}

//回去手势
-(void)rightSwipes:(id) sender{
    
    if (navigationView.frame.origin.x == kScreenWidth - 50* (kScreenWidth / 375)) {
        [UIView animateWithDuration:0.2 animations:^{
            navigationView.frame = CGRectMake(kScreenWidth,titleView.bottom, 50* (kScreenWidth / 375), kScreenHeight - titleView.height);
            
               backImageView.frame = CGRectMake(0,titleView.bottom,kScreenWidth , kScreenHeight - titleView.height);
        }];
 
    }
}

//生肖婚配
-(void)ZodiacMatingData:(NSString * )zodicMating{
    
    //zodicMating =
    if (_zodicMating != zodicMating && ![zodicMating isEqual:[NSNull null]]) {
        _zodicMating = zodicMating;

        NSString * zodicStr =[zodicMating stringByReplacingOccurrencesOfString:@"　" withString:@""];

        array4 = [NSMutableArray array];
        
        NSArray *array = [zodicStr componentsSeparatedByString:@"。"]; //从字符A中分隔成2个元素的数组
        NSArray* array2 = [NSArray array];
        for (int i = 0; i < array.count; i ++) {
            array2 = [array[i] componentsSeparatedByString:@"？"];
            [array4 addObject:array2];
        }
        NSLog(@"%@",array4);
        
        UILabel * label;
        
        
        for (int i = 0; i < array4.count; i++) {
            
          
            if ([array4[i][0] isEqualToString:@""]) {
                NSLog(@"i===========%d",i);
            }else if(i == 0){
                
                
                UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, backImageView.width, 40)];
                titleLbl.text = [NSString stringWithFormat:@"【%@】",array4[0][0]];
                titleLbl.textColor = [UIColor colorWithRed:201.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:1];
                
                titleLbl.tag = 499;
                [_hunpeiScrollView addSubview:titleLbl];
                
//                //那些年
//                UILabel * nianxianLbl = [[UILabel alloc]initWithFrame:CGRectZero];
//                nianxianLbl.text = array4[0][0];
//                
//                nianxianLbl.numberOfLines = 0;
//                
//                NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
//                CGSize tempSize = [nianxianLbl.text boundingRectWithSize:CGSizeMake(hpbackImageView.width -28,211) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//                [nianxianLbl setFrame:CGRectMake(28/2 ,titleLbl.bottom + 10,tempSize.width,tempSize.height)];
//                nianxianLbl.textColor = [UIColor colorWithRed:106.0/255.0 green:48.0/255.0 blue:44.0/255.0 alpha:1];
//                
//                [_hunpeiScrollView addSubview:nianxianLbl];
//                
//                
//                label = [[UILabel alloc]initWithFrame:CGRectZero];
//                label.numberOfLines = 0;
//                NSMutableString *responseString = [NSMutableString stringWithString:array4[0][1]];
//                label.tag = 501;
//                NSString *strUrl = [responseString stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
//                label.text = strUrl;
//                
//                NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
//                CGSize tempSize2 = [label.text boundingRectWithSize:CGSizeMake(hpbackImageView.width -28,200) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;
//                [label setFrame:CGRectMake(28/2 ,nianxianLbl.bottom +10,tempSize2.width,tempSize2.height)];
//                
//                label.textColor =[UIColor colorWithRed:106.0/255.0 green:48.0/255.0 blue:44.0/255.0 alpha:1];
//                [_hunpeiScrollView addSubview:label];
                
            }else{
                
              
                
                UILabel * lbl = (UILabel *)[self.view viewWithTag:499];
                label = [[UILabel alloc]initWithFrame:CGRectMake(28/2,(lbl.bottom)  + 50 * (i-1), backImageView.width - 28, 50)];
                label.numberOfLines = 0;
                
                NSString * biaoti = [NSString stringWithFormat:@"%@\n ",array4[i][0]];
                
                NSString * neirong = array4[i][1];
                
                
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[biaoti stringByAppendingString:neirong]];
                
                //设置颜色
                
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:201.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:1] range:NSMakeRange(0, biaoti.length)]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度
                
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:106.0/255.0 green:48.0/255.0 blue:44.0/255.0 alpha:1] range:NSMakeRange(biaoti.length, neirong.length)]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度
                //            //设置尺寸
                //
                //            [attributedString addAttribute:NSFontAttributeName value:kFont17 range:NSMakeRange(0, _price.length)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
                //
                //这段代码必须要写 否则没效果
                
                label.attributedText = attributedString ;
                label.font = [UIFont systemFontOfSize:_fontSize];
                //label.textAlignment = NSTextAlignmentCenter;
                [_zhuScroll addSubview:label];
            }
        }
        
        
    }
}

//刑冲破害
-(void)xingChongPoHai:(id)xincongpehaixinxi{
    
    if (_xinchongDetail != xincongpehaixinxi) {
        _xinchongDetail = xincongpehaixinxi;
        
        xckhTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 10,backImageView.width,backImageView.height-30)];
        xckhTextView.text = _xinchongDetail;
        xckhTextView.editable = NO;
        
        xckhTextView.textColor = [UIColor colorWithRed:106.0/255.0 green:48.0/255.0 blue:44.0/255.0 alpha:1];
        xckhTextView.font = [UIFont systemFontOfSize:18];
        xckhTextView.backgroundColor = [UIColor clearColor];
        [backImageView addSubview:xckhTextView];
    }
}

//按钮方法
-(void)clickBtn:(UIButton * )sender{
    [self rightSwipes:sender];
    if (sender.tag == 1101) {//生肖运程
        [self isflagISyesOrNo];
        _zhuanHuanYuanStr = @"生肖运程";
        _zhuScroll.hidden = YES;
        xckhTextView.hidden = YES;
        _myTableView.hidden = NO;
        _myTableView.frame =CGRectMake(0, 0, kScreenWidth, backImageView.height  +10);

        [_myTableView reloadData];
        
        shengxiaoYunchengBtn.backgroundColor = BtnBackColor;
        shengxiaoHunpeiBtn.backgroundColor = [UIColor clearColor];
        liuyueButton.backgroundColor = [UIColor clearColor];
        liushijiazhiBtn.backgroundColor = [UIColor clearColor];
        xckhButton.backgroundColor = [UIColor clearColor];
        
    }else if(sender.tag == 1102){//六十甲子
        
        [self isflagISyesOrNo];

         _zhuanHuanYuanStr = @"六十甲子";
        _zhuScroll.hidden = YES;
        xckhTextView.hidden = YES;
        _myTableView.hidden = NO;
        _myTableView.frame =CGRectMake(0, 10, kScreenWidth, backImageView.height-10);

        //初始化流年运程Cell的title
        [_liunianyunchengArray removeAllObjects];
        for (int i = 0; i < _yearArray.count;i ++ ) {
            [_liunianyunchengArray addObject:[NSString stringWithFormat:@"%@年%@属相2016年运程",_yearArray[i],sxmcDict[@(_zodiac)]]];
        }
        
        
        [_myTableView reloadData];

        shengxiaoYunchengBtn.backgroundColor = [UIColor clearColor];
        shengxiaoHunpeiBtn.backgroundColor = [UIColor clearColor];
        liuyueButton.backgroundColor = [UIColor clearColor];
        liushijiazhiBtn.backgroundColor = BtnBackColor;
        xckhButton.backgroundColor = [UIColor clearColor];
        
        
    }else if(sender.tag == 1103){//生肖婚配

        _myTableView.hidden = YES;
        xckhTextView.hidden = YES;
        _zhuScroll.hidden = NO;
     
        shengxiaoYunchengBtn.backgroundColor =[UIColor clearColor] ;
        shengxiaoHunpeiBtn.backgroundColor =BtnBackColor ;
        liuyueButton.backgroundColor = [UIColor clearColor];
        liushijiazhiBtn.backgroundColor = [UIColor clearColor];
        xckhButton.backgroundColor = [UIColor clearColor];
  
        [self ZodiacMatingData:_zodicMating2];
        
    }else if (sender.tag == 1104){//刑冲破害
        _zhuScroll.hidden = YES;
        xckhTextView.hidden = NO;
        xckhTextView.contentOffset = CGPointMake(0, 0);
        _myTableView.hidden = YES;
        
        [self xingChongPoHai:xckhxinxi];
        
        shengxiaoYunchengBtn.backgroundColor =[UIColor clearColor] ;
        shengxiaoHunpeiBtn.backgroundColor = [UIColor clearColor];
        liuyueButton.backgroundColor = [UIColor clearColor];
        liushijiazhiBtn.backgroundColor = [UIColor clearColor];
        xckhButton.backgroundColor = BtnBackColor;

    }else{
        _zhuanHuanYuanStr = @"流月";
        _zhuScroll.hidden = YES;
        xckhTextView.hidden = YES;
        _myTableView.hidden = NO;
        shengxiaoYunchengBtn.backgroundColor =[UIColor clearColor] ;
        shengxiaoHunpeiBtn.backgroundColor = [UIColor clearColor];
        liuyueButton.backgroundColor = BtnBackColor;
        liushijiazhiBtn.backgroundColor = [UIColor clearColor];
        xckhButton.backgroundColor = [UIColor clearColor];
        [_myTableView reloadData];

    }
}

//如果tableView处于点开状态 那么关闭
-(void)isflagISyesOrNo{
    for (int i = 0; i < 20; i++) {
        if (isflag[i] == YES) {
            isflag[i] = NO;
        }
    }
}

#pragma 网络请求
//传一个Url与数据字典
- (id)requestWithURL:( NSString *)url params:( NSDictionary *)params {
    
    NSMutableURLRequest *request = [ NSMutableURLRequest requestWithURL :[ NSURL URLWithString :url]];
    
    
    [request setHTTPMethod : @"GET" ];
    
    
    // 发送请求
    AFHTTPRequestOperation *requstOperation = [[ AFHTTPRequestOperation alloc ] initWithRequest :request];
    
    // 设置返回数据的解析方式 (这里暂时只设置了json解析)
    requstOperation. responseSerializer = [ AFJSONResponseSerializer serializer ];
    
    [requstOperation setCompletionBlockWithSuccess :^( AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"flag"] isEqualToString:@"succ"]) {
            
            NSString * str = responseObject[@"data"];
            //NSString * str = str;
            NSDictionary * data = [self Decrypt:str];
            
            NSDictionary * zodicaDict = data[@"生肖运程"];
            NSString * str1 = zodicaDict[@"整体运势"];
            NSString * str2 = zodicaDict[@"事业运势"];
            NSString * str3 = zodicaDict[@"钱财运势"];
            NSString * str4 = zodicaDict[@"感情运势"];
            NSString * str5 = zodicaDict[@"健康运势"];
            _zodicaContentArr = @[str1,str2,str3,str4,str5];
            
            NSDictionary * liunianDict = data[@"流年运程"];
            
            NSArray *myary = [liunianDict.allKeys sortedArrayUsingComparator:^(NSString * obj1, NSString * obj2){
                return (NSComparisonResult)[obj1 compare:obj2 options:NSNumericSearch];
                
            }];
            
            NSLog(@"%@",myary);
            
            for (int i = 0; i < myary.count; i++) {
                
                [_yearArray addObject:[myary[i] substringWithRange:NSMakeRange(0, 4)]];
                [_liunianContentArr addObject:liunianDict[myary[i]]];
            }
            
            _zodicMating2 = data[@"生肖运程"][@"生肖婚配"];
            
            
            _liuyueDict = data[@"流月运程"];
            
            
            
            liuyueArray = [_liuyueDict.allKeys sortedArrayUsingComparator:^(NSString * obj1, NSString * obj2){
                return (NSComparisonResult)[obj1 compare:obj2 options:NSNumericSearch];
                
            }];
            
            [_myTableView reloadData];
            
            //如果数据请求到 把hud remove掉
            [AppHelper removeHUD];
            
        }
        
    } failure :^( AFHTTPRequestOperation *operation, NSError *error) {
        
        [AppHelper removeHUD];
//        NSLog(@"%@",error);
//        if (error.code == -1011 || error.code == -1009) {
//            [AppHelper showHUD:@"服务器错误，敬请谅解"];
//            [self performSelector:@selector(remHud) withObject:nil afterDelay:2.0];
//        }else{
//            [AppHelper showHUD:@"请检查网络连接"];
//            [self performSelector:@selector(remHud) withObject:nil afterDelay:3.0];
//            
//        }
        
        
    }];
    
    [requstOperation start ];
    
    return requstOperation;
    
    
}

//解密
- (NSDictionary * )Decrypt:(id)weijiemiData {
    
    
    if (weijiemiData != nil) {
        Byte keyByte[] = {-22,9,54,-99,111,-19,33,20,92,-11,-84,46,-81,127,55,54,-19,39,-21,-120,-9,119,-126,126,-39,-111,114,-119,56,-76,-75,15};
        
        //byte转换为NSData类型，以便下边加密方法的调用
        NSData *keyData = [[NSData alloc] initWithBytes:keyByte length:32];
        
        
        NSData * data = [NSData base64DataFromString:weijiemiData];
        
        NSData *data1 = [data AES256DecryptWithKey:keyData];
        
        //
        //    NSString *str = [[NSString alloc]initWithData:data1 encoding:NSUTF8StringEncoding];
        //      NSLog(@"%@",str);
        //
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data1
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        
        
        
        NSLog(@"%@",dic);
        
        return dic;
        
        
    }else{
        
        return [NSDictionary dictionary];
    }
    
}

//remHud在网络请求不聊得时候
-(void)remHud{
    [AppHelper removeHUD];
}

#pragma tableView 代理及协议方法

//设置有几个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (shengXiaoYunChengTabView) {//生肖运程tableview
       return _shengxiaoArr.count + 1;
        
    }else if (liuShiJiaZhiTabView){//六十甲子tableview
        
        return _liunianyunchengArray.count;
        
    }else if (liuYueTabView){ //流月tableview
        
        return _liuyueDict.allKeys.count;
    }
    return 1;
}

//cell的开合
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (shengXiaoYunChengTabView) {
        if (section == 0) {
            
            return 1;
        }else{
            if (isflag[section] == YES) {
                return 1;
            }else{
                return 0;
            }
        }
    }else if (liuShiJiaZhiTabView){
        
        if (isflag[section] == YES) {
            return 1;
        }else{
            return 0;
        }
        
    }else if (liuYueTabView){
        if (section == 0) {
            
            return 1;
        }else{
            if (isflag[section] == YES) {
                return 1;
            }else{
                return 0;
            }
        }
    }
    return 1;
    
}

//自定义header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headerView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    headerView.layer.shadowOpacity = 1;
    headerView.layer.shadowOffset = CGSizeMake(0, 2);
    headerView.layer.shadowColor = shadowColorForText;
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UILabel * titltLabel = [[UILabel alloc]initWithFrame:CGRectMake(17.5, 0, kScreenWidth, 44)];
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.width - 10 - 10, headerView.height/2- 15/2, 10, 15)];
    titltLabel.textColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];

    if (shengXiaoYunChengTabView) {
        if (section ==0) {
            
        }else{
            titltLabel.text = _shengxiaoArr[section - 1];

        }
 
    }else if (liuShiJiaZhiTabView){
        titltLabel.text = _liunianyunchengArray[section];

    }else if (liuYueTabView){
        if (section == 0) {
            
        }else{
            NSArray *array = [_liuyueDict[liuyueArray[section -1]] componentsSeparatedByString:@":"]; //从字符A中分隔成2个元素的数组
            
            titltLabel.text = array[0];
        }
       
    }
    titltLabel.font = [UIFont systemFontOfSize:17];
    titltLabel.textAlignment = NSTextAlignmentLeft;
    headerView.backgroundColor = headerBackColor;
    [headerView addSubview:titltLabel];
    button.tag = section;
    [button addTarget:self action:@selector(isFlag:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    [headerView addSubview:button];
    [headerView addSubview:imageView];
    
    if (isflag[button.tag] == NO) {
        imageView.image = [UIImage imageNamed:@"收起"];

    }else{
        imageView.frame = CGRectMake(headerView.width - 10 - 15, headerView.height/2- 10/2, 15, 10);

        imageView.image = [UIImage imageNamed:@"展开"];

    }
    
    return headerView;
    
}

// 根据实际情况设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (shengXiaoYunChengTabView) {
        if (section == 0) {
            return 0;
        }

        return 44.0;
        
    }else if(liuShiJiaZhiTabView){
        
        return 44.0;
        
    }else if(liuYueTabView){
        if (section ==0) {
            return 0;
        }
        return 44.0;
    }
    return 20;
}

//距离底下的距离
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8.0;
}

//根据cell的内容算出cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (shengXiaoYunChengTabView) {
        if (indexPath.section == 0) {
            return 130;
            
        }
        UITableViewCell *cell = [self tableView:_myTableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
    }else if(liuShiJiaZhiTabView){

        UITableViewCell *cell = [self tableView:_myTableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;

    }else if (liuYueTabView){
        if (indexPath.section == 0) {
           return 130;
            
        }
        UITableViewCell *cell = [self tableView:_myTableView cellForRowAtIndexPath:indexPath];
        
        NSLog(@"%f",cell.frame.size.height);
        return cell.frame.size.height;
        
    }
    return 10;
}

//设置Cell的内容等
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * indentifier = @"quniniangde";
    
    YincangTableViewCell  * yinCangCell = [[YincangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    yinCangCell.backgroundColor = [UIColor clearColor];
    if (shengXiaoYunChengTabView) {
        
        [yinCangCell zodicaContentArray:_zodicaContentArr andImage:imageArray[(long)self.zodiac] andIndexPath:indexPath.section andYearArray:_yearArray andZodicaStr:sxmcDict[@(_zodiac)]];
        
        if (indexPath.section == 0) {
            
            yinCangCell.contextView.hidden = NO;
            yinCangCell.contextLbl.hidden = YES;
            yinCangCell.liuyuejixunLbl.hidden = YES;
            
        }else{
            
            yinCangCell.contextView.hidden = YES;
            
        }
        return yinCangCell;
        
    }
    if(liuShiJiaZhiTabView){
        
        [yinCangCell liushiContentArray:_liunianContentArr andIndexPath:indexPath.section];
        
        
        yinCangCell.contextView.hidden = YES;
        yinCangCell.contextLbl.hidden = NO;
        
        return yinCangCell;
        
    }
    if(liuYueTabView){
   
        [yinCangCell liuyueContentDict:_liuyueDict andKeyArrar:liuyueArray andIndexPath:indexPath.section];
        
        if (indexPath.section == 0) {
            
            yinCangCell.contextView.hidden = NO;
            yinCangCell.contextLbl.hidden = YES;
            yinCangCell.nianfengLbl.hidden = YES;
        }else{
            
            yinCangCell.contextView.hidden = YES;
            
        }

//        yinCangCell.contextView.hidden = YES;
//        yinCangCell.contextLbl.hidden = NO;
        
        return yinCangCell;
    }
    
    return yinCangCell;
    
}

//点击header的方法
- (void)isFlag:(UIButton  *)sender {
    [self rightSwipes:sender];
    isflag[sender.tag] = !isflag[sender.tag];
    
    [_myTableView reloadData];

    
}

//返回按钮

- (void)back{
    
    [self rightSwipes:self];
    [self.navigationController popViewControllerAnimated:YES];

}

//分享按钮
- (void)clickshare:(UIButton *)sender {
    
    
    UIImage * image = [UIImage imageNamed:@"1.png"];
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"测试流年运程霸气不霸气";
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"" image:image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }else{
            
        }
    }];

}

//滑动方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self rightSwipes:self];
    
    NSLog(@"%f",scrollView.contentOffset.x);
    
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
