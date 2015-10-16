//
//  ViewForCountG.h
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/11.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiuNianView.h"
@class ViewForCountG;
@protocol viewForCountGDelegate <NSObject>

- (void)returnLabelCount:(NSInteger )number;

@end

@interface ViewForCountG : UIView<liunianViewDelegate>
@property (nonatomic ,strong)UILabel *labelForFirst;
@property (nonatomic ,strong)UILabel *labelForOther;
@property (nonatomic ,strong)UILabel *labelForTitleFirst;
@property (nonatomic ,strong)UILabel *labelForTitleOther;
@property (nonatomic ,strong)UILabel *labelForKaiyun;
@property (nonatomic ,strong)UILabel *labelForTitleKaiyun;
@property (nonatomic ,strong)NSArray *arrForData;

@property (nonatomic ,weak)id<viewForCountGDelegate>delegateForCount;
@property (nonatomic,copy)NSString *strForTitleFirst;
@end
