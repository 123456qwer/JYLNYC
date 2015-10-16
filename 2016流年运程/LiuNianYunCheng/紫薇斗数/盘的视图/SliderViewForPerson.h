//
//  SliderViewForPerson.h
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/12.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleModel.h"
#import "SqliteForPeople.h"

@class SliderViewForBtn;
@protocol SliderViewForBtnDelegate <NSObject>

/**
 *  增加新用户的方法
 */
- (void)pushForAddPeople;
- (void)pushAboutUs;

/**
 *  选择之前拥有的用户方法
 */
- (void)selectedForBeforePeople:(NSDictionary *)peopleDic;

@end


@interface SliderViewForPerson : UIView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic ,strong)UITableView *tableViewForPeople;
@property (nonatomic ,strong)NSMutableArray     *dataForPeople;
@property (nonatomic ,weak)id<SliderViewForBtnDelegate>sliderDelegateForP;

@end
