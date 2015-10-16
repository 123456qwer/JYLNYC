//
//  ConetentForPanViewController.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/7/23.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "ConetentForPanViewController.h"

@interface ConetentForPanViewController ()
{
   
    UIImageView *_imageViewForBg;

    UIButton    *_btnForBack;
    CGFloat      _xForBackBtn;
    CGFloat      _yForBackBtn;
    CGFloat      _widthForBackBtn;
    CGFloat      _heightForBackBtn;
    CGFloat      _yForLabel;
    
    NSMutableAttributedString    *_textForCaiboStr1;
    
    
    
}
@end

@implementation ConetentForPanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *str1 = @"        \n财帛宫——紫微：\n        紫微是一颗帝王之星，因此当它位于财帛宫时，一生之中在金钱方面无忧，能轻松顺利赚到钱，财源滚滚。\n        紫微是领导型的星耀，所以紫微在财帛宫的人，通常都会制定较完善的财务计划，并能妥善控制钱财的收入支出。遭逢困境时，也会有贵人及朋友提供援助，基本不会出现问题。一般致富都是靠自己的本事，适合自行创业，或进入大规模的企业一展所长。\n         紫微守财帛宫，即使是在最好的情形，也只是说财源充裕，并不一定能积聚储蓄起来，因为紫微是一颗偏重于名誉与权力的星，而不是财星。\n        紫微在财帛宫的人，所拥有的财富范围很广,除了世界各国的通用货币之外,可能还有金银珠宝、股票、土地、房屋等。换句话说，容易有具抽象化的财产,或是因抽象的事物而进财。比如经商者已有名声,因此以其姓名为号召而经商得利,或是本身具有商誉,因其信用好而进财等。\n        紫微位于财帛宫的人，有机会可以享受到他人留下的钱财(不是继承)，比如出生在富贵之家,从小就能享受到父母的钱财，或是可享用到兄弟、朋友提供的钱财,或是大限、流年财帛宫有紫微星时,也可以以正当的方式得到他人资助的钱财。\n        不过，有时不免在钱财方面存在不足为外人道也的现象。如经商失败,但仍住豪屋,有汽车代步,穿着体面,看来生活优裕,但并非自力赚取的生活费(比如靠兄弟亲友帮忙,或靠变买家中原存的金饰生活,而外人皆不知实情),或是虽有不动产、股票,但皆因出现变故无法变卖,使人误以为富有等。"
    ;
    
    NSMutableAttributedString *number1 = [[NSMutableAttributedString alloc]initWithString:str1];
    
    [number1 addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, str1.length)];
    
    NSString *str2 = @"\n        财帛宫——七杀\n        偏好自由自在的方式赚钱，容易厌烦长期安稳的工作，对顶头上司的约束也不能习惯。比较适合自行创业、或是技术性工作、自由职业等。容易在外地或远方发展顺利，得到使人欣羡不已的成功。\n        七杀是一颗开创性、冲撞性、执行力非常强的一颗星，所以在一生行运起伏变化相对的就不是那么平稳。行运好的时候，自然可以创造不小的财富，行运低落的时候就难免有孤注一掷的危机。";
    NSString *str3 = [str2 stringByAppendingString: @"\n        财帛宫——福德宫\n        财帛宫：财帛宫是七杀，是个很有权利的欲望，2016年可以有效的开展一些聚财的路线，增加不同领域的收入所以今年在业务单位来讲，在业绩的开创上运势不错，多花些功夫，多下些成本回报会相对更大。\n        福德宫：福德宫对应的是廉贞和天府，可是2016年是廉贞化忌，而福德宫代表的是内在心思，先天的福分，所以一定要特别注意自己内心的不平稳，包括对外的很多东西，比如情绪的表达，内心的纠结等，容易自寻烦恼。今年适合按部就班的创造财运，不适合投机取巧靠运气赚钱，比如股票、彩票等东西。\n        开运建议：不要压抑自己的情绪，避免因为急躁和处理不当而与人产生是非。最好的方法就是找到合适的感情寄托，尝试出去运动放松一下，转移自己的注意力。"];
    
    NSMutableAttributedString *number2 = [[NSMutableAttributedString alloc]initWithString:str3];
    [number2 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, str3.length)];
    
    NSString *str4 = @"\n        财帛宫——七杀（变数）\n        凡七杀在财帛宫的，田宅宫一定是太阴，如果太阴落陷，就千万要注意防火灾或兵灾。七杀在财帛宫经常会遇见禄、权、科等星耀，这将会更有助于诸事吉祥，很有可能掌握财务大权。\n        若七杀有禄，且见吉曜而无煞，则表示在经历风险之后亦可以平安无事，能在友人的帮助下东山再起。\n        擅于理财,与禄存同宫或会照化禄时,容易得到理财的机会或者工作，比如从事财经工作,或是替家中事业管理财务。\n        但若无吉有煞，或吉少煞重，则很可能在经过风波后恢复元气时举步维艰，甚至有可能一蹶不振。\n        七杀与禄存、天马星同宫，会照禄马交驰，会照化禄、化权、化科及六吉星时，在现代往往能够成为跨国机构掌财掌权的人物，局面小的亦能得掌远方财源。但是进菜劳神费力，钱财进出，数量甚大。\n        七杀与空劫、大耗同度相会，则会谋财费力。而且得到钱财的同时会产生耗损。\n        如果与天刑同见，则不宜在偏门行业工作，否则容易招惹官司刑事。\n        七杀与擎羊并行则主争夺；\n        七杀与陀罗并行恐会招人嫉妒；\n        七杀与火铃并行则易暴富横发但也容易钱财破败。\n        七杀会煞曜，而且见刑耗，或者文曲化忌者，一生将容易招惹盗贼。\n        即使与禄存星同宫,或是会照化禄、化权、化科、左辅、右弼、天魁、天钺等星,一生之中都不免在钱财上有一次大的大变化。若大限或流年不吉利的话,则会有重大损失。";
    NSMutableAttributedString *number3 = [[NSMutableAttributedString alloc]initWithString:str4];
    
    [number3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str4.length)]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度

    //
