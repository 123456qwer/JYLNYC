//
//  ToolForLabelSize.h
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/9/23.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolForLabelSize : NSObject

//返回高度
+ (CGSize )returnStrHeight:(NSString *)str andFont:(UIFont *)font andWidth:(CGFloat )width andHeight:(CGFloat )height;

@end
