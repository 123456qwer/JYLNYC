//
//  ZijiangTableViewCell.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/20.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "ZijiangTableViewCell.h"

#define xForLabel 30 / 750.0 * kScreenWidth
#define yForLabel 28 / 1334.0 * kScreenHeight
#define heightForLabel 35 / 1334.0 * kScreenHeight
#define heightForCell 88 / 1334.0 * kScreenHeight


#define xForBtn 700 / 750.0 * kScreenWidth
#define yForBtn 24 / 1334.0 * kScreenHeight
#define widthForBtn 18 / 750.0 * kScreenWidth
#define heightForBtn  32 / 1334.0 * kScreenHeight

#define yForText  28 / 1334.0 * kScreenHeight
#define xForText  30 / 750.0 * kScreenWidth


@implementation ZijiangTableViewCell
{
    
   
 
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _labelForTitle = [[UILabel alloc]initWithFrame:CGRectMake(xForLabel, yForLabel, 200, heightForLabel)];
        _labelForTitle.textColor = colorForAll;
        _labelForTitle.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:_labelForTitle];
        
        
        _labelForText = [[UILabel alloc]initWithFrame:CGRectMake(xForText, yForText, kScreenWidth - xForText * 2 , 0)];
        _labelForText.numberOfLines = 0;
        _labelForText.hidden = YES;
        _labelForText.font = [UIFont systemFontOfSize:16];
        _labelForText.textAlignment = NSTextAlignmentJustified;
        [self addSubview:_labelForText];
        
        _imageForBtn = [[UIImageView alloc]initWithFrame:CGRectMake(xForBtn, yForBtn, widthForBtn, heightForBtn)];
        _imageForBtn.image = [UIImage imageNamed:@"收起"];
        [self addSubview:_imageForBtn];
        
        
    }
    
    return self;
  
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//获取上下文，画图
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect); //上分割线，
    //    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    //    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //    //下分割线
    
    NSLog(@"%lf",rect.size.height);
    NSLog(@"长度:%lf",heightForCell);
    if (rect.size.height - 1 > heightForCell ) {
        
        CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextStrokeRect(context, CGRectMake(0, heightForCell-1, rect.size.width, 0.1));
        
    }else{
    
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:215 /255.0 green:196 / 255.0 blue:183 / 255.0 alpha:1].CGColor);
        CGContextStrokeRect(context, CGRectMake(0, heightForCell - 1 , rect.size.width, 0.1));
    }

 


}

@end
