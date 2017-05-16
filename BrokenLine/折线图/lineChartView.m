//
//  lineChartView.m
//  折线图
//
//  Created by 君未央 on 2017/4/19.
//  Copyright © 2017年 wuquxing. All rights reserved.
//

#import "lineChartView.h"

#define tableX 15
#define tableY 20

@interface lineChartView ()<CAAnimationDelegate,UIScrollViewDelegate>
{
    BOOL isXYSame ;
    CGFloat GapBetweenY ;
    CGFloat GapBetweenX ;
    
    CGFloat tableWidth ;
    CGFloat tableHight ;
    NSMutableArray *arrPoint ;
}

@end

@implementation lineChartView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        arrPoint = [[NSMutableArray alloc]init];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 0, frame.size.width - 20, frame.size.height - 20)];
        _scrollView.delegate = self ;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES ;
        
        _scrollLabel = [[UIScrollView alloc]initWithFrame:CGRectMake(20, _scrollView.frame.size.height + _scrollView.frame.origin.y, frame.size.width - 20, 20)];
        _scrollLabel.showsHorizontalScrollIndicator = NO ;
        _scrollLabel.userInteractionEnabled = NO ;
        
        tableWidth = _scrollView.frame.size.width - tableX * 2 ;
        tableHight = _scrollView.frame.size.height - tableY - 5 ;
        
        UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScrollView:)];
        [_scrollView addGestureRecognizer:tapScroll];
    }
    
    return self ;
}

-(void)buildUI
{
    [self addSubview:_scrollView];
    [self addSubview:_scrollLabel];
    
    _arrCoordinatesX = [[NSMutableArray alloc]init];
    for (int t = 0; t < 14; t ++) {
        
        [_arrCoordinatesX addObject:[NSString stringWithFormat:@"%d",t]];
    }

    _arrCoordinatesY = [[NSMutableArray alloc]init];
    for (int t = 0; t < 7; t ++) {
        [_arrCoordinatesY addObject:[NSString stringWithFormat:@"%d",t]];
    }
    
    _arrCoordinatesY = (NSMutableArray *)[[_arrCoordinatesY reverseObjectEnumerator] allObjects];
    
    _arrBrokenLine = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 14; i++) {
        CGFloat num = arc4random_uniform(6);
        NSString *str = [NSString stringWithFormat:@"%f",num];
        [_arrBrokenLine addObject:str];
    }
    
    
    

    NSString *strY = [_arrCoordinatesY lastObject];
    NSString *strX = [_arrCoordinatesX firstObject];
    
    if ([strX isEqualToString:strY] && _arrCoordinatesX.count <=7) {
        isXYSame = YES ;
    }else{
        isXYSame = NO ;
    }
    
    CGFloat width = 40 ;
    
    if (_arrCoordinatesX.count <= 7) {
        width = tableWidth / (_arrCoordinatesX.count -1) ;
    }else if (_arrCoordinatesX.count > 7){
        width = _ItemSpacing != 0 ? _ItemSpacing : 40 ;
    }
    
    GapBetweenX = width ;
    
    CGFloat hight = tableHight / (_arrCoordinatesY.count -1);
    GapBetweenY = hight ;

    _scrollView.contentSize = CGSizeMake(GapBetweenX * (_arrCoordinatesX.count-1) + tableX*2,_scrollView.bounds.size.height);
    tableWidth = _scrollView.contentSize.width - tableX * 2 ;
    tableHight = _scrollView.contentSize.height - tableY -5 ;
    
    
    [self drawTheHorizontalLine];
    [self drawTheVerticalLine];
    
    [self drawTheBrokenLine];
    
    
    _scrollView.contentOffset = CGPointMake(_scrollView.contentSize.width - _scrollView.bounds.size.width, 0);
    
    
}

