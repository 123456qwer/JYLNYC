//
//  TianpanJPViewController.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/30.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "TianpanJPViewController.h"
#import "SliderViewForBtn.h"
#import "CountViewForSky.h"

@interface TianpanJPViewController ()
{
   
    SliderViewForBtn *sliderView;
    CountViewForSky *viewForCount;
    UIScrollView    *bgScrollView;
    BOOL            _isBack;

}
@end

@implementation TianpanJPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor colorWithRed:0.342 green:1.000 blue:0.986 alpha:1.000];
    
    NSLog(@"%@",_dicForAllStarandG);
    NSLog(@"%@",_dicForSanfangsizheng);
    
    UILabel *labelFor = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    labelFor.text = @"排盘分析";
    labelFor.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:labelFor];
    
    bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth + 60.0, kScreenHeight)];
    bgScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 2);
    bgScrollView.delegate = self;
    [self.view addSubview:bgScrollView];
    
    //三方四正的4个view
    viewForCount = [[CountViewForSky alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 60, kScreenHeight ) andCountForGong:_dicForAllStarandG andSanfangsizheng:_dicForSanfangsizheng];
    [bgScrollView addSubview:viewForCount];
    
    NSArray *arr = @[@"自身",@"感情",@"父母",@"兄弟",@"财运",@"健康",@"精神",@"子女",@"田宅",@"官禄",@"奴仆",@"发展"];
    sliderView = [[SliderViewForBtn alloc]initWithFrame:CGRectMake(kScreenWidth - 60, 50, 60, kScreenHeight - 50) andCountForGong:_dicForAllStarandG andSanfangsizheng:_dicForSanfangsizheng andBtnArr:arr andHeight:100];
    //签代理
    sliderView.sliderDelegate = viewForCount;
    [self.view addSubview:sliderView];
    
    UISwipeGestureRecognizer *oneFingerSwipeleft =
    
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)];
    
    [oneFingerSwipeleft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self.view addGestureRecognizer:oneFingerSwipeleft];
    
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwiperight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:oneFingerSwipeRight];
    
    


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (_isBack == NO) {
        NSLog(@"%lf",scrollView.contentOffset.y);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            sliderView.origin = CGPointMake(kScreenWidth, 50);
            viewForCount.origin = CGPointMake(30, 0);
            
        } completion:^(BOOL finished) {
            ;
        }];
        
        _isBack = YES;
    }else{
        
        return;
    }
    
    
}

- (void)oneFingerSwiperight:(UISwipeGestureRecognizer *)sw
{
    
    NSLog(@"右扫我了");
    [UIView animateWithDuration:0.3 animations:^{
        
        sliderView.origin = CGPointMake(kScreenWidth, 50);
        viewForCount.origin = CGPointMake(30, 0);
        
    } completion:^(BOOL finished) {
        ;
    }];
    
    _isBack = YES;
}

- (void)oneFingerSwipeUp:(UISwipeGestureRecognizer *)sw
{
    
    NSLog(@"左扫我了");
    [UIView animateWithDuration:0.3 animations:^{
        
        sliderView.origin = CGPointMake(kScreenWidth - 60, 50);
        viewForCount.origin = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        ;
    }];
    
    _isBack = NO;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
