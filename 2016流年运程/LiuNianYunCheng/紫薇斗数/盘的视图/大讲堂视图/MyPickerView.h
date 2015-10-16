//
//  MyPickerView.h
//  TextForPicker
//
//  Created by 吴冬 on 15/7/21.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyPickerView;
@protocol MyPickerViewDelegate <NSObject>

- (void)actionForYear:(NSInteger )year;
- (void)actionForMonth:(NSInteger )month;
- (void)actionForDay:(NSInteger )day;
- (void)actionForHours:(NSInteger )hour;

@end


@interface MyPickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>


typedef NS_ENUM(NSInteger, forDays)
{

    bigMonth = 1,
    smallMonth = 2,
    twoMonth = 3,
    
};

@property (nonatomic ,assign)forDays forDaysNowMonth;
@property (nonatomic ,assign)BOOL isRunYear;
@property (nonatomic ,weak)id<MyPickerViewDelegate>pickerViewDelegate;


@end
