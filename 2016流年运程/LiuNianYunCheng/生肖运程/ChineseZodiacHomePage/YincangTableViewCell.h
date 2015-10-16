//
//  YincangTableViewCell.h
//  cell+block
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 金源互动. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface YincangTableViewCell : UITableViewCell

@property(strong,nonatomic)UILabel * contextLbl;
@property(strong,nonatomic)UIView * contextView;
@property(strong,nonatomic)UIImageView * zodicaImaView;
@property(strong,nonatomic)UILabel * yearLbl;
@property(strong,nonatomic)UILabel * nianfengLbl;
@property(strong,nonatomic)UILabel  * zodicaLbl;
@property(strong,nonatomic)UILabel * liuyuejixunLbl;

//适配相关
@property(nonatomic)CGFloat fontSize;

//生肖运程赋值方法
-(void)zodicaContentArray:(NSArray *)contentArray  andImage: (UIImage *) image andIndexPath:(NSInteger) indenxPath andYearArray: (NSArray *) yearArray  andZodicaStr:(NSString * )zodicaStr;

//六十甲子赋值
- (void)liushiContentArray:(NSArray *)contentArray andIndexPath:(NSInteger) indenxPath;

//流月
- (void)liuyueContentDict:(NSDictionary *)contentDict andKeyArrar:(NSArray *)kerArray  andIndexPath:(NSInteger) indenxPath;
@end
