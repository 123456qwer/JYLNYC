//
//  SliderViewForBtn.h
//  textforView
//
//  Created by 吴冬 on 15/7/28.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SliderViewForBtn;
@protocol sliderViewForBtnDelegate <NSObject>

- (void)actionForStar:(NSString *)strForGong
            andNumber:(NSInteger )number;

@end


@interface SliderViewForBtn : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
   
    BOOL flag[20];
    NSIndexPath *nextIndex;
 
}
- (instancetype)initWithFrame:(CGRect)frame
              andCountForGong:(NSMutableDictionary *)gongDic
            andSanfangsizheng:(NSMutableDictionary *)sanfangDic
                    andBtnArr:(NSArray *)arr
                    andHeight:(CGFloat )height;

@property (nonatomic ,strong)UICollectionView *sliderViewForBtn;
@property (nonatomic ,assign)NSInteger countForCell;
@property (nonatomic ,strong)NSMutableDictionary *dicForAllStarandG;
@property (nonatomic ,strong)NSMutableDictionary *dicForSanfangsizheng;
@property (nonatomic ,weak)id<sliderViewForBtnDelegate>sliderDelegate;

@end
