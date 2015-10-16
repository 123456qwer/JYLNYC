//
//  ZiweijiangtangView.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/14.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "ZiweijiangtangView.h"
#import "MyZijiangTableViewCell.h"


@implementation ZiweijiangtangView
{

    UILabel *_titleLabel;
    UITableView *_tableViewForDajiangtang;
    BOOL flag[20];
    UITextView *_textView;
    NSArray *_contentArr;
    
}

/**
 *  初始化
 *
 *  @param frame
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        
        NSString *str1 = @"紫微斗数，中国传统命理学的最重要的支派之一。它是以人出生的年、月、日、时确定十二宫的位置，构成命盘，结合各宫的星群组合，周易干支理论，来预测一个人的命运、吉凶祸福。紫微斗数推命术既具有道家宇宙观的神秘色彩，又具有注重社会环境、人际关系的近代意蕴，在中国神秘文化中卓立特出，名列“五大神数”之首，号称“天下第一神数”。因其系统里以紫微星为诸星之首，故得名。此术认为人出生时的星相决定人的一生，即人的命运；认为按一定次序出现的星曜对相对应的人的命运具有特定的影响，因而分析人出生时的星相就可以判断人本身命运的好坏和时间顺序。";
        NSString *str2 = @"主导命运主要发展趋势的星曜称为正星，指紫微、天机、太阳、武曲、天同、廉贞、天府、太阴、贪狼、巨门、天相、天梁、七杀、破军等，共十四颗。命无正星，即命宫中没有十四颗正星。辅助正星发挥作用和发展变化而起较大作用的星称为辅助星曜，指左辅、右弼、天魁、天钺、文昌、文曲、禄存、天马、擎羊、陀罗、火星、铃星、天空、地劫、化禄、化权、化科、化忌等十八颗星曜。以上正星和辅星均属甲级星，共三十二颗。\n        副星、杂曜：我们把乙级星称作副星，把丙级以下的星曜称为杂曜。\n        吉星：指有利于人的命运、福禄吉昌之星。一般称左辅、右弼、天魁、天钺、文昌、文曲等为六吉星。加禄存天马称为八吉星。正星中的紫微、天府、太阳、太阴、天相、天梁、天同、武曲等为正宗的富贵福禄之主吉星、正吉星。此外，四化星中的化禄、化科、化权亦为吉星。\n        煞星：对人的命运有破坏、抑制、衰亡、失落之星曜，统称为煞星。一般称四煞星为：擎羊、陀罗、火星、铃星。加上天空、地劫称为六煞星。\n        四化星：指化禄、化权、化科、化忌等四颗星曜，又叫四化曜。是主星变好变坏的四种结果。四化星虽不是正星，但他们的作用很大，尤其是化忌星，其破坏作用并不亚于六煞星，往往加上六煞星并称为七煞星。\n        本宫：指主事之宫。如看兄弟的事情，则以兄弟宫为主来看，所以兄弟宫就是你要论事时的本宫。若问父母情况，则以父母宫为本宫，等等。十二宫均可为本宫。\n        对宫：指本宫对面的宫，就是地支六冲之宫，如子宫的对宫为午，丑宫的对宫为未。对宫的吉凶对本宫影响很大。\n        三方四正：指本宫的三合宫为三方，本宫的对冲宫为四正。三合宫和对冲宫合起来统称为三方四正。分析三方四正以确定本宫的强弱吉凶为斗数论命的重要一环，是人事命运分析的主线，考察人事吉凶的入手之处。\n        大限：人一生可分若干阶段，每十年为一单位，称为大限。大限是一生经历几个重要阶段的沉浮曲线，是十年吉凶情况的总括。\n        格局：就是群星组合在一起形成的一个群体结构、布局的意思。紫微斗数的格局多为本宫或与三方四正宫或左右夹宫的星曜之间搭配而成的一些规定的、合格的组合体、布局，分为吉格和凶格，是前人实践经验的结晶，对吉凶判断有很重要的指导意义。";
        NSString *str3 = @"        紫微星系：紫微、天机、太阳、武曲、天同、廉贞。\n        天府星系：天府、太阴、贪狼、巨门、天相、天梁、七杀、破军。";
        NSString *str4 = @"主曜\n        文昌 文曲 左辅 右弼 天魁。\n        天钺 禄存 天马 火星 铃星。\n        擎羊 陀罗 地劫 地空 天刑。\n副曜\n        红鸾 天喜 天姚 蜚廉。\n        破碎 阴煞 天月 旬空。\n        台辅 封诰 孤辰 寡宿。\n        龙池 凤阁 天伤 天使\n        天才 天寿 恩光 天贵。\n        三台 八座 天哭 天虚。\n        解神 天官 天福 天巫。\n";
        NSString *str5 = @"        长生 沐浴 冠带 临官 帝旺 衰 病 死 墓 绝 胎 养";
        NSString *str6 = @"123123";
        _contentArr = @[str1,str2,str3,str4,str5,str6];
        
        //创建表中内容
        [self creatContentView];
        
        //创建tableVIew
        [self creatTableView];
        
    }
   
    return self;

}

//创建tableView
- (void)creatTableView
{

    _tableViewForDajiangtang = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    _tableViewForDajiangtang.delegate = self;
    _tableViewForDajiangtang.dataSource = self;
    _tableViewForDajiangtang.rowHeight = 83 / 1136.0 * kScreenHeight;
    _tableViewForDajiangtang.backgroundColor = [UIColor clearColor];
    _tableViewForDajiangtang.separatorStyle = UITextAutocapitalizationTypeNone;
    [self addSubview:_tableViewForDajiangtang];
    
}

#pragma mark TableView代理方法

//返回个数
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 2;

}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 5;

}

//返回cell大小
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewForHeader123 = [[UIView alloc   ]initWithFrame:CGRectMake(0, 0,self.width, 19 / 1136.0 * kScreenHeight)];
    viewForHeader123.backgroundColor = [UIColor clearColor];
    return viewForHeader123 ;
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    

    return 19 / 1136.0 * kScreenHeight;
}

//创建tableviewcell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *strIdentifier = @"strIdentifier";
    
    MyZijiangTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    
    if (cell == nil) {
        
        cell = [[MyZijiangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        
    }
    
   
//    if (flag[indexPath.section] == YES) {
//        
//        NSLog(@"打印的选中 %ld",indexPath.section);
//    }
//    
    if (indexPath.row == 0) {
        
        NSString *str = [NSString stringWithFormat:@"紫讲%ld",indexPath.section];
        cell.backGround.image = [UIImage imageNamed:str];
        cell.myTextView.hidden = YES;
        cell.myTextView.text = _contentArr[indexPath.section];
        cell.myTextView.layer.borderWidth = 0;
        
    }else{
        
        
        cell.backGround.image = nil;
        if(flag[indexPath.section] == YES){
        
            cell.myTextView.hidden = NO;
            cell.myTextView.text = _contentArr[indexPath.section];
            cell.myTextView.layer.borderColor = [UIColor redColor].CGColor;
            cell.myTextView.layer.borderWidth = 0.5;
            
        }else{
        
            cell.myTextView.hidden = YES;
            cell.myTextView.text = _contentArr[indexPath.section];
            cell.myTextView.layer.borderWidth = 0;

        }
        
        
    }
    

    
    return cell;

}

//点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1) {
        
        return;
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    
   MyZijiangTableViewCell *cell = (MyZijiangTableViewCell *)[tableView cellForRowAtIndexPath:path];
   
    cell.myTextView.hidden = !cell.myTextView.hidden;
 
    
    cell.myTextView.text = _contentArr[indexPath.section];
    NSLog(@"点击%ld",indexPath.section);
    
    //点击这个，其他的直接收回的方法
    for (int i = 0; i < 5; i++) {
        
        if (i != indexPath.section) {

            flag[i] = NO;

        }
        
    }
    
    if (indexPath.section == 4) {
        
        _tableViewForDajiangtang.contentOffset = CGPointMake(0, 149.5);

    }else if(indexPath.section == 3){
    
        _tableViewForDajiangtang.contentOffset = CGPointMake(0, 104);

    }else if(indexPath.section == 2){
    
        _tableViewForDajiangtang.contentOffset = CGPointMake(0, 59);

    }else if (indexPath.section == 1){
    
        _tableViewForDajiangtang.contentOffset = CGPointMake(0, 3);

    }
   
    flag[indexPath.section] = !flag[indexPath.section];
    

    

    [_tableViewForDajiangtang reloadData];
  
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    NSLog(@"滚动了 %f",scrollView.contentOffset.y);

}

//创建内容
- (void)creatContentView
{
  


}


@end
