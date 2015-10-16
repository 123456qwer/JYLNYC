//
//  ToolForLabelSize.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/9/23.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "ToolForLabelSize.h"

@implementation ToolForLabelSize

//返回高度
+ (CGSize )returnStrHeight:(NSString *)str andFont:(UIFont *)font andWidth:(CGFloat )width andHeight:(CGFloat )height
{
    NSMutableParagraphStyle *mutableStyle = [[NSMutableParagraphStyle alloc]init];
    
    NSDictionary* dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:mutableStyle};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}

@end