-(void)drawTheHorizontalLine
{
    
    /// 横线
    UIColor *colorY = _lineColor != nil ? _lineColor : [UIColor colorWithRed:221/250.0 green:221/250.0 blue:221/250.0 alpha:1] ;
    UIColor *colorLabel = _scaleColor != nil ? _scaleColor : [UIColor colorWithRed:135/250.0 green:135/250.0 blue:135/250.0 alpha:1];

    for (int t = 0; t < _arrCoordinatesY.count ; t ++) {
        
        CAShapeLayer *shapeLayerY = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(tableX , GapBetweenY * t + tableY)];
        [path addLineToPoint:CGPointMake(tableWidth + tableX, GapBetweenY * t + tableY)];
        [path closePath];
        
        shapeLayerY.path = path.CGPath ;
        shapeLayerY.strokeColor = colorY.CGColor;
        shapeLayerY.fillColor = [[UIColor clearColor] CGColor];
        shapeLayerY.lineWidth = 0.5 ;
        [_scrollView.layer addSublayer:shapeLayerY];
        
        UILabel *lbY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        lbY.center = CGPointMake(lbY.center.x, GapBetweenY * t  + tableY);
        lbY.text = [_arrCoordinatesY objectAtIndex:t];
        lbY.textColor = colorLabel ;
        lbY.textAlignment = NSTextAlignmentCenter ;
        lbY.font = [UIFont systemFontOfSize:14];
        lbY.backgroundColor = [UIColor whiteColor];
        [self addSubview:lbY];
        
        if (isXYSame && t == _arrCoordinatesY.count - 1) {
            
            lbY.hidden = YES ;
        }
    }
}

-(void)drawTheVerticalLine
{
    UIColor *colorX =  _lineColor != nil ? _lineColor : [UIColor colorWithRed:221/250.0 green:221/250.0 blue:221/250.0 alpha:1] ;

    UIColor *colorLabel = _scaleColor != nil ? _scaleColor : [UIColor colorWithRed:135/250.0 green:135/250.0 blue:135/250.0 alpha:1];
    /// 竖线
    for (int t = 0; t < _arrCoordinatesX.count ; t ++) {
        
        CAShapeLayer *shapeLayerX = [CAShapeLayer layer];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(GapBetweenX * t + tableX, 0 + tableY)];
        [path addLineToPoint:CGPointMake(GapBetweenX * t + tableX,( _arrCoordinatesY.count -1)* GapBetweenY + tableY )];
        [path closePath];
        
        shapeLayerX.path = path.CGPath ;
        shapeLayerX.strokeColor = colorX.CGColor;
        shapeLayerX.lineWidth = 0.5 ;
        [_scrollView.layer addSublayer:shapeLayerX];
        
        UILabel *lbX = [[UILabel alloc]initWithFrame:CGRectMake(20,0 , 20, 20)];
//        if (t == 0) {
//            lbX.center = CGPointMake(subFrame.origin.x +lbX.frame.size.width/2, lbX.center.y);
//            if (isXYSame) {
//                lbX.center = CGPointMake(subFrame.origin.x -lbX.frame.size.width/2, lbX.center.y);
//            }
//        }else{
            lbX.center = CGPointMake( GapBetweenX * t + tableX , lbX.center.y);
//        }
        
        
        lbX.text = [_arrCoordinatesX objectAtIndex:t];
        lbX.textColor = colorLabel ;
        lbX.textAlignment = NSTextAlignmentCenter;
        lbX.font = [UIFont systemFontOfSize:14];
        
        [_scrollLabel addSubview:lbX];
        
        _scrollLabel.contentSize = CGSizeMake(lbX.frame.origin.x +lbX.frame.size.width, 20);
    }
}

