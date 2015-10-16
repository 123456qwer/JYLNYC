//
//  ChineseZodiacHomeViewController.m
//  fleetingFortune
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 金源互动. All rights reserved.
//

#import "ChineseZodiacHomeViewController.h"
#import "ZodiacDetailedViewController.h"
#import "AboutUsViewController.h"

#define sxlabelColor  [UIColor colorWithRed:139 / 255.0 green:97 / 255.0 blue:82 / 255.0 alpha:1]
#define fontColor  [UIColor colorWithRed:112 / 255.0 green:20 / 255.0 blue:20/ 255.0 alpha:1]
#define widthForBtn 233 / 750.0 * kScreenWidth
#define heightForBtn 88 / 1334.0 * kScreenHeight
#define yFotBtn (160 / 2.0 - 88 / 2.0) / 1334.0 * kScreenHeight
#define shadowColorForText [UIColor colorWithRed:177 / 255.0 green:137 / 255.0 blue:122 / 255.0 alpha:0.5].CGColor

#define HeightForSc kScreenHeight/1334.0
#define pageHeightBtn 20 / 1334.0 * kScreenHeight

@interface ChineseZodiacHomeViewController ()

//4s下的适配系数
@property (nonatomic) float fourWidth;
@property(nonatomic)float heightF;
@end

@implementation ChineseZodiacHomeViewController{
    CGFloat  btnWidth;  //每个按钮的宽
    CGFloat  btnHeight;//每个按钮的高
    CGFloat  bili;//图片与按钮实际的比例
    CGFloat  btnAndLblJJ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置UI
    [self setUI];
 
}

