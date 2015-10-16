//
//  AddPeopleViewController.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/12.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

/**
 *  核心方法
 *
 *  主要是通过阴历的月份以及日期，阴阳来排盘
 */

#import "AddPeopleViewController.h"
#import "textVCViewController.h"
#import "SuanxingTool.h"
#import "MyTextField.h"

//名字text
#define widthForText 420 / 750.0 * kScreenWidth
#define heightForText 70 / 1334.0 * kScreenHeight
#define xForText 30 / 750.0 * kScreenWidth
#define yForText (60 + 128) / 1334.0 * kScreenHeight

//选择生日
#define widthForBurnBtn 690 / 750.0 * kScreenWidth
#define pageForBurnBtn 44 / 1334.0 * kScreenHeight
#define pageForBurnLabel 20 / 1334.0 * kScreenHeight

//确认按钮
#define heightForSureBtn 90 / 1334.0 * kScreenHeight

//性别按钮
#define yForSexBtn (40 + 128) / 1334.0 * kScreenHeight
#define widthForSexBtn 110 / 750.0 * kScreenWidth
#define pageForMan 24 / 750.0 * kScreenWidth
#define pageForWomen 17 / 750.0 * kScreenWidth

//title
#define heightForTitle 88 / 1334.0 * kScreenHeight
#define widthForTitle 223 / 750.0 * kScreenWidth
#define heightForTitleH 128 / 1334.0 * kScreenHeight
#define yForTitleBack (128 - 88) / 2.0 / 1334.0 * kScreenHeight

//pickerColor
#define colorForPicker [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:0.5]
#define colorForBtn [UIColor colorWithRed:248 / 255.0 green:242 / 255.0 blue:234 / 255.0 alpha:1]

#define pageHeightBtn 20 / 1334.0 * kScreenHeight


@interface AddPeopleViewController ()
{
   
    MyPickerView *viewForPick;
    UIButton *_btnForYangli;  //阳历按钮
    UIButton *_btnForYinli;   //阴历按钮
    UIButton *_btnForSure;    //确定按钮
    UIButton *_btnForToday;   //今天
    
    UIView  *_btnForSyangli;  //选中的BTN
    UIView  *_btnForSyinli;
    UIView  *_btnForSsure;
    UIView  *_btnForStoday;
    
    NSInteger _todayYear;     //今天的日期
    NSInteger _todayMonth;
    NSInteger _todayDay;
    NSInteger _todayHours;
    
    NSInteger _forYearNow;    //当前选择的日期
    NSInteger _forMonthNow;
    NSInteger _forDayNow;
    NSInteger _forHoursNow;
    
    NSInteger _changeForYear;  //变换的日期
    NSInteger _changeForMonth;
    NSInteger _changeForDay;
    NSInteger _changeForHours;
    NSInteger _hoursNow;
    NSInteger _hours;
    
//******************************返还给主页的数据*****************************//
  
    NSString *_tiangan;       //天干，地支，阴阳 性别,生日,五行,宜，忌,格局
    NSString *_dizhi;
    NSString *_yinyang;
    NSString *_yinliRiqi;
    NSString *_sex;
    NSString *_strForGeju;
    NSString *_strForAgeAndYinyang;
    NSString *_strForShengxiao;
    NSString *_strForPeopleburnDay;
    NSString *_strForWuxing;
    NSString *_strForRight;
    NSString *_strForWrong;
    NSString *nongli;
    NSDictionary *_dicForHomeAndPan;  //俩个数据放在一起存放，方便
    
    
    
//******************************返还给主页的数据*****************************//
    
    BOOL     _isYinzhuanYang; //判断是否是阴转阳

    
    textVCViewController *textVC;
    
//*****************************按钮***************************************//
    
    MyTextField *_textForName;
    UIButton *_manBtn;
    UIButton *_womenBtn;
    UIButton *_selectedBurnDayBtn;
    UIButton *_confirmBtn;
    UILabel *labelForBurn;
    
    
}
@end

@implementation AddPeopleViewController


