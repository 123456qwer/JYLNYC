//
//  MyTextField.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/25.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "MyTextField.h"

#define pageForY 20 / 1334.0 * kScreenHeight
#define pageForX 20 / 750.0 * kScreenWidth



@implementation MyTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawPlaceholderInRect:(CGRect)rect{
    UIColor *placeholderColor = [UIColor colorWithRed:211/ 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1];//设置颜色
    [placeholderColor setFill];
    
    CGRect placeholderRect = CGRectMake( pageForX, (rect.size.height- self.font.pointSize)/2, rect.size.width, self.height -  (rect.size.height- self.font.pointSize));//设置距离
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}

@end
