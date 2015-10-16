//
//  CountViewForSky.m
//  textforView
//
//  Created by 吴冬 on 15/7/28.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "CountViewForSky.h"
#import "UIViewExt.h"

#define kCountViewWidth (self.width - 15 * 3) / 2
#define kTagForView 350
#define kTagForLabel 450
#define kTagForDaxian 550
#define kTagForChangsheng 650
#define kTagForBoshi 750
#define kTagForShengxiao 850
#define kTagForXiaoxian 950

@implementation CountViewForSky
{
   
    NSMutableArray *_arrForLabelAllStar;

}

- (instancetype)initWithFrame:(CGRect)frame
              andCountForGong:(NSMutableDictionary *)gongDic
            andSanfangsizheng:(NSMutableDictionary *)sanfangDic
{

    if (self = [super initWithFrame:frame]) {
        
        //key  宫名：  星  大限  长生  博士  生肖
        _dicForAllStarandG = gongDic;
        
        //key  宫名:   4个宫
        _dicForSanfangsizheng = sanfangDic;
        
        _arrForLabelAllStar = [NSMutableArray array];
        
        //创建View
        [self createView];
        
    }
    
    return self;
}


/**
 *  创建View
 */
- (void)createView
{

    for (int i = 0; i < 4; i++) {
        
        int _y,_x;
        
        if (i < 2) {
            
            _y = 0;
            _x = i;
          
        }else{
           
            if(i == 2){
            
                _x = 0;
            }else{
            
                _x = 1;
            }
            
            _y = 1;
            
           
        }
        
        
        UIView *viewForText = [[UIView alloc]initWithFrame:CGRectMake(15 + _x * (kCountViewWidth + 15) , 15 + _y * (kCountViewWidth + 15), kCountViewWidth, kCountViewWidth)];
        viewForText.tag = i + kTagForView;
        viewForText.backgroundColor = [UIColor orangeColor];
        [self addSubview:viewForText];
        
        NSArray *arrForGong = _dicForSanfangsizheng[@"命宫"];
        
        NSString *strForGong = arrForGong[i];
        
        NSArray *arrForSiGong1 = _dicForAllStarandG[strForGong];

        NSDictionary *dicForStar = arrForSiGong1[0];
        NSDictionary *dicForDaxian = arrForSiGong1[1];
        NSDictionary *dicForChangsheng = arrForSiGong1[2];
        NSDictionary *dicForBoshi = arrForSiGong1[3];
        NSDictionary *dicForShengxiao = arrForSiGong1[4];
        NSDictionary *dicForXiaoxian = arrForSiGong1[5];
        //大限
        UILabel *labelForDaxian = [[UILabel alloc]initWithFrame:CGRectMake(0, viewForText.height - 20, 40, 20)];
        labelForDaxian.numberOfLines = 0;
        labelForDaxian.font = [UIFont systemFontOfSize:11];
        labelForDaxian.tag = kTagForDaxian + i;
        labelForDaxian.text = dicForDaxian[@"大限"];
        [viewForText addSubview:labelForDaxian];
        
        //小限
        UILabel *labelForXiaoxian = [[UILabel alloc]initWithFrame:CGRectMake(0, viewForText.height, viewForText.width, 20)];
        labelForXiaoxian.numberOfLines = 0;
        labelForXiaoxian.font = [UIFont systemFontOfSize:8];
        labelForXiaoxian.tag = kTagForXiaoxian + i;
        labelForXiaoxian.text = dicForXiaoxian[@"小限"];
        [viewForText addSubview:labelForXiaoxian];
        
        //长生
        UILabel *labelForChangsheng = [[UILabel alloc]initWithFrame:CGRectMake(40, viewForText.height - 20, 30, 20)];
        labelForChangsheng.numberOfLines = 0;
        labelForChangsheng.font = [UIFont systemFontOfSize:11];
        labelForChangsheng.tag = kTagForChangsheng + i;
        labelForChangsheng.text = dicForChangsheng[@"长生"];
        [viewForText addSubview:labelForChangsheng];
        
        //博士
        UILabel *labelForBoshi = [[UILabel alloc]initWithFrame:CGRectMake(70, viewForText.height - 20, 30,  20)];
        labelForBoshi.numberOfLines = 0;
        labelForBoshi.font = [UIFont systemFontOfSize:11];
        labelForBoshi.tag = kTagForBoshi + i;
        labelForBoshi.text = dicForBoshi[@"博士"];
        [viewForText addSubview:labelForBoshi];
        
        //生肖
        UILabel *labelForShengxiao = [[UILabel alloc]initWithFrame:CGRectMake(70, viewForText.height - 40, 30, 20)];
        labelForShengxiao.numberOfLines = 0;
        labelForShengxiao.font = [UIFont systemFontOfSize:11];
        labelForShengxiao.tag = kTagForShengxiao + i;
        labelForShengxiao.text = dicForShengxiao[@"生肖"];
        [viewForText addSubview:labelForShengxiao];
        
        NSArray *arrForStar = dicForStar[@"星"];
        
        //星
        for (int i = 0; i < arrForStar.count; i++) {
            
            if (i > 6) {
                
                
            }else{
            
                UILabel *labelForStar = [[UILabel alloc]initWithFrame:CGRectMake(viewForText.width - 15 - 15 * i, 0, 15, 60)];
                labelForStar.text = [NSString stringWithFormat:@"%@\n\t",arrForStar[i]];
                labelForStar.textColor = [UIColor blackColor];
                labelForStar.numberOfLines = 0;
                labelForStar.font = [UIFont systemFontOfSize:11];
                [viewForText addSubview:labelForStar];
                
                [_arrForLabelAllStar addObject:labelForStar];
            
            }
            
       
            
        }
        
        //宫
        UILabel *labelForGong = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewForText.width, viewForText.height)];
        NSArray *arrForSiGong = _dicForSanfangsizheng[@"命宫"];
        labelForGong.tag = kTagForLabel + i;
        labelForGong.text = arrForSiGong[i];
        [viewForText addSubview:labelForGong];
        
        
        
    }

}