-(void)drawTheBrokenLine
{
    UIColor *color = _attuneColor != nil ? _attuneColor : [UIColor colorWithRed:47/250.0 green:131/250.0 blue:228/250.0 alpha:1] ;
    /// 最大
    CGFloat maxY = [[_arrCoordinatesY firstObject] floatValue];
    /// 最小
    CGFloat minY = [[_arrCoordinatesY lastObject] floatValue];
    
    
    /// 折线 layer 容器
    CAShapeLayer *shapeLayerX = [CAShapeLayer layer];
    shapeLayerX.lineCap = kCALineCapRound ;
    shapeLayerX.lineJoin = kCALineJoinBevel ;
    shapeLayerX.fillColor = [UIColor whiteColor].CGColor;
    shapeLayerX.lineWidth = 1.0 ;
    shapeLayerX.strokeEnd = 0.0 ;
    shapeLayerX.strokeColor = color.CGColor ;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat line = [[_arrBrokenLine objectAtIndex:0] floatValue];
    CGFloat coordinates = tableHight/(maxY - minY) * (maxY - line) + tableY;
    CGPoint point0 = CGPointMake(tableX, coordinates );
    
    [path moveToPoint:point0];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    
    [_scrollView.layer addSublayer:shapeLayerX];

    /// 背景图 layer
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    
    gradLayer.frame = CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height);
    
    gradLayer.colors = @[(__bridge id)RGBCOLOR_ALPHA(47, 131, 228, 0.3).CGColor,(__bridge id)RGBCOLOR_ALPHA(47, 131, 228, 0.3).CGColor,(__bridge id)RGBCOLOR_ALPHA(47, 131, 228, 0.3).CGColor];
    
    gradLayer.startPoint = CGPointMake(0, 1);
    gradLayer.endPoint = CGPointMake(0, 1);
    gradLayer.locations = @[@0.2,@0.5,@0.7];
    [_scrollView.layer addSublayer:gradLayer];
    
    UIBezierPath *pathLayer = [[UIBezierPath alloc]init];
    [pathLayer moveToPoint:CGPointMake(tableX, _scrollView.contentSize.height -5)];
    
    
    for (int t = 0; t < _arrBrokenLine.count; t ++) {
        
        CGFloat lineY = [[_arrBrokenLine objectAtIndex:t] floatValue];
        CGFloat lineX = GapBetweenX *t + tableX  ;
        
        CGFloat coordinatesY = (tableHight)/(maxY - minY) * (maxY - lineY) + tableY;
        
        CGPoint point = CGPointMake(lineX , coordinatesY);

        if (t != _arrBrokenLine.count -1) {
            
            CGFloat lineYNext = [[_arrBrokenLine objectAtIndex:t + 1] floatValue] ;
            CGFloat lineXNext = GapBetweenX * (t + 1) + tableX ;
            CGFloat coordinatesYNext = tableHight/(maxY - minY) * (maxY - lineYNext) + tableY;
            CGPoint pointNext = CGPointMake(lineXNext , coordinatesYNext );
            
            [path addLineToPoint:pointNext];
            [path moveToPoint:pointNext];
            
        }
        
        [pathLayer addLineToPoint:point];
        if (t == _arrBrokenLine.count - 1) {
            [pathLayer addLineToPoint:CGPointMake(point.x, _scrollView.contentSize.height - 5)];
        }
        
        [self drawTheRoundPoint:point index:t Value:lineY];

    }
    
    shapeLayerX.path = path.CGPath ;
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    pathAnimation.delegate = self ;
    [shapeLayerX addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    shapeLayerX.strokeEnd = 1.0;

    
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path =pathLayer.CGPath;
    gradLayer.mask=arc;
    
    
//    CABasicAnimation *pathAni = [CABasicAnimation animationWithKeyPath:@"strokeEndLayer"];
//    pathAni.duration = 2;
//    pathAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pathAni.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAni.toValue = [NSNumber numberWithFloat:1.0f];
//    pathAni.autoreverses = NO;
//    pathAni.delegate = self ;
//    [gradLayer addAnimation:pathAni forKey:@"strokeEndAnimationLayer"];
//    
//    arc.strokeEnd = 1.0;

    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}


