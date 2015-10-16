//
//  LiuNianView.h
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/30.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiuNianSliderView.h"
@class LiuNianView;
@protocol liunianViewDelegate <NSObject>

- (void)turnTheTitle:(NSArray *)arrForGongName
           andNumber:(NSInteger )number;


@end

@interface LiuNianView : UIView<sliderViewForBtnDelegate>

@property (nonatomic ,strong)NSMutableDictionary *dicForAllStarandG;



- (instancetype)initWithFrame:(CGRect)frame
            andAllGongAndStar:(NSMutableDictionary *)dic
                  andArrForZM:(NSMutableArray *)arrforzm;

@property (nonatomic ,strong)NSMutableArray *arrForZM;
@property (nonatomic ,weak)id<liunianViewDelegate>liunianDelegate;

@end