//    [str5 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:NSMakeRange(0, 10)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度

    [number1 appendAttributedString:number2];
    [number1 appendAttributedString:number3];
    
    _textForCaiboStr1 = number1;
    
    
    //创建视图用到的frame
    [self createFrameForView];
    
    //创建背景图片
    _imageViewForBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_imageViewForBg];
    
    
    //返回按钮
    _btnForBack = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnForBack.frame = CGRectMake(_xForBackBtn, _yForBackBtn , _widthForBackBtn, _heightForBackBtn);
    [_btnForBack addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnForBack setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [self.view addSubview:_btnForBack];
    
    
    
    if ([self.strForPan isEqualToString:@"爱情"]) {
        
        NSLog(@"爱情");
        [self setForBgWithStr:@"爱情.jpg"];
        
    }else if([self.strForPan isEqualToString:@"事业"]){
      
        NSLog(@"事业");
        [self setForBgWithStr:@"事业.jpg"];

    }else if ([self.strForPan isEqualToString:@"钱财"]){
    
        NSLog(@"钱财");
        [self setForBgWithStr:@"钱财.jpg"];
        
        //创建钱财相关label
        [self createGold];

    }else if([self.strForPan isEqualToString:@"健康"]){
    
        NSLog(@"健康");
        [self setForBgWithStr:@"健康.jpg"];

    }else if([self.strForPan isEqualToString:@"父母"]){
    
        NSLog(@"父母");
        [self setForBgWithStr:@"父母.jpg"];

    }else if([self.strForPan isEqualToString:@"兄弟"]){
    
        NSLog(@"兄弟");
        [self setForBgWithStr:@"兄弟.jpg"];

    }
    
  
}

//创建frame
- (void)createFrameForView
{

    _yForBackBtn = 57 / 1136.0 * kScreenHeight;
    _xForBackBtn = 10 / 640.0 * kScreenWidth;
    _widthForBackBtn = 116 / 640.0 * kScreenWidth;
    _heightForBackBtn = 52 / 1136.0 * kScreenHeight;
    _yForLabel = _yForBackBtn + _heightForBackBtn + 20;

}

/**
 *  返回方法
 */
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

/**
 *  设置背景
 *
 *  @param strForBg 背景的字符
 */
- (void)setForBgWithStr:(NSString *)strForBg
{
   
    _imageViewForBg.image = [UIImage imageNamed:strForBg];
   
}


/***************************************钱财**************************************************************/

- (void)createGold
{

    UITextView *labelForZhu1 = [[UITextView alloc]initWithFrame:CGRectMake(5, _yForLabel - 15, kScreenWidth - 10, kScreenHeight - _yForLabel + 15)];
    labelForZhu1.attributedText = _textForCaiboStr1;
    labelForZhu1.editable = NO;
    [self.view addSubview:labelForZhu1];
    
    labelForZhu1.backgroundColor = [UIColor clearColor];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