#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //背景颜色
    UIImageView *viewForBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    viewForBG.image = [UIImage imageNamed:@"背景主页"];
    [self.view addSubview:viewForBG];
    
    UIView *viewForTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, heightForTitleH)];
    viewForTitle.backgroundColor = colorForAll;
    [self.view addSubview:viewForTitle];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, heightForTitleH)];
    titleLabel.text = @"新增用户";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:21];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    //返回按钮
    UIButton *btnForBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnForBack.frame = CGRectMake(0, yForTitleBack + pageHeightBtn , widthForTitle, heightForTitle);
    [btnForBack setImage:[UIImage imageNamed:@"返"] forState:UIControlStateNormal];
    [btnForBack addTarget:self action:@selector(actionForBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnForBack];
    
    
    
    _sex = @"男";
    
    /**
     *  按钮图片
     */
    
    [self createBtnView];
    /**
     *  初始化datepicker
     */
    [self createDatePicker];
    
    /**
     *  初始化datepicker上的按钮
     */
    [self createDatePickerButton];
    
    
  
}


#pragma mark 私有方法

//创建名字、确认等按钮
- (void)createBtnView
{
    _textForName = [[MyTextField alloc]initWithFrame:CGRectMake(xForText, yForText, widthForText, heightForText)];
    _textForName.placeholder = @"请输入姓名";
    _textForName.layer.cornerRadius = 5;
    _textForName.layer.borderWidth = 0.5;
    _textForName.layer.borderColor = [UIColor colorWithRed:168 / 255.0 green:117 / 255.0 blue:98 / 255.0 alpha:1].CGColor;
    _textForName.font = [UIFont boldSystemFontOfSize:16];
    _textForName.backgroundColor = [UIColor colorWithRed:251 / 255.0 green:245 / 255.0 blue:237 / 255.0 alpha:1];

       [self.view addSubview:_textForName];
    
    
    _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _manBtn.frame = CGRectMake(pageForMan + _textForName.right, yForSexBtn, widthForSexBtn, widthForSexBtn);
    [_manBtn setImage:[UIImage imageNamed:@"男"] forState:UIControlStateSelected];
    [_manBtn setImage:[UIImage imageNamed:@"男未"] forState:UIControlStateNormal];
    [_manBtn addTarget:self action:@selector(actionForMan:) forControlEvents:UIControlEventTouchUpInside];
    _manBtn.selected = YES;
    [self.view addSubview:_manBtn];
    
    
    _womenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _womenBtn.frame = CGRectMake(pageForWomen + _manBtn.right, yForSexBtn, widthForSexBtn, widthForSexBtn);
    [_womenBtn addTarget:self action:@selector(actionForWomen:) forControlEvents:UIControlEventTouchUpInside];
    [_womenBtn setImage:[UIImage imageNamed:@"女"] forState:UIControlStateSelected];
    [_womenBtn setImage:[UIImage imageNamed:@"女未"] forState:UIControlStateNormal];
    _womenBtn.selected = NO;
    [self.view addSubview:_womenBtn];
    
    
    _selectedBurnDayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _selectedBurnDayBtn.frame = CGRectMake(xForText, _textForName.bottom + pageForBurnBtn, widthForBurnBtn, heightForText);
    _selectedBurnDayBtn.backgroundColor = [UIColor colorWithRed:251 / 255.0 green:245 / 255.0 blue:237 / 255.0 alpha:1];
    _selectedBurnDayBtn.layer.cornerRadius = 5;
    _selectedBurnDayBtn.layer.borderWidth = 0.5;
    _selectedBurnDayBtn.layer.borderColor = [UIColor colorWithRed:168 / 255.0 green:117 / 255.0 blue:98 / 255.0 alpha:1].CGColor;
    [_selectedBurnDayBtn addTarget:self action:@selector(actionForPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectedBurnDayBtn];
    
    labelForBurn = [[UILabel alloc]initWithFrame:CGRectMake(pageForBurnLabel, pageForBurnLabel, 200, heightForText)];
    labelForBurn.font = [UIFont boldSystemFontOfSize:16];
    labelForBurn.frame = CGRectMake(pageForBurnLabel, (heightForText - labelForBurn.font.pointSize) / 2.0, 200, heightForText - (labelForBurn.height - labelForBurn.font.pointSize));
    labelForBurn.textColor = [UIColor colorWithRed:211/ 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1];
    
    labelForBurn.text = @"选择生日";
    [_selectedBurnDayBtn addSubview:labelForBurn];

    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn addTarget:self action:@selector(actionForPop:) forControlEvents:UIControlEventTouchUpInside];
    _confirmBtn.frame = CGRectMake(xForText, _selectedBurnDayBtn.bottom + pageForBurnBtn, widthForBurnBtn, heightForSureBtn);
    _confirmBtn.backgroundColor = [UIColor colorWithRed:149 / 255.0 green:149 / 255.0 blue:149 / 255.0 alpha:1];
    _confirmBtn.layer.cornerRadius = 5;
    _confirmBtn.layer.borderWidth = 0.5;
    _confirmBtn.layer.borderColor = [UIColor colorWithRed:168 / 255.0 green:117 / 255.0 blue:98 / 255.0 alpha:1].CGColor;
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
}