/// 圆圈和数值
-(void)drawTheRoundPoint:(CGPoint)point index:(NSInteger)index Value:(CGFloat)value
{
    
    UIColor *color = _attuneColor != nil ? _attuneColor : [UIColor colorWithRed:47/250.0 green:131/250.0 blue:228/250.0 alpha:1] ;
    
    UIImageView *viewR = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 8, 8)];
    viewR.layer.masksToBounds = YES ;
    viewR.layer.cornerRadius = viewR.frame.size.height/2 ;
    viewR.layer.borderWidth = 1 ;
    viewR.layer.borderColor = color.CGColor ;
    viewR.alpha = 0 ;
    
    viewR.center = point ;
    if (point.y == _scrollView.frame.size.height) {
        viewR.center = CGPointMake(viewR.center.x, viewR.center.y - viewR.bounds.size.height/2);
    }
    
        viewR.backgroundColor = [UIColor whiteColor];
    
        UILabel *lbValue = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        lbValue.text = [NSString stringWithFormat:@"%.2f",value];
        lbValue.textColor =  [UIColor whiteColor] ;
        [lbValue sizeToFit];
        lbValue.font = [UIFont systemFontOfSize:11];
        lbValue.textAlignment = NSTextAlignmentCenter ;
        lbValue.center = CGPointMake(point.x, viewR.center.y - viewR.bounds.size.height/2 - lbValue.bounds.size.height/2-7 );
        lbValue.backgroundColor = color ;
        lbValue.layer.cornerRadius = 3 ;
        lbValue.layer.masksToBounds = YES ;
        lbValue.hidden = YES ;
        [_scrollView addSubview:lbValue];
        
    
    SBImageView *imgAngle = [SBImageView getWithFrame:CGRectMake(0, 0, 6, 6) image:IMG_Name(@"img_triangle_blue")];
    imgAngle.center = CGPointMake(lbValue.center.x - imgAngle.bounds.size.width/2, lbValue.center.y + lbValue.bounds.size.height/2+ imgAngle.bounds.size.height/2);
    imgAngle.contentMode = UIViewContentModeScaleAspectFit ;
    imgAngle.hidden = YES ;
    [_scrollView addSubview:imgAngle];
    
    [_scrollView addSubview: viewR];
    
    
    [UIView animateWithDuration:2 animations:^{
        viewR.alpha = 1 ;
    } completion:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSNumber numberWithFloat:point.x] forKey:@"x"];
    [dic setObject:[NSNumber numberWithFloat:point.y] forKey:@"y"];
    [dic setObject:viewR forKey:@"view"];
    [dic setObject:lbValue forKey:@"label"];
    [dic setObject:imgAngle forKey:@"img"];
    [arrPoint addObject:dic];

    
}






-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _scrollLabel.contentOffset = scrollView.contentOffset ;
}




-(void)tapScrollView:(UITapGestureRecognizer *)tapView
{
    CGPoint point = [tapView locationInView:self.scrollView];
    UIColor *color = _attuneColor != nil ? _attuneColor : [UIColor colorWithRed:47/250.0 green:131/250.0 blue:228/250.0 alpha:1] ;

    [arrPoint enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSDictionary *dic = (NSDictionary *)obj ;
        
        UILabel *lb = (UILabel *)[dic objectForKey:@"label"];
        UIImageView *img = (UIImageView *)[dic objectForKey:@"view"];
        UIImageView *imgAngle = (UIImageView *)[dic objectForKey:@"img"];
        float tapX = [[dic objectForKey:@"x"] floatValue];
        float tapY = [[dic objectForKey:@"y"] floatValue];

        lb.hidden = YES ;
        imgAngle.hidden = YES ;
        
        CGRect frameI = img.frame;
        frameI.size.height = 8 ;
        frameI.size.width = 8 ;
        img.frame = frameI ;
        
        img.image = IMG_Name(@"");
        img.layer.cornerRadius = img.frame.size.height/2 ;
        img.layer.borderWidth = 1 ;
        img.layer.borderColor = color.CGColor ;
        img.backgroundColor = [UIColor whiteColor];
        
        if (point.x > tapX - GapBetweenX/2 && point.x < tapX + GapBetweenX/2) {
            
            
            lb.hidden = NO ;
            imgAngle.hidden = NO ;
            img.image = IMG_Name(@"img_point_blue");
            img.layer.borderColor = [UIColor clearColor].CGColor ;
            img.backgroundColor = [UIColor clearColor];
            
            CGRect frameImg = img.frame ;
            frameImg.size.height = 13 ;
            frameImg.size.width = 13 ;
            img.frame = frameImg ;
            
        }
        
        img.center = CGPointMake(tapX, tapY);

        
    }];
}











































/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
