//
//  JiepanView.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/17.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JiepanView.h"
#import "JiepanTableViewCell.h"
#import "ConetentForPanViewController.h"

@implementation JiepanView

{
   
    BOOL flag[20];
    NSArray *_contentArr;
    

    
}

- (instancetype)initWithFrame:(CGRect)frame
                withGongIndex:(NSInteger )indexForGong
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSString *str1 = @"111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";
        NSString *str2 = @"222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222";
        NSString *str3 = @"333333333333333333333333333";
        NSString *str4 = @"444444";
        NSString *str5 = @"5555555555555555555";
        NSString *str6 = @"123123";
        _contentArr = @[str1,str2,str3,str4,str5,str6,@"",@"",@""];
        
  
        
        //创建解盘View,根据传进来的宫判断直接打开哪个解释
        [self creatTableForJiepanWithIndex:indexForGong];
        
    }

    return self;
}



/**
 *  创建tableView
 *
 *  @param indexForGong 宫的位置
 */
- (void)creatTableForJiepanWithIndex:(NSInteger )indexForGong
{
 
    _jiepanTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height ) style:UITableViewStylePlain];
    _jiepanTableView.delegate = self;
    _jiepanTableView.dataSource = self;
    _jiepanTableView.backgroundColor = [UIColor clearColor];
    _jiepanTableView.separatorStyle = UITextAutocapitalizationTypeNone;
    [self addSubview:_jiepanTableView];
    
}

#pragma 表视图代理方法

//返回组数
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 9;
}

//返回每组的个数
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 2;

}

//头视图高度
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 19 / 1136.0 * kScreenHeight;
}

//表格的高度
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (flag[indexPath.section] == YES) {
        
        if (indexPath.row == 0) {
            
            return 83 / 1136.0 * kScreenHeight;
            
        }else{
            
            
            return 150;
            
        }
        
        
    }else{
        
        if (indexPath.row == 0) {
            
            return 83 / 1136.0 * kScreenHeight;
            
        }else{
            
            
            return 0;
        }
        
        
        
    }
    

}

//返回头视图的view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UIView *viewForHeader123 = [[UIView alloc   ]initWithFrame:CGRectMake(0, 0,self.width, 19 / 1136.0 * kScreenHeight)];
    viewForHeader123.backgroundColor = [UIColor clearColor];
    return viewForHeader123 ;

}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    static NSString *strForJiepanIdentifier = @"strForJiepanIdentifier";
    
    JiepanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strForJiepanIdentifier];
    
    if (cell == nil) {
        
        cell = [[JiepanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strForJiepanIdentifier];
        cell.backgroundColor = [UIColor clearColor];

    }

  
    
    if (indexPath.row == 0) {
       
  
        
        NSString *str = [NSString stringWithFormat:@"流年%ld",indexPath.section];
        cell.imageForJiepan.image = [UIImage imageNamed:str];
        cell.myTextView.hidden = YES;
        cell.myTextView.text = _contentArr[indexPath.section];
        cell.myTextView.layer.borderWidth = 0;
        
    }else{
    
        cell.imageForJiepan.image = nil;
        if(flag[indexPath.section] == YES){
            
            cell.myTextView.hidden = NO;
            cell.myTextView.text = _contentArr[indexPath.section];
            cell.myTextView.layer.borderWidth = 0.5;
            cell.myTextView.layer.borderColor = [UIColor redColor].CGColor;
            
        }else{
            
            cell.myTextView.hidden = YES;
            cell.myTextView.text = _contentArr[indexPath.section];
            cell.myTextView.layer.borderWidth = 0;
        }
    }

    return cell;
  
}


/**
 *  弹出内容视图
 *
 *  @param nav       nav
 *  @param strForPan str
 */
- (void)pushConetentVCandStr:(NSString *)strForPan
{
    UINavigationController *nav = [self jiepanAction];
    
    ConetentForPanViewController *contentVC = [[ConetentForPanViewController alloc]init];
    
    contentVC.strForPan = strForPan;
    
    [nav pushViewController:contentVC animated:YES];
}

//选中cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section == 0) {
        
        NSLog(@"选中爱情运势解析");

        [self pushConetentVCandStr:@"爱情"];
       
        
    }else if(indexPath.section == 1){
    
        NSLog(@"选中事业运势解析");
        [self pushConetentVCandStr:@"事业"];

    
    }else if(indexPath.section == 2){
    
        NSLog(@"选中钱财运势解析");
        [self pushConetentVCandStr:@"钱财"];

    
    }else if(indexPath.section == 3){
    
        NSLog(@"选中健康运势解析");
        [self pushConetentVCandStr:@"健康"];

    
    }else if(indexPath.section == 4){
    
        NSLog(@"选中父母健康运势解析");
        [self pushConetentVCandStr:@"父母"];

    
    }else if(indexPath.section == 5){
    
        NSLog(@"选中兄弟关系运势解析");
        [self pushConetentVCandStr:@"兄弟"];

    
    }

    /*
    
    if (indexPath.section >= 7) {
        
        return;
        
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    
    JiepanTableViewCell *cell = (JiepanTableViewCell *)[tableView cellForRowAtIndexPath:path];
    
    cell.myTextView.hidden = !cell.myTextView.hidden;
  
    cell.myTextView.text = _contentArr[indexPath.section];
    
    //点击这个，其他的直接收回的方法
    for (int i = 0; i < 6; i++) {
        
        if (i != indexPath.section) {
            
            flag[i] = NO;
            
        }
        
    }
    
    flag[indexPath.section] = !flag[indexPath.section];
    

    [_jiepanTableView reloadData];
     
     */
    
}



/**
 *  push出解盘的视图
 *
 *  @param sender 按钮
 */
- (UINavigationController *)jiepanAction
{
    UIResponder *next = [self nextResponder];
    
    do {
        if ([next isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *vc123 = (UINavigationController *)next;
            
         
            
            return vc123;
            
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
    
}

@end