//Picker的确定方法,进入popData
- (void)pushActionForZhuye:(UIButton *)sender
{
    

    
    labelForBurn.text = [NSString stringWithFormat:@"%ld年%ld月%ld日 %ld时",_changeForYear,_changeForMonth,_changeForDay ,_changeForHours];
    _confirmBtn.backgroundColor = colorForAll;
    labelForBurn.textColor = [UIColor blackColor];
    //收回
    [self collectionDatePicker];
    
    //[self popData];
    
}

//确认按钮方法,进入popData
- (void)actionForPop:(UIButton *)sender {
    
    [self popData];
}

//弹出选择年龄按钮
- (void)actionForPicker:(UIButton *)sender {
    
    
    [_textForName resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        viewForPick.origin = CGPointMake(1, kScreenHeight - 200);
        _btnForYangli.origin = CGPointMake(0, kScreenHeight - 210);
        _btnForYinli.origin = CGPointMake(_btnForYangli.right, kScreenHeight - 210);
        _btnForToday.origin = CGPointMake(_btnForYinli.right, kScreenHeight - 210);
        _btnForSure.origin =  CGPointMake(_btnForToday.right, kScreenHeight - 210);
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

//选择性别按钮
- (void)actionForMan:(UIButton *)sender {
    
    if (sender.selected == YES) {
        
        return;
    }
    
    sender.selected = !sender.selected;
    _womenBtn.selected = NO;
    _sex = @"男";
    
}

- (void)actionForWomen:(UIButton *)sender {
    
    
    
    if (sender.selected == YES) {
        
        return;
    }
    
    sender.selected = !sender.selected;
    _manBtn.selected = NO;
    
    _sex = @"女";
}

//返回方法
- (void)actionForBack:(UIButton *)sender {
    
    NSLog(@"123");
    
    [self.navigationController popViewControllerAnimated:YES];
}

//收起datepicker
- (void)collectionDatePicker
{

    [UIView animateWithDuration:0.5 animations:^{
        
        viewForPick.origin = CGPointMake(0, kScreenHeight);
        _btnForYangli.origin = CGPointMake(0, kScreenHeight );
        _btnForYinli.origin = CGPointMake(_btnForYangli.right, kScreenHeight );
        _btnForToday.origin = CGPointMake(_btnForYinli.right, kScreenHeight );
        _btnForSure.origin =  CGPointMake(_btnForToday.right, kScreenHeight );
        
        
    } completion:^(BOOL finished) {
        
        
    }];

}



//给主页面以及盘页面数据的方法
//************************************************************************//
- (void)popData
{
    //如果没输入姓名，提示从新输入
    NSString *Str = _textForName.text;
    NSLog(@"%@",Str);
    
    if ([Str  isEqual: @""]) {
        
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"" message:@"请您输入姓名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alterView show];
        
        return;
        
    }
    
    
    //这个是目前选中的日期
    NSInteger years = _changeForYear;
    NSInteger months = _changeForMonth;
    NSInteger days = _changeForDay;
    NSInteger hours = _changeForHours;
    
    
    //楠姐后台的方法
    //*******************************需要在这增加加载页面***************************//
    NSString *dateForURL = [NSString stringWithFormat:@"http://xuanji.jyhd.com/year2016/queryDate?lunar=%ld-%ld-%ld",years,months,days];
    
    //收起datepicker
    [self collectionDatePicker];
    
    
    //根据阴阳历来判断是否需要对当前选中的日期进行转换
    if (_isYinzhuanYang == YES) {
        
        /**
         *  阴历转阳历
         */
        
        AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
        
        [manger GET:dateForURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"123 : %@",responseObject);
            
            NSDictionary *dicForDate = (NSDictionary *)responseObject;
            
            //请求完成以后才能调用这个方法
            [self performSelectorOnMainThread:@selector(lunarTurnSunday:) withObject:dicForDate waitUntilDone:YES];
            
            //将盘和主页需要的数据存储到_dicForHomeAndPan这个字典中传到主界面
            if ([self.addDelegate respondsToSelector:@selector(changeHomeAndPan:)]) {
                
                [self.addDelegate changeHomeAndPan:_dicForHomeAndPan];
            }
            
          
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"失败了");
            
        }];
        
        
        
    }else{
        
        /**
         *  阳历转阴历
         */
        [self turnActionWithYear:years andMonth:months andDay:days andHours:hours];
        
        
        //将盘和主页需要的数据存储到_dicForHomeAndPan这个字典中传到主界面
        if ([self.addDelegate respondsToSelector:@selector(changeHomeAndPan:)]) {
            
            [self.addDelegate changeHomeAndPan:_dicForHomeAndPan];
        }
        
     
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
    
}