//设置UI
- (void)setUI{
    
    //4S适配
    _fourWidth = 1.0;
    _heightF = 1.0;
    btnAndLblJJ = 1.0;
    if (kScreenHeight == 480) {
        _fourWidth = 0.5;
        _heightF = 0.61;
        btnAndLblJJ = 0.1;
    }else if(kScreenHeight == 568){
        _fourWidth = 0.8;
        _heightF = 0.85;
        btnAndLblJJ = 0.85;
    }else{
        btnAndLblJJ = 1.0;
        _fourWidth = 1.0;
        _heightF = 1.0;

    }
    
    
    NSMutableArray * imageArray = [NSMutableArray array];
    for (int i = 1; i < 13;i ++ ) {
        NSString * str = [NSString stringWithFormat:@"%d.png",i];
        UIImage * shuxiangImage = [UIImage imageNamed:str];
        [imageArray addObject:shuxiangImage];
    }

    //背景图片
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgImageView.userInteractionEnabled = YES;
    UIImage * bgImage = [UIImage imageNamed:@"xinbeijing.png"];
    bgImageView.image = bgImage;
    [self.view addSubview:bgImageView];

    //titleImageView
    UIImageView  * titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 128 * HeightForSc)];
    titleImageView.backgroundColor = sxlabelColor;
    titleImageView.userInteractionEnabled = YES;
    [self.view addSubview:titleImageView];
    
    //标题label


    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, titleImageView.height/2 - 128 /1334.0 * kScreenHeight/2 + pageHeightBtn, kScreenWidth, 128 /1334.0 * kScreenHeight)];

    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.text = @"十二生肖";
    titleLbl.font = [UIFont boldSystemFontOfSize:22];
    titleLbl.textColor = [UIColor whiteColor];
    [titleImageView addSubview:titleLbl];
    

    
    //返回按钮

    

    UIButton * backBtn  = [[UIButton alloc]initWithFrame:CGRectMake(0, titleImageView.height/2 - 88* HeightForSc/2 + pageHeightBtn, widthForBtn, 88 * HeightForSc)];

    [backBtn setImage:[UIImage imageNamed:@"lback.png"] forState:UIControlStateNormal];
    [backBtn addTarget: self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    
    bili = kScreenWidth * 2/750.0;//用当前宽/750得出与给图的比例
    btnWidth = 80 * bili;
    btnHeight = btnWidth;
    
    UIButton * sxBtn;

    UILabel * sxLbl;
    NSArray * shengxiaoArray = @[@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪"];
    //循环放入十二个btn
    for (int i = 0; i < 12; i++) {
        if (i >= 0 && i < 3) {
            if (i == 0) {
                sxBtn = [[UIButton alloc]initWithFrame:CGRectMake(25 *bili,titleImageView.bottom + 46 *_heightF, btnWidth, btnWidth)];
                sxBtn.tag = 500 +i;
                [sxBtn setBackgroundImage:imageArray[i] forState:UIControlStateNormal];
                sxLbl = [[UILabel alloc]initWithFrame:CGRectMake(25 * (i + 1) * bili + btnWidth/2 - 20/2*bili, sxBtn.bottom +5 * btnAndLblJJ, 20 * bili, 35 *bili)];
            }else{
                sxBtn = [[UIButton alloc]initWithFrame:CGRectMake(25 * bili + 43 *i * bili + 80 * i * bili, titleImageView.bottom + 46 * _heightF, btnWidth, btnWidth)];
                sxBtn.tag = 500 +i;
                [sxBtn setBackgroundImage:imageArray[i] forState:UIControlStateNormal];
                
                 sxLbl = [[UILabel alloc]initWithFrame:CGRectMake(25 * bili + 43 *i * bili + 80 * i * bili + btnWidth/2 - 20/2*bili, sxBtn.bottom +5 * btnAndLblJJ, 20 * bili, 35 *bili)];
            }
            
           
        }else if(i >= 3 && i < 6){
            //获取第一行btn的一个  设置height为上一排btn底部+ 间距
            UIButton * Btn = (UIButton *)[self.view viewWithTag:502];
            if (i == 3) {
                sxBtn = [[UIButton alloc]initWithFrame:CGRectMake(25 * bili, Btn.bottom + 50*_heightF, btnWidth, btnWidth)];
                sxBtn.tag = 500 + i;
                [sxBtn setBackgroundImage:imageArray[i] forState:UIControlStateNormal];
                 sxLbl = [[UILabel alloc]initWithFrame:CGRectMake(25 * (i + 1 - 3) * bili + btnWidth/2 - 20/2*bili, sxBtn.bottom +5 * btnAndLblJJ, 20 * bili, 35 *bili)];
            }else{
                
                sxBtn = [[UIButton alloc]initWithFrame:CGRectMake(25* bili + 43 *(i -3) * bili + 80 * (i - 3) * bili, Btn.bottom + 50*_heightF, btnWidth, btnWidth)];
                sxBtn.tag = 500 + i;
                [sxBtn setBackgroundImage:imageArray[i] forState:UIControlStateNormal];
                sxLbl = [[UILabel alloc]initWithFrame:CGRectMake(25 * bili + 43 * (i - 3) * bili + 80 * (i -3) * bili + btnWidth/2 - 20/2*bili, sxBtn.bottom +5 * btnAndLblJJ, 20 * bili, 35 *bili)];
            }
            
        }else if (i >= 6 && i < 9){
            
            //获取上一行btn的一个  设置height为上一排btn底部+ 间距
            UIButton * Btn = (UIButton *)[self.view viewWithTag:505];
            
            if (i == 6) {
                sxBtn = [[UIButton alloc]initWithFrame:CGRectMake(25 * bili,Btn.bottom + 50*_heightF, btnWidth, btnWidth)];
                sxBtn.tag = 500 +i;
                [sxBtn setBackgroundImage:imageArray[i] forState:UIControlStateNormal];
                
                sxLbl = [[UILabel alloc]initWithFrame:CGRectMake(25 * (i + 1 - 6) * bili + btnWidth/2 - 20/2*bili, sxBtn.bottom +5 * btnAndLblJJ, 20 * bili, 35 *bili)];
            }else{
                sxBtn = [[UIButton alloc]initWithFrame:CGRectMake(25 *bili + 43 *(i - 6) * bili + 80 * (i - 6) * bili,Btn.bottom + 50*_heightF, btnWidth, btnWidth)];
                sxBtn.tag = 500 +i;
                [sxBtn setBackgroundImage:imageArray[i] forState:UIControlStateNormal];
                
                   sxLbl = [[UILabel alloc]initWithFrame:CGRectMake(25 * bili + 43 * (i - 6) * bili + 80 * (i -6) * bili + btnWidth/2 - 20/2*bili, sxBtn.bottom +5 * btnAndLblJJ, 20 * bili, 35 *bili)];
            }
            
        }else if (i >= 9 && i < 12){
            UIButton *Btn = (UIButton *)[self.view viewWithTag:507];
            if (i == 9) {
                sxBtn = [[UIButton alloc]initWithFrame:CGRectMake(25 * bili, Btn.bottom + 50*_heightF, btnWidth, btnWidth)];
                sxBtn.tag = 500 + i;
                [sxBtn setBackgroundImage:imageArray[i] forState:UIControlStateNormal];
                 sxLbl = [[UILabel alloc]initWithFrame:CGRectMake(25 * (i + 1 - 9) * bili + btnWidth/2 - 20/2*bili, sxBtn.bottom +5 * btnAndLblJJ, 20 * bili, 35 *bili)];
            }else{
                sxBtn = [[UIButton alloc]initWithFrame:CGRectMake(25 * bili + 43 *(i - 9) * bili + 80 * (i - 9) * bili, Btn.bottom + 50*_heightF, btnWidth, btnWidth)];
                sxBtn.tag = 500 + i;
                [sxBtn setBackgroundImage:imageArray[i] forState:UIControlStateNormal];
                
                sxLbl = [[UILabel alloc]initWithFrame:CGRectMake(25 * bili + 43 * (i - 9) * bili + 80 * (i - 9) * bili + btnWidth/2 - 20/2*bili, sxBtn.bottom +5 * btnAndLblJJ, 20 * bili, 35 *bili)];
            }
          
        }
//        
//        sxBtn.layer.shadowOpacity = 1;
//        sxBtn.layer.shadowOffset = CGSizeMake(0, 2);
//        sxBtn.layer.shadowColor = shadowColorForText;
//       
//        sxLbl.layer.shadowOpacity = 1;
//        sxLbl.layer.shadowOffset = CGSizeMake(0, 2);
//        sxLbl.layer.shadowColor = shadowColorForText;
        
        [sxBtn addTarget:self action:@selector(shengxiaoAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sxBtn];
        sxLbl.textAlignment = NSTextAlignmentCenter;
        sxLbl.textColor =fontColor;
        sxLbl.text = shengxiaoArray[i];
        [self.view addSubview:sxLbl];
    }


}


//返回按钮
- (void)backAction:(UIButton * )sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//点击生肖
- (void)shengxiaoAction:(UIButton *)sender{
    
    
    ZodiacDetailedViewController * zodiacDetailedVC = [[ZodiacDetailedViewController alloc]init];
    zodiacDetailedVC.zodiac = sender.tag - 500;

    [self.navigationController pushViewController:zodiacDetailedVC animated:YES];
  
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
