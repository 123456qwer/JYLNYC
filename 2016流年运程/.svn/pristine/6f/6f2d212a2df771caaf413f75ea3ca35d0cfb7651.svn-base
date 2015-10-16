//
//  MyPickerView.m
//  TextForPicker
//
//  Created by 吴冬 on 15/7/21.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "MyPickerView.h"

@implementation MyPickerView

- (id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        self.dataSource = self;
        
    }
    
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 4;
    
}//————返回一个数字，表示UIPickerView显示有多少列

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        return 81;
        
    }else if(component == 1){
       
        return 12;
    
    }else if(component == 2){
        
        if (_isRunYear && self.forDaysNowMonth == twoMonth) {
            
            return 29;
            
        }else if(_isRunYear == NO && self.forDaysNowMonth == twoMonth){
        
            return 28;
        
        }else if(self.forDaysNowMonth == bigMonth){
        
            return 31;
        
        }else{
        
            return 30;
        }
        
    }else{
      
        return 24;
    }
    
}//————返回数字，表示每一列显示的行数。


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        NSLog(@"年 %ld",row + 1936);
        NSInteger year = row + 1936;
        
        if (year % 4 == 0) {
            
            _isRunYear = YES;
            
        }else{
           
            _isRunYear = NO;
        
        }
        
        [self reloadComponent:2];
        if ([self.pickerViewDelegate respondsToSelector:@selector(actionForYear:)]) {
            
            [self.pickerViewDelegate actionForYear:year];
            
        }
        
    }else if(component == 1){
    
        NSLog(@"月 %ld",row + 1);
        NSInteger nowMonth = row + 1;
        
        //判断日期
        if (nowMonth == 1 || nowMonth == 3 || nowMonth == 5 || nowMonth == 7 || nowMonth == 8 || nowMonth == 10 || nowMonth == 12) {
            
            self.forDaysNowMonth = bigMonth;
            [self reloadComponent:2];
            [self forMonth:nowMonth];
          
            
        }else if(nowMonth == 2){
        
            self.forDaysNowMonth = twoMonth;
            [self reloadComponent:2];
            [self forMonth:nowMonth];

            
        }else{
          
            self.forDaysNowMonth = smallMonth;
            [self reloadComponent:2];
            [self forMonth:nowMonth];

        }

    }else if (component == 2){
       
        NSLog(@"日 %ld",row + 1);
        if ([self.pickerViewDelegate respondsToSelector:@selector(actionForDay:)]) {
            
            [self.pickerViewDelegate actionForDay:row + 1];
        }
        
    }else{
        
        NSLog(@"时 %ld",row + 1);
        
        if ([self.pickerViewDelegate respondsToSelector:@selector(actionForHours:)]) {
            
            [self.pickerViewDelegate actionForHours:row + 1];
        }

    }
    
}

- (void)forMonth:(NSInteger )month
{
   
    if ([self.pickerViewDelegate respondsToSelector:@selector(actionForMonth:)]) {
        
        [self.pickerViewDelegate actionForMonth:month];
        
    }
}

- (CGFloat )pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    
    return 32;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{

    UILabel *labelForTitle;
    
    if (component == 0) {
        
        NSLog(@"年");
        NSString *strFor = [NSString stringWithFormat:@"%ld年",row + 1936];
        labelForTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 4.0, 30)];
        labelForTitle.textAlignment = NSTextAlignmentCenter;
        labelForTitle.text = strFor;
        return labelForTitle;
        
    }else if (component == 1){
        
//        NSLog(@"月");
       NSString *strFor = [NSString stringWithFormat:@"%ld月",row + 1];
        labelForTitle = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 4.0, 0, kScreenWidth / 4.0, 30)];
        labelForTitle.text = strFor;
        labelForTitle.textAlignment = NSTextAlignmentCenter;

        return labelForTitle;
        
    }else if(component == 2){
        
//        NSLog(@"日");
        NSString *strFor = [NSString stringWithFormat:@"%ld日",row + 1];
        labelForTitle = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 4.0 * 2, 0, kScreenWidth / 4.0, 30)];
        labelForTitle.textAlignment = NSTextAlignmentCenter;

        labelForTitle.text = strFor;
        return labelForTitle;
        
    }else{
        
//        NSLog(@"小时");
        NSString *strFor = [NSString stringWithFormat:@"%ld时",row + 1];
        labelForTitle = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 4.0 * 3, 0, kScreenWidth / 4.0, 30)];
        labelForTitle.textAlignment = NSTextAlignmentCenter;

        labelForTitle.text = strFor;
        return labelForTitle;
        
    }
    
    

    

}

/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        NSLog(@"年");
        NSString *strFor = [NSString stringWithFormat:@"%ld年",row + 1936];
        return strFor;
        
    }else if (component == 1){
    
        NSLog(@"月");
        NSString *strFor = [NSString stringWithFormat:@"%ld月",row + 1];
        return strFor;
        
    }else if(component == 2){
    
        NSLog(@"日");
        NSString *strFor = [NSString stringWithFormat:@"%ld日",row + 1];
        return strFor;
        
    }else{
        
        NSLog(@"小时");
        NSString *strFor = [NSString stringWithFormat:@"%ld时",row + 1];
        return strFor;
    
    }

    
}
*/


@end