//*************************************************************************//









//********************************核心方法***************************************//


/**
 *  阴历转阳历
 *
 *  @param dateForSunday 请求下来的阳历
 */
- (void)lunarTurnSunday:(id)dateForSunday
{
    NSString *dateStr = [dateForSunday objectForKey:@"sunDate"];
    NSLog(@"123: %@",dateStr);
    
    NSInteger year = [[dateStr substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger month = [[dateStr substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day  = [[dateStr substringWithRange:NSMakeRange(8, 2)] integerValue];
    
    NSLog(@"阴历转的阳历年 %ld",year);
    NSLog(@"阴历转的阳历月 %ld",month);
    NSLog(@"阴历转的阳历日 %ld",day);
    [self turnActionWithYear:year andMonth:month andDay:day andHours:_changeForHours];
    
}

/**
 *  阳历转阴历
 *  
 *  阳历
 *  @param year  年份
 *  @param month 月份
 *  @param day   日期
 *  @param hours 时辰
 *
 *  @return 返回一个阴历字符串
 */
- (void)turnActionWithYear:(NSInteger )year
                  andMonth:(NSInteger )month
                    andDay:(NSInteger )day
                  andHours:(NSInteger )hours
{
    
    
    _forYearNow = year;   //阳历日期
    _forDayNow = day;
    _forMonthNow = month;
    _forHoursNow = hours;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    
    
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *date = [gregorian dateFromComponents:comps];
    
    
    NSCalendar *hebrew = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSUInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [hebrew components:unitFlags fromDate:date];
    
    NSInteger year1 = [components year]; // 阴历年
    //阴历月                    //阴历日
    _yinliRiqi = [self returnYinliString:year1 andMonth:[components month] andDays:[components day] andHours:hours withYinyang:YES];
    
}


/**
 *  工具方法，算阴历所对应的天干，地之等
 *
 *  @param years  阴历年
 *  @param months 阴历月
 *  @param days   阴历日
 *  @param hours  时辰
 *
 *  @return 返回一个阴历日期
 */
- (NSString *)returnYinliString:(NSInteger )years
                       andMonth:(NSInteger )months
                        andDays:(NSInteger )days
                       andHours:(NSInteger )hours
                    withYinyang:(BOOL)isYangli
{
    
    if (years > 60) {
        
        years = years % 60;
        
        if (years > 3 ) {
            
            years = years - 3;
        }
        
    }
    
    if (hours == 24) {
        
        hours = 24 - 1;
    }
    
    NSDictionary *chineseHours = @{@(0):@"子",@(1):@"丑",@(2):@"丑",@(3):@"寅",@(4):@"寅",@(5):@"卯",@(6):@"卯",@(7):@"辰",@(8):@"辰",@(9):@"巳",@(10):@"巳",@(11):@"午",@(12):@"午",@(13):@"未",@(14):@"未",@(15):@"申",@(16):@"申",@(17):@"酉",@(18):@"酉",@(19):@"戌",@(20):@"戌",@(21):@"亥",@(22):@"亥",@(23):@"子",};
    
    NSString *dizhistr = chineseHours[@(hours)]; //获取当前小时的生肖，换算成所需要的时辰时间
    
    NSDictionary *chineseHours2 = @{@"子":@(1),@"丑":@(2),@"寅":@(3),@"卯":@(4),@"辰":@(5),@"巳":@(6),@"午":@(7),@"未":@(8),@"申":@(9),@"酉":@(10),@"戌":@(11),@"亥":@(12)};
    
    _hours = [chineseHours2[dizhistr] integerValue];
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛巳",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
//    NSLog(@"月份 : %@",chineseMonths[months - 1]);
//    NSLog(@"年份 : %@",chineseYears[years - 1]);
//    NSLog(@"日期 : %@",chineseDays[days - 1]);
//    NSLog(@"时辰 : %@",chineseHours[@(hours)]);
    
    NSString *yearNow = chineseYears[years - 1];
    NSString *monthNow = chineseMonths[months - 1];
    NSString *dayNow = chineseDays[days - 1];
    NSString *hoursNow = chineseHours[@(hours)];
    
    //（甲、丙、戊、庚、壬等年出生者的男性称为阳男，女性称为阳女；乙、丁、己、辛、癸等年出生者的男性称为阴男，女性称为阴女
    NSArray *yang = @[@"甲",@"丙",@"戊",@"庚",@"壬"];
    NSArray *yin = @[@"乙",@"丁",@"己",@"辛",@"癸"];
    _tiangan = [chineseYears[years - 1] substringWithRange:NSMakeRange(0, 1)];
    _dizhi = [chineseYears[years - 1] substringWithRange:NSMakeRange(1, 1)];
    
    for (int i = 0; i < yang.count; i++) {
        
        NSString *tian1 = yang[i];
        NSString *yin1 = yin[i];
        
        if ([_tiangan isEqualToString:tian1] && [_sex isEqualToString:@"女"]) {
            
            _yinyang = @"阳女";
            
        }else if([_tiangan isEqualToString:tian1] && [_sex isEqualToString:@"男"]){
            
            _yinyang = @"阳男";
            
        }else if([_tiangan isEqualToString:yin1] && [_sex isEqualToString:@"女"]){
            
            _yinyang = @"阴女";
            
        }else if([_tiangan isEqualToString:yin1] && [_sex isEqualToString:@"男"]){
            
            _yinyang = @"阴男";
        }
        
        
        
    }
    
    
    //阴历日期
    nongli = [NSString stringWithFormat:@"%@年%@%@ %@时",yearNow,monthNow,dayNow ,hoursNow];
    
    
    _yinliRiqi = nongli;
    //-----------------------------------------------------------------------------------------------------//
    /**
     *  给命盘赋值
     */
    [self jieshouActionWithHoursNow:_hours withYinliDay:days withYinliMonth:months withYinliDizhi:_dizhi withYinlitiangan:_tiangan withName:_textForName.text withYinyang:_yinyang];
    
    //--------------------------------------------------------------------------------------------------//
    
    return nongli;
}







//***************************************************************************//




//******************************接收数据*****************************************//
/**
 *  接收所有参数的方法
 */
- (void)jieshouActionWithHoursNow:(NSInteger )hours
                     withYinliDay:(NSInteger )days   //阴历的日
                   withYinliMonth:(NSInteger )month  //阴历的月
                   withYinliDizhi:(NSString *)dizhiSTR  //地支
                 withYinlitiangan:(NSString *)tianganSTR //天干
                         withName:(NSString *)name
                      withYinyang:(NSString *)yinyang  //阴阳
{


//给主界面加UI用的数据
//*********************五行局什么的在这里加********************//
    NSDictionary *dicForDi = @{@"子":@"鼠",@"丑":@"牛",@"寅":@"虎",@"卯":@"兔",@"辰":@"龙",@"巳":@"蛇",@"午":@"马",@"未":@"羊",@"申":@"猴",@"酉":@"鸡",@"戌":@"狗",@"亥":@"猪"};
    
    NSMutableDictionary *dicForHomeAndPan = [NSMutableDictionary dictionary];
    
    //生肖选项
    _strForShengxiao = [dicForDi objectForKey:dizhiSTR];

    //阳历选项
    _strForPeopleburnDay = [SuanxingTool returnActionForBornWithYear:_forYearNow andMonth:_forMonthNow andDay:_forDayNow andHours:_forHoursNow];
    
    //年龄选项
    _strForAgeAndYinyang = [NSString stringWithFormat:@"%ld %@",(2016 - _forYearNow),yinyang];
    
    //格局选项
    NSString *strForMinggong = [SuanxingTool minggongWithMonth:month andHours:hours];
    _strForGeju = [SuanxingTool wuxingjuDizhi:strForMinggong tiangan:tianganSTR withYINYANG:yinyang];
    
    //五行选项
    NSString *strForTianganAndDizhi = [tianganSTR stringByAppendingString:dizhiSTR];
    
    NSString *strForY = [_strForPeopleburnDay substringWithRange:NSMakeRange(0, 4)];
    NSString *strForM = [_strForPeopleburnDay substringWithRange:NSMakeRange(5, 2)];
    NSString *strForD = [_strForPeopleburnDay substringWithRange:NSMakeRange(8, 2)];
    NSString *strForWuxing = [NSString stringWithFormat:@"%@-%@-%@",strForY,strForM,strForD];
    
    SuanxingTool *to123 = [[SuanxingTool alloc] init];
    _strForWuxing = [to123 suanMinChuanMtgdz:strForTianganAndDizhi and:strForWuxing];
    
    
    
    
    [dicForHomeAndPan setObject:_strForShengxiao forKey:@"shuxiang"];
    [dicForHomeAndPan setObject:_strForAgeAndYinyang forKey:@"ageForHomePage"];
    [dicForHomeAndPan setObject:_strForPeopleburnDay forKey:@"yangli"];
    [dicForHomeAndPan setObject:_strForGeju forKey:@"geju"];
    [dicForHomeAndPan setObject:_strForWuxing forKey:@"wuxing"];


//***************************************************************//
    
    //注意，KEY要和数据模型的KEY对应
    
//********************************盘的数据**************************//
   
    
    NSInteger age = 2016 - _forYearNow + 1;
    
    [dicForHomeAndPan setObject:@(_forYearNow) forKey:@"yearsNow"];
    [dicForHomeAndPan setObject:@(_forMonthNow) forKey:@"monthNow"];
    [dicForHomeAndPan setObject:@(_forDayNow) forKey:@"dayNow"];
    [dicForHomeAndPan setObject:@(_forHoursNow) forKey:@"hoursNow"];
    [dicForHomeAndPan setObject:_yinliRiqi forKey:@"yinliSTR"];
    
    [dicForHomeAndPan setObject:@(hours) forKey:@"hours"];
    [dicForHomeAndPan setObject:@(days) forKey:@"day"];
    [dicForHomeAndPan setObject:@(month) forKey:@"month"];
    [dicForHomeAndPan setObject:dizhiSTR forKey:@"dizhiSTR"];
    [dicForHomeAndPan setObject:tianganSTR forKey:@"tiangan"];
    [dicForHomeAndPan setObject:name forKey:@"name"];
    [dicForHomeAndPan setObject:@(age) forKey:@"age"];
    [dicForHomeAndPan setObject:yinyang forKey:@"yinyang"];
       _dicForHomeAndPan = dicForHomeAndPan;
    
//******************************************************************//
    
}









#pragma mark datePicker相关代码
/**
 *  初始化datepicker
 */
- (void)createDatePicker
{
  
    //今天的日子
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc]init];
    [nowDateFormatter setDateFormat:@"yyyy年MM月dd日HH:mm:ss"];
    NSString *dada = [nowDateFormatter stringFromDate:nowDate];
    
    NSInteger year = [[dada substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger month = [[dada substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day = [[dada substringWithRange:NSMakeRange(8, 2)] integerValue];
    NSInteger hours = [[dada substringWithRange:NSMakeRange(11, 2)] integerValue];
    

    //初始化一下
    _forYearNow = year;
    _forMonthNow = month;
    _forDayNow = day;
    _forHoursNow = hours;
    
    _changeForYear = year;
    _changeForMonth = month;
    _changeForDay = day;
    _changeForHours = hours;
    
    _todayYear = year;
    _todayMonth = month;
    _todayDay = day;
    _todayHours = hours;
    
    
    //创建datePicker
    viewForPick = [[MyPickerView alloc]initWithFrame:CGRectMake(5, kScreenHeight, kScreenWidth, 250)];
    
    viewForPick.pickerViewDelegate = self;
    
    viewForPick.backgroundColor = colorForPicker;
    [self.view addSubview:viewForPick];
    
    [viewForPick selectRow:year - 1936 inComponent:0 animated:YES];
    [viewForPick selectRow:month - 1 inComponent:1 animated:YES];
    [viewForPick selectRow:day - 1 inComponent:2 animated:YES];
    [viewForPick selectRow:hours - 1 inComponent:3 animated:YES];
    

    
}

/**
 *  创建datepicker上的按钮
 */
- (void)createDatePickerButton
{
  
    //创建阳历选项
    _btnForYangli = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnForYangli setTitle:@"阳历" forState:UIControlStateNormal];
    [_btnForYangli setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnForYangli addTarget:self action:@selector(yangliAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnForYangli.backgroundColor = colorForBtn;
    _btnForYangli.frame = CGRectMake(0, kScreenHeight + 100, kScreenWidth / 4.0, 50);
    
    _btnForSyangli = [[UIView alloc]initWithFrame:CGRectMake(42/2.0, _btnForYangli.height - 15, _btnForYangli.width - 42, 2)];
    _btnForSyangli.backgroundColor = [UIColor redColor];
    _btnForSyangli.hidden = YES;
    [_btnForYangli addSubview:_btnForSyangli];
    [self.view addSubview:_btnForYangli];
    
    //创建阴历选项
    _btnForYinli = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnForYinli = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnForYinli setTitle:@"阴历" forState:UIControlStateNormal];
    [_btnForYinli setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnForYinli addTarget:self action:@selector(yinliAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnForYinli.backgroundColor = colorForBtn;
    _btnForYinli.frame = CGRectMake(_btnForYangli.right, kScreenHeight + 100, kScreenWidth / 4.0, 50);
    
    _btnForSyinli = [[UIView alloc]initWithFrame:CGRectMake(42/2.0, _btnForYangli.height - 15, _btnForYangli.width - 42, 2)];
    _btnForSyinli.backgroundColor = [UIColor redColor];
    _btnForSyinli.hidden = YES;
    [_btnForYinli addSubview:_btnForSyinli];
    
    [self.view addSubview:_btnForYinli];
    
    //创建今天选项
    _btnForToday = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnForToday = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnForToday setTitle:@"今天" forState:UIControlStateNormal];
    [_btnForToday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnForToday addTarget:self action:@selector(todayAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnForToday.frame = CGRectMake(_btnForYinli.right, kScreenHeight + 100, kScreenWidth / 4.0, 50);
    _btnForToday.backgroundColor = colorForBtn;
    _btnForStoday = [[UIView alloc]initWithFrame:CGRectMake(42/2.0, _btnForYangli.height - 15, _btnForYangli.width - 42, 2)];
    _btnForStoday.backgroundColor = [UIColor redColor];
    _btnForStoday.hidden = NO;
    [_btnForToday addSubview:_btnForStoday];
    
    [self.view addSubview:_btnForToday];
    
    //确定弹出命盘按钮
    _btnForSure = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnForSure = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnForSure setTitle:@"确定" forState:UIControlStateNormal];
    [_btnForSure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnForSure addTarget:self action:@selector(pushActionForZhuye:) forControlEvents:UIControlEventTouchUpInside];
    _btnForSure.backgroundColor = colorForBtn;
    _btnForSure.frame = CGRectMake(_btnForToday.right, kScreenHeight + 100, kScreenWidth / 4.0, 50);
    [self.view addSubview:_btnForSure];
    


}


//今天
- (void)todayAction:(UIButton *)sender
{
    
    if (_btnForStoday.hidden == NO) {
        
        return;
        
    }else{
        
        _btnForStoday.hidden = NO;
        _btnForSyinli.hidden = YES;
        _btnForSyangli.hidden = YES;
        
    }
    
    //今天的日子
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc]init];
    [nowDateFormatter setDateFormat:@"yyyy年MM月dd日HH:mm:ss"];
    NSString *dada = [nowDateFormatter stringFromDate:nowDate];
    
    NSInteger year = [[dada substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger month = [[dada substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day = [[dada substringWithRange:NSMakeRange(8, 2)] integerValue];
    NSInteger hours = [[dada substringWithRange:NSMakeRange(11, 2)] integerValue];
    
    [viewForPick selectRow:year - 1936 inComponent:0 animated:YES];
    [viewForPick selectRow:month - 1 inComponent:1 animated:YES];
    [viewForPick selectRow:day - 1 inComponent:2 animated:YES];
    [viewForPick selectRow:hours - 1 inComponent:3 animated:YES];
    
 
}

//阴历方法
- (void)yinliAction:(UIButton *)sender
{
    
    if (_btnForSyinli.hidden == NO) {
        
        return;
    }else{
        
        _btnForSyinli.hidden = NO;
        
        _btnForStoday.hidden = YES;
        _btnForSyangli.hidden = YES;
    }
    
    _isYinzhuanYang = YES;
    
    NSLog(@"阴历方法");
    
}

//阳历方法
- (void)yangliAction:(UIButton *)sender
{
    
    
    if (_btnForSyangli.hidden == NO) {
        
        return;
        
    }else{
        
        _btnForSyangli.hidden = NO;
        
        _btnForSyinli.hidden = YES;
        _btnForStoday.hidden = YES;
        
    }
    
    _isYinzhuanYang = NO;
    
    NSLog(@"阳历方法");
    
}

#pragma mark pickerView代理
- (void)actionForHours:(NSInteger)hour
{
    
    if (_btnForSyangli.hidden == YES && _btnForSyinli.hidden == YES) {
        
        _isYinzhuanYang = NO;
        
        _btnForStoday.hidden = YES;
        
        _btnForSyangli.hidden = NO;
        
        
    }
    
    _changeForHours = hour;
}

- (void)actionForDay:(NSInteger)day
{
    
    if (_btnForSyangli.hidden == YES && _btnForSyinli.hidden == YES) {
        
        _isYinzhuanYang = NO;
        
        _btnForStoday.hidden = YES;
        
        _btnForSyangli.hidden = NO;
        
    }
    
    _changeForDay = day;
    
}

- (void)actionForMonth:(NSInteger)month
{
    
    if (_btnForSyangli.hidden == YES && _btnForSyinli.hidden == YES) {
        
        _isYinzhuanYang = NO;
        
        _btnForStoday.hidden = YES;
        
        _btnForSyangli.hidden = NO;
        
    }
    
    _changeForMonth = month;
    
}

- (void)actionForYear:(NSInteger)year
{
    
    if (_btnForSyangli.hidden == YES && _btnForSyinli.hidden == YES) {
        
        _isYinzhuanYang = NO;
        
        _btnForStoday.hidden = YES;
        
        _btnForSyangli.hidden = NO;
        
        
    }
    
    _changeForYear = year;
    
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