/**
 *  代理方法（cell）
 */
- (void)actionForStar:(NSString *)dicForStar
{
    for (int i = 0; i < _arrForLabelAllStar.count; i++) {

        [_arrForLabelAllStar[i] removeFromSuperview];
        
    }
    
    for (int i = 0; i < _arrForLabelAllStar.count; i++) {
        
        [_arrForLabelAllStar removeObjectAtIndex:i];
        
    }
    
    for (int i = 0 ; i < 4; i++) {
        
        UIView *viewForLabel = [self viewWithTag:i + kTagForView];
         NSArray *arrForSiGong = _dicForSanfangsizheng[dicForStar];
  
       

        NSArray *arrForGong = _dicForSanfangsizheng[dicForStar];
        
        NSString *strForGong = arrForGong[i];
        
        NSArray *arrForSiGong1 = _dicForAllStarandG[strForGong];
        
        NSDictionary *dicForStar = arrForSiGong1[0];
        NSArray *arrForStar = dicForStar[@"星"];
        
        NSDictionary *dicForDaxian = arrForSiGong1[1];
        NSDictionary *dicForChangsheng = arrForSiGong1[2];
        NSDictionary *dicForBoshi = arrForSiGong1[3];
        NSDictionary *dicForShengxiao = arrForSiGong1[4];
        NSDictionary *dicForXiaoxian = arrForSiGong1[5];
        //宫
        UILabel *labelForGong = (UILabel *)[self viewWithTag:i + kTagForLabel];
        labelForGong.text = arrForSiGong[i];
        
        //大限
        UILabel *labelForDaxian = (UILabel *)[self viewWithTag:i + kTagForDaxian];
        labelForDaxian.text = dicForDaxian[@"大限"];
        
        //小限
        UILabel *labelForXiaoxian = (UILabel *)[self viewWithTag:i + kTagForXiaoxian];
        labelForXiaoxian.text = dicForXiaoxian[@"小限"];
        
        //长生
        UILabel *labelForChangsheng = (UILabel *)[self viewWithTag:i + kTagForChangsheng];
        labelForChangsheng.text = dicForChangsheng[@"长生"];
        
        //博士
        UILabel *labelForBoshi = (UILabel *)[self viewWithTag:i + kTagForBoshi];
        labelForBoshi.text = dicForBoshi[@"博士"];
        
        //生肖
        UILabel *labelForShengxiao = (UILabel *)[self viewWithTag:i + kTagForShengxiao];
        labelForShengxiao.text = dicForShengxiao[@"生肖"];
        
        //星
        for (int j = 0; j < arrForStar.count; j++) {
            
            if (j > 6) {
                
                
            }else{
            
                UILabel *labelForStar = [[UILabel alloc]initWithFrame:CGRectMake(viewForLabel.width - 15 - 15 * j, 0, 15, 60)];
                labelForStar.text = [NSString stringWithFormat:@"%@\n\t", arrForStar[j]];
                labelForStar.textColor = [UIColor blackColor];
                labelForStar.numberOfLines = 0;
                labelForStar.font = [UIFont systemFontOfSize:11];
                [viewForLabel addSubview:labelForStar];
                [_arrForLabelAllStar addObject:labelForStar];
                
            }
            
 
            
        }
        
        
        
        
    }
    

}



@end
