//
//  SliderViewForPerson.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/12.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "SliderViewForPerson.h"
#import "PeopleModel.h"
#import "SqliteForPeople.h"
#import "PeopleTableViewCell.h"
#import "SuanxingTool.h"
#import "AboutUsViewController.h"
#define widthForAddLabel 200 / 750.0 * kScreenWidth
#define heightForAddImage 42 / 1334.0 * kScreenHeight
#define xForADDImage 95 / 750.0 * kScreenWidth
#define yForADDImage 39 / 1334.0 * kScreenHeight

#define heightForCell 120 / 1334.0 * kScreenHeight
#define pageForCell 40 / 1334.0 * kScreenHeight

#define colorForLine [UIColor colorWithRed:90 / 255.0 green:65 / 255.0 blue:65 / 255.0 alpha:1]


static NSString *strForCellPeople = @"strForCellPeople";

@implementation SliderViewForPerson
{
  
    UIButton *btnForNewPeople;
    NSInteger _indexForNowCell;
    NSDictionary *_dicForDelegate;
    SqliteForPeople *_sliteF;
    UIButton *btnForAboutUs;
    UIButton *btnForGuanyinqian;
    
}

/**
 *  加载数据库中数据
 */
- (void)loadData
{

    //获取所有的数据存入数组
    SqliteForPeople *slite =[[SqliteForPeople alloc]init];
        
        NSArray *arrForP = [slite getAllContacts];
        
        for (int i = 0; i < arrForP.count; i++) {
            
            NSDictionary *dicForPeople = arrForP[i];
            
            [_dataForPeople addObject:dicForPeople];
            
        }

}


- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor blackColor];
        
        //打开数据库
        _sliteF = [[SqliteForPeople alloc]init];
        
        _dataForPeople = [NSMutableArray array];
        //先加载数据
        [self loadData];
        
        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        bgImage.image = [UIImage imageNamed:@"侧栏背景"];
        [self addSubview:bgImage];
        
        
        
        btnForNewPeople = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnForNewPeople addTarget:self action:@selector(actionForNewPeople) forControlEvents:UIControlEventTouchUpInside];
        btnForNewPeople.backgroundColor = [UIColor clearColor];
        btnForNewPeople.frame = CGRectMake(0, pageForCell, self.width, heightForCell);
        
        UIView *viewForSlider = [[UIView alloc] initWithFrame:CGRectMake(0, btnForNewPeople.bottom, self.width, 1)];
        viewForSlider.backgroundColor = [UIColor colorWithRed:90 / 255.0 green:65 / 255.0 blue:65 / 255.0 alpha:1];
        [self addSubview:viewForSlider];
        
        UIView *viewForSlider1 = [[UIView alloc] initWithFrame:CGRectMake(0, btnForNewPeople.top, self.width, 1)];
        viewForSlider1.backgroundColor = [UIColor colorWithRed:90 / 255.0 green:65 / 255.0 blue:65 / 255.0 alpha:1];
        [self addSubview:viewForSlider1];
        
     
        [self addSubview:btnForNewPeople];
        
        
        UIImageView *imageForAdd = [[UIImageView alloc]initWithFrame:CGRectMake(xForADDImage, yForADDImage, heightForAddImage, heightForAddImage)];
        imageForAdd.image = [UIImage imageNamed:@"增加用户"];
        imageForAdd.alpha = 0.7;
        [btnForNewPeople addSubview:imageForAdd];
        
        
        UILabel *labelForAdd = [[UILabel alloc]initWithFrame:CGRectMake(imageForAdd.right + 2, yForADDImage,widthForAddLabel , heightForAddImage)];
        labelForAdd.text = @"新增用户";
        labelForAdd.textColor = [UIColor whiteColor];
        labelForAdd.font = [UIFont boldSystemFontOfSize:20];
        labelForAdd.alpha = 0.7;
        [btnForNewPeople addSubview:labelForAdd];
        
        
        _tableViewForPeople = [[UITableView alloc]initWithFrame:CGRectMake(0, btnForNewPeople.bottom + 1, self.width, self.height - 3 * heightForCell - pageForCell * 2) style:UITableViewStylePlain];
        _tableViewForPeople.delegate = self;
        _tableViewForPeople.dataSource = self;
        _tableViewForPeople.backgroundColor = [UIColor clearColor];
        _tableViewForPeople.bounces = NO;
        _tableViewForPeople.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableViewForPeople];
        
      
        
        [self createForAboutUsBtn];
        
        [_tableViewForPeople registerClass:[PeopleTableViewCell class] forCellReuseIdentifier:strForCellPeople];
        
        /**
         *  隐藏cell
         */
        [self setExtraCellLineHidden:_tableViewForPeople];
    }

    return self;
}

#pragma mark 私有方法 ，创建关于我们和观音钱按钮
- (void)createForAboutUsBtn
{
    

    btnForGuanyinqian = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnForGuanyinqian setTitle:@"观音签" forState:UIControlStateNormal];
    [btnForGuanyinqian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnForGuanyinqian addTarget:self action:@selector(pushForGuanyinqian) forControlEvents:UIControlEventTouchUpInside];
    btnForGuanyinqian.backgroundColor = [UIColor clearColor];
    btnForGuanyinqian.frame = CGRectMake(0, self.bottom - heightForCell * 2 - pageForCell, self.width, heightForCell);
    [self addSubview:btnForGuanyinqian];
    
  
    
    
    btnForAboutUs = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnForAboutUs setTitle:@"关于我们" forState:UIControlStateNormal];
    [btnForAboutUs setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnForAboutUs addTarget:self action:@selector(pushAboutUs) forControlEvents:UIControlEventTouchUpInside];
    btnForAboutUs.backgroundColor = [UIColor clearColor];
    btnForAboutUs.frame = CGRectMake(0, btnForGuanyinqian.bottom, self.width, heightForCell);
    [self addSubview:btnForAboutUs];
    
    
    
    UIView *viewForSlider = [[UIView alloc]initWithFrame:CGRectMake(0, btnForGuanyinqian.top , self.width, 1)];
    viewForSlider.backgroundColor = colorForLine;
    [self addSubview:viewForSlider];
    
    UIView *viewForSlider1 =  [[UIView alloc]initWithFrame:CGRectMake(0, btnForGuanyinqian.bottom , self.width, 1)];
    viewForSlider1.backgroundColor = colorForLine;
    [self addSubview:viewForSlider1];
    
    UIView *viewForSlider2 =  [[UIView alloc]initWithFrame:CGRectMake(0, btnForAboutUs.bottom , self.width, 1)];
    viewForSlider2.backgroundColor = colorForLine;
    [self addSubview:viewForSlider2];

}


