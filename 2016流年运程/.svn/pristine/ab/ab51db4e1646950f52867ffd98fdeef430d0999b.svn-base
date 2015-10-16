//
//  ViewForCountG.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/11.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "ViewForCountG.h"
#define kCountViewWidth (kScreenWidth - 60 - 15 * 3) / 2 + 50  //灰色View的宽度

@implementation ViewForCountG

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        
        /*
        //第一个宫的名字
        _labelForTitleFirst = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 100, 30)];
        _labelForTitleFirst.text = @"命宫";
        _labelForTitleFirst.backgroundColor = [UIColor orangeColor];
        [self addSubview:_labelForTitleFirst];
        
        //第一个宫
        _labelForFirst = [[UILabel alloc]initWithFrame:CGRectMake(0, _labelForTitleFirst.bottom + 5, 250, 200)];
        
        NSString *str1 = @"       逢到破军的命就一定是改变，但这有一个先破后成的过程。通常改变有两种，一种是按照自定的安排计划在进行的改变，另一种就是老天突如其来产生的让你不得不变的因素。比如公司产生一些变化，或者一些环境产生变化，让你不得不动。破军有去旧立新之意，最有效的变动必须是自己已经做好了准备的变动。\n        破军的改变有时候不会像之前模式一样，改变一定是大而不同的类型，所以一定要有大无畏的精神和一往直前的勇气，不要考虑太多，更不要因为改变带来的陌生感而害怕。由于改变，所以周遭很多的资源都是会重新来过，怎样尽早建立新的联系，熟悉新的环境和人际关系是目前对你来说最重要的事情。";
        [self acitonForText:str1 andLabel:_labelForFirst andX:0 andY:_labelForTitleFirst.bottom + 5 andFont:18];
        _labelForFirst.numberOfLines = 0;
        _labelForFirst.backgroundColor = [UIColor orangeColor];
  
        [self addSubview:_labelForFirst];
        
        
        //第二个宫的名字
        _labelForTitleOther = [[UILabel alloc]initWithFrame:CGRectMake(0, _labelForFirst.bottom + 35, 100, 30)];
        _labelForTitleOther.text = @"迁移";
        _labelForTitleOther.backgroundColor = [UIColor orangeColor];
        
        [self addSubview:_labelForTitleOther];
        
        //第二个宫
        _labelForOther = [[UILabel alloc]initWithFrame:CGRectMake(0, _labelForTitleOther.bottom + 5, 250, 200)];
        _labelForOther.backgroundColor = [UIColor orangeColor];
        NSString *str2 = @"        迁移宫是武曲和天相，这说明你在专业的部分很容易得到发展的平台和机会。如果有一些专业的技术机械等工具可以在2016年对外寻求到很好的发展空间，得到重要的人的赏识。";
        [self acitonForText:str2 andLabel:_labelForOther andX:0 andY:_labelForTitleOther.bottom + 5 andFont:18];
        _labelForOther.numberOfLines = 0;
        [self addSubview:_labelForOther];
        
        //开运标题
        _labelForTitleKaiyun = [[UILabel alloc]initWithFrame:CGRectMake(0, _labelForOther.bottom + 35, 100, 30)];
        _labelForTitleKaiyun.backgroundColor = [UIColor orangeColor];
        _labelForTitleKaiyun.text = @"开运建议";
        [self addSubview:_labelForTitleKaiyun];
        
        //开运建议
        _labelForKaiyun = [[UILabel alloc]initWithFrame:CGRectMake(0, _labelForTitleKaiyun.bottom + 5, 250, 200)];
        _labelForKaiyun.backgroundColor = [UIColor orangeColor];
        NSString *str3 = @"        改变是2016年很重要的因素，如果你可以接受改变，不抱太多的埋怨，不要把时间浪费在情绪调整上，努力付诸行动，力行改变，会为未来的发展打下很好的基础。另一方面，破军的人又带有一点心急，所以在讲求效率行事的时候要特别注意细心，静下心来去做，不要过多焦急，导致人与人之间的互动或者事情的仔细度不够。";
        [self acitonForText:str3 andLabel:_labelForKaiyun andX:0 andY:_labelForTitleKaiyun.bottom + 5 andFont:18];
        
        _labelForKaiyun.numberOfLines = 0;
        [self addSubview:_labelForKaiyun];
         */
        
    }
    
    return self;
    
}

/**
 *  自适应高度方法
 */
- (void)acitonForText:(NSString *)strForText
             andLabel:(UILabel *)label
                 andX:(CGFloat )xForLabel
                 andY:(CGFloat )yForLabel
              andFont:(CGFloat )fontSize
{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strForText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:0]; //行与行之间的间隔
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [strForText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
    //设置典故内容垂直居中
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByCharWrapping;
    [paragraph setLineSpacing:0];
    
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraph};
    
    CGSize tempSize = [strForText boundingRectWithSize:CGSizeMake(270,2000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    label.frame = CGRectMake(xForLabel, yForLabel, tempSize.width, tempSize.height);
    
   

}


/**
 *  代理方法，接受流年view传过来的数组
 */
- (void)turnTheTitle:(NSArray *)arrForGongName andNumber:(NSInteger)number
{
   
    NSString *nameForG0 = arrForGongName[0];
    NSString *nameForG1 = arrForGongName[1];
    
    if ([self.delegateForCount respondsToSelector:@selector(returnLabelCount:)]) {
        
        [self.delegateForCount returnLabelCount:number];
        
    }
    
    _labelForTitleFirst.text = nameForG0;
    _labelForTitleOther.text = nameForG1;
    
    

    
}


@end
