//
//  MyZijiangTableViewCell.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/16.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "MyZijiangTableViewCell.h"

@implementation MyZijiangTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self ) {
        
        CGFloat widthForSmall = 35 / 640.0 * kScreenWidth;
        CGFloat _widthForTable = 566 / 640.0 * kScreenWidth;

        _backGround = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _widthForTable, self.height)];
        NSLog(@"s0 %lf",self.width);
        _myTextView = [[UITextView alloc]initWithFrame:CGRectMake(widthForSmall, 0, _widthForTable - widthForSmall * 2, 150)];
        NSLog(@"s1 %lf",self.width);
       // _myTextView.textAlignment = NSTextAlignmentCenter;
       // _myTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0);
        _myTextView.hidden = YES;
        _myTextView.userInteractionEnabled = YES;
        _myTextView.editable = NO;
        _myTextView.selectable = NO;
        _myTextView.font = [UIFont systemFontOfSize:17];
        self.backgroundView = _backGround;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:_myTextView];
        
    }

    return self;
}



@end