/**
 *  弹出关于我们的页面
 */
- (void)pushAboutUs
{
    
    if ([self.sliderDelegateForP respondsToSelector:@selector(pushAboutUs)]) {
        
        [self.sliderDelegateForP pushAboutUs];
        
    }

}

/**
 *  弹出观音签方法
 */
- (void)pushForGuanyinqian
{

        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://appsto.re/cn/LTwi7.i"]];
}

#pragma mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return _dataForPeople.count;
 
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return heightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    PeopleTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:strForCellPeople];
    
    if (!cell) {
        
        cell = [[PeopleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strForCellPeople];
        cell.tag = indexPath.row;
    
        
    }
    
 
    if (indexPath.row == 0) {
        
//        cell.nameForPeople.origin = CGPointMake(cell.nameForPeople.origin.x, cell.nameForPeople.origin.y);
//        cell.sexForPeople.origin = CGPointMake(cell.sexForPeople.origin.x, cell.sexForPeople.origin.y);
        
        NSDictionary *dic = _dataForPeople[indexPath.row];
      //  NSString *strForSex = dic[@"yinyang"];
      //  cell.sexForPeople.text = strForSex;
        cell.nameForPeople.text = dic[@"name"];
        NSString *strForYangli = [SuanxingTool returnActionForBornWithYear:[dic[@"yearsNow"] integerValue] andMonth:[dic[@"monthNow"] integerValue]andDay:[dic[@"dayNow"] integerValue] andHours:[dic[@"hoursNow"] integerValue]];
        NSString *strForY = [NSString stringWithFormat:@"阳历:%@",strForYangli];
        cell.yangliForPeople.text = strForY;
        cell.exampleImage.backgroundColor = [UIColor cyanColor];
        cell.headForPeople.image = [UIImage imageNamed:@"男"];
        
        
    }else{
       
//        cell.nameForPeople.origin = CGPointMake(cell.headForPeople.right + 2, cell.nameForPeople.origin.y);
//        cell.sexForPeople.origin = CGPointMake(cell.headForPeople.right + 2 + 35, cell.sexForPeople.origin.y);
        cell.exampleImage.backgroundColor = [UIColor clearColor];
        NSDictionary *dic = _dataForPeople[indexPath.row];
        NSString *strForSex = dic[@"yinyang"];
        
        if ([strForSex isEqualToString:@"阳男"] || [strForSex isEqualToString:@"阴男"]) {
            
            cell.headForPeople.image = [UIImage imageNamed:@"男"];
            
        }else{
        
            cell.headForPeople.image = [UIImage imageNamed:@"女"];
        }
        
       // cell.sexForPeople.text = strForSex;
        cell.nameForPeople.text = dic[@"name"];
        NSString *strForYangli = [SuanxingTool returnActionForBornWithYear:[dic[@"yearsNow"] integerValue] andMonth:[dic[@"monthNow"] integerValue]andDay:[dic[@"dayNow"] integerValue] andHours:[dic[@"hoursNow"] integerValue]];
        NSString *strForY = [NSString stringWithFormat:@"阳历:%@",strForYangli];
        cell.yangliForPeople.text = strForY;
    
    }
    

    
    
    return cell;

}



//改变删除字样
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return @"删除";

}

//选中cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //选择之前的people
    if ([self.sliderDelegateForP respondsToSelector:@selector(selectedForBeforePeople:)]) {
        
        [self.sliderDelegateForP selectedForBeforePeople:_dataForPeople[indexPath.row]];
    }


    tableView.editing = NO;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (indexPath.row == 0) {
        
        return;
    }
    
     UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"" message:@"您确定要删除该用户吗？删除操作后之前购买的产品将不在拥有" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    
    [alterView show];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
        
    {
        _indexForNowCell = indexPath.row;
        
        _dicForDelegate = self.dataForPeople[indexPath.row];
        
        [self.dataForPeople removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        
     
        
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
        
    }
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (buttonIndex == 0) {
        
        [_sliteF openSQL];
        
        [_sliteF deleteaNote:_dicForDelegate[@"name"]];
        
        NSLog(@"确定");
        
        
    }else{
       
        [self.dataForPeople insertObject:_dicForDelegate atIndex:_indexForNowCell];
        [_tableViewForPeople reloadData];
        NSLog(@"取消");
    }

}

#pragma mark 私有方法
- (void)actionForNewPeople
{
   
    //弹出视图
    if ([self.sliderDelegateForP respondsToSelector:@selector(pushForAddPeople)]) {
        
        [self.sliderDelegateForP pushForAddPeople];
        
    }

}

//隐藏tb的
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

//创建路径,判断是否已有
- (BOOL )filePath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    //创建路径
    NSString *pathStr = [documentsDir stringByAppendingPathComponent:@"save.sqlite"];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //   判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:pathStr];
   
    return find;
}



@end
