//
//  JiepanTableViewCell.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/17.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JiepanTableViewCell.h"

@implementation JiepanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//创建cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        CGFloat widthForSmall = 35 / 640.0 * kScreenWidth;
        CGFloat _widthForTable = 566 / 640.0 * kScreenWidth;
        
        _imageForJiepan = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _widthForTable, self.height)];
        self.backgroundView = _imageForJiepan;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _myTextView = [[UITextView alloc]initWithFrame:CGRectMake(widthForSmall, 0,_widthForTable - widthForSmall * 2, 150)];
        _myTextView.textAlignment = NSTextAlignmentCenter;
        // _myTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0);
        _myTextView.hidden = YES;
        _myTextView.userInteractionEnabled = YES;
        _myTextView.editable = NO;
        _myTextView.selectable = NO;
        [self addSubview:_myTextView];
    }

    return self;
}




@end
