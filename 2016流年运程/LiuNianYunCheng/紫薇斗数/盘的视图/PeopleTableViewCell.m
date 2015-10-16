//
//  PeopleTableViewCell.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/14.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "PeopleTableViewCell.h"
#import "SuanxingTool.h"

//性别图标
#define xForSexImage 20 / 750.0 * kScreenWidth
#define yForSexImage 24 / 1334.0 * kScreenHeight
#define widthForImage 74 / 1334.0 * kScreenHeight


//姓名
#define pageForName 24 / 750.0 * kScreenWidth
#define yForName 26 / 1334.0 * kScreenHeight
#define heightForName 32 / 1334.0 * kScreenHeight

//阳历
#define pageForYangliX 22 / 750.0 * kScreenWidth
#define pageForYangliY 12 / 1334.0 * kScreenHeight


@implementation PeopleTableViewCell
{
   
    UIFont *_fontForName;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _headForPeople = [[UIImageView alloc]initWithFrame:CGRectMake(xForSexImage, yForSexImage, widthForImage, widthForImage)];

        _headForPeople.image = [UIImage imageNamed:@"男.png"];
        [self addSubview:_headForPeople];
        
        
//        _exampleImage = [[UIImageView alloc]initWithFrame:CGRectMake(_headForPeople.right + 2, 5, 44 - 10, 44 - 20)];
//        _exampleImage.backgroundColor = [UIColor cyanColor];
//        [self addSubview:_exampleImage];
        
        
        [self createFont];
        
        
        _nameForPeople = [[UILabel alloc]initWithFrame:CGRectMake(_headForPeople.right + pageForName , yForName, 200, heightForName)];
        _nameForPeople.textColor = [UIColor whiteColor];
        _nameForPeople.font = _fontForName;
        _nameForPeople.userInteractionEnabled = YES;
        [self addSubview:_nameForPeople];
        
        
        _yangliForPeople = [[UILabel alloc]initWithFrame:CGRectMake(_headForPeople.right + pageForYangliX, _nameForPeople.bottom + pageForYangliY, 200  , pageForYangliX)];
        _yangliForPeople.font = [UIFont systemFontOfSize:11];
        _yangliForPeople.textColor = [UIColor whiteColor];
        _yangliForPeople.alpha = 0.7;
        _yangliForPeople.userInteractionEnabled = YES;
        [self addSubview:_yangliForPeople];
        
        
        _sexForPeople = [[UILabel alloc]initWithFrame:CGRectMake(_nameForPeople.right , 5, 44, 20)];
        _sexForPeople.font = [UIFont systemFontOfSize:12];
        _sexForPeople.userInteractionEnabled = YES;
        [self addSubview:_sexForPeople];
        
        self.backgroundColor = [UIColor clearColor];
        
        
    }

    return self;
}

- (void)createFont
{
   
    NSString *str =  [SuanxingTool getCurrentDeviceModel];
    
    
    
    if ([str isEqualToString:@"iPhone 4"] || [str isEqualToString:@"iPhone 4S"]) {
        
        
        _fontForName = [UIFont systemFontOfSize:13];

        
    }else if([str isEqualToString:@"iPhone 5"] || [str isEqualToString:@"iPhone 5c"] || [str isEqualToString:@"iPhone 5s"]){
        
        _fontForName = [UIFont systemFontOfSize:15];

        
    }else if([str isEqualToString:@"iPhone 6"]){
        
        _fontForName = [UIFont systemFontOfSize:18];


        
    }else if([str isEqualToString:@"iPhone 6 Plus"]){
        

        
    }else{
        
        _fontForName = [UIFont systemFontOfSize:18];
        
    }
    

  
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
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:90 / 255.0 green:65 / 255.0 blue:65 / 255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

- (void)awakeFromNib {



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
