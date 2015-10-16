//
//  JiepanViewController.m
//  ziweidoushu
//
//  Created by 吴冬 on 15/7/6.
//  Copyright (c) 2015年 吴冬. All rights reserved.
//

#import "JiepanViewController.h"
#import "SuanxingModel.h"
#import "JiepanView.h"

@interface JiepanViewController ()

{
   
    JiepanView *_jiepanView;
    UIImageView *_imageForLabel;

    CGFloat _xForTable;
    CGFloat _heightForTabel;
    CGFloat _widthForTable;
    
    CGFloat _yForImageForLabel;
    CGFloat _xForImageForLabel;
    CGFloat _widthForImageForLabel;
    CGFloat _heightForImageForLabel;
    
    
    CGFloat _pageForImageForLabel;
}

@end

@implementation JiepanViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIImageView *bcView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bcView.image = [UIImage imageNamed:@"紫薇大讲堂.jpg"];
    [self.view addSubview:bcView];
 
    
    [self creatFrame];
    
    [self creatJiepanView];
    
}

//创建frame
- (void)creatFrame
{
    //table
    _xForTable = 37 / 640.0 * kScreenWidth;
    _heightForTabel = (6 * 83 + 6 * 19) / 1136.0 * kScreenHeight;
    _widthForTable = 566 / 640.0 * kScreenWidth;
    
    
    _xForImageForLabel = 20 / 640.0 * kScreenWidth;
    _yForImageForLabel = 152 / 1136.0 * kScreenHeight;
    _widthForImageForLabel = 601 / 640.0 * kScreenWidth;
    _heightForImageForLabel = 359 / 1136.0 * kScreenHeight;
    _pageForImageForLabel =  21 / 1136.0 *kScreenHeight;
}


//创建视图
- (void)creatJiepanView
{
    
    _imageForLabel = [[UIImageView alloc]initWithFrame:CGRectMake(_xForImageForLabel, _yForImageForLabel, _widthForImageForLabel, _heightForImageForLabel)];
    _imageForLabel.image = [UIImage imageNamed:@"yunshi.jpg"];
    [self.view addSubview:_imageForLabel];
  
    _jiepanView = [[JiepanView alloc]initWithFrame:CGRectMake(_xForTable, _imageForLabel.bottom , _widthForTable, _heightForTabel ) withGongIndex:0];
    
    [self.view addSubview:_jiepanView];
    
  
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
