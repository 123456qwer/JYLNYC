//
//  LiunianJPViewController.h
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/30.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewForCountG.h"
#import <StoreKit/StoreKit.h>

@interface LiunianJPViewController : UIViewController<UIScrollViewDelegate,viewForCountGDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic ,strong)UIView *viewForStar;
@property (nonatomic ,strong)NSMutableDictionary *dicForAllStarandG;
@property (nonatomic ,strong)NSMutableDictionary *dicForSanfangsizheng;
@property (nonatomic ,strong)NSMutableArray *arrForZM;

@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *burnDay;


//dicForAllStarandG数据结构



@end
