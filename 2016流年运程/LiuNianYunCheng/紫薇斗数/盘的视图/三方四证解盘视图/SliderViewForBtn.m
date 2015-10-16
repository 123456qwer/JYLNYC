//
//  SliderViewForBtn.m
//  textforView
//
//  Created by 吴冬 on 15/7/28.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "SliderViewForBtn.h"
#import "UIViewExt.h"
#import "BtnForGongCollectionViewCell.h"

static NSString *strForIdentifier = @"strForIdentifier";


@implementation SliderViewForBtn
{
  
    NSArray         *_btnArray;
    NSArray         *_arrForAllGong;
    CGFloat          _height;

}

//创建方法

- (instancetype)initWithFrame:(CGRect)frame
              andCountForGong:(NSMutableDictionary *)gongDic
            andSanfangsizheng:(NSMutableDictionary *)sanfangDic
                    andBtnArr:(NSArray *)arr
                    andHeight:(CGFloat )height
{
  
    if (self = [super initWithFrame:frame] ) {
        
        nextIndex = [NSIndexPath indexPathForItem:0 inSection:0];
        _height = height;
        _btnArray = arr;
        _arrForAllGong = @[@"命宫",@"夫妻",@"父母",@"兄弟",@"财帛",@"疾厄",@"福德",@"子女",@"田宅",@"官禄",@"奴仆",@"迁移"];
        
        _dicForAllStarandG = gongDic;
        _dicForSanfangsizheng = sanfangDic;
        
        flag[0] = YES;
        
        
        [self creatView];
        
    }
  
    return self;
    
}


- (void)creatView
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.width, _height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = -0.5;

    
    _sliderViewForBtn = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
    _sliderViewForBtn.delegate = self;
    _sliderViewForBtn.dataSource = self;
    _sliderViewForBtn.bounces = NO;
    _sliderViewForBtn.showsVerticalScrollIndicator = NO;
    _sliderViewForBtn.showsHorizontalScrollIndicator = NO;
    [self addSubview:_sliderViewForBtn];
    
    
    [_sliderViewForBtn registerClass:[BtnForGongCollectionViewCell class] forCellWithReuseIdentifier:strForIdentifier];

}



- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  
    return _btnArray.count;

}

//- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//   
//    return 1;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    BtnForGongCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:strForIdentifier forIndexPath:indexPath];
    
    cell.btnForGong.text = _btnArray[indexPath.row];

    
    return cell;

}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSLog(@"%ld",indexPath.row);
    
    NSString *strForNowGong = _arrForAllGong[indexPath.row];
    
    if ([self.sliderDelegate respondsToSelector:@selector(actionForStar:andNumber:)]) {
        
        [self.sliderDelegate actionForStar:strForNowGong andNumber:indexPath.row + 1];
        
    }
  
}





@end
