//
//  lineChartView.h
//  折线图
//
//  Created by 君未央 on 2017/4/19.
//  Copyright © 2017年 wuquxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lineChartView : UIView
{

}

@property(nonatomic ,strong)UIScrollView *scrollView ;
@property(nonatomic ,strong)UIScrollView *scrollLabel ;

@property(nonatomic ,strong)NSMutableArray *arrBrokenLine ;
@property(nonatomic ,strong)NSMutableArray *arrCoordinatesY ;
@property(nonatomic ,strong)NSMutableArray *arrCoordinatesX ;

@property(nonatomic ,strong)UIColor *attuneColor ;
@property(nonatomic ,strong)UIColor *lineColor ;
@property(nonatomic ,strong)UIColor *scaleColor ;

@property(nonatomic ,assign)float ItemSpacing ;

-(void)buildUI ;

@end
