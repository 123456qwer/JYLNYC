//
//  LiuNianSliderView.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/30.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "LiuNianSliderView.h"
#import "BtnForGongCollectionViewCell.h"

#define heightForCell 180 / 1334.0 * kScreenHeight

static NSString *strForIdentifier = @"strForIdentifier";


@implementation LiuNianSliderView
{
    
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSArray *arr = @[@"综合运势",@"感情运势",@"事业运势",@"财运运势",@"健康运势",@"家庭运势",@"人际运势"];
    
    BtnForGongCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:strForIdentifier forIndexPath:indexPath];
    cell.btnForGong.text = arr[indexPath.row];
    
    if (flag[indexPath.row]) {
        
        cell.backgroundColor = [UIColor colorWithRed:232 / 255.0 green:113 / 255.0 blue:113 / 225.0 alpha:1];
        
    }else{
    
       
        cell.backgroundColor = [UIColor colorWithRed:197 / 255.0 green:187 / 255.0 blue:174 / 255.0 alpha:1];

    }
    
    
    return cell;
 
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (nextIndex == indexPath) {
        
        return;
        
    }
    
    for (int i = 0; i < 7; i++) {
        
        flag[i] = NO;
        
    }
    
    flag[indexPath.row] = !flag[indexPath.row];

    
        BtnForGongCollectionViewCell *cell = (BtnForGongCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor =  [UIColor colorWithRed:232 / 255.0 green:113 / 255.0 blue:113 / 225.0 alpha:1];
        
        BtnForGongCollectionViewCell *nextCell = (BtnForGongCollectionViewCell *)[collectionView cellForItemAtIndexPath:nextIndex];
        nextCell.backgroundColor = [UIColor colorWithRed:197 / 255.0 green:187 / 255.0 blue:174 / 255.0 alpha:1];
    
    
    
    
    NSArray *_arrForAllGong = @[@"综合",@"2",@"3",@"4",@"5",@"6",@"7"];
    
    
    NSLog(@"%ld",indexPath.row);
    
    NSString *strForNowGong = _arrForAllGong[indexPath.row];
    
    nextIndex = indexPath;

    //代理方法，传值给俩个宫的View
    if ([self.sliderDelegate respondsToSelector:@selector(actionForStar:andNumber:)]) {
        
        [self.sliderDelegate actionForStar:strForNowGong andNumber:indexPath.row + 1];
        
    }

}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//  
//    
//  
//}





@end
