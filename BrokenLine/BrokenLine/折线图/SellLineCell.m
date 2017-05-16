//
//  SellLineCell.m
//  WQX_2.5
//
//  Created by 君未央 on 2017/5/1.
//  Copyright © 2017年 wuquxing. All rights reserved.
//

#import "SellLineCell.h"
#import "lineChartView.h"

#import "Header.h"

@implementation SellLineCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self allocUI];
    }
    
    return self ;
}

-(void)allocUI
{
    _lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 20)];
    _lbTitle.text = @"4月保费(元)";
    _lbTitle.textColor = UIColorFromRGB(0x999999) ;
    _lbTitle.textAlignment = NSTextAlignmentCenter ;
    _lbTitle.font = [UIFont systemFontOfSize:15];
    
    //[SBLabel getWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 20) text:@"4月保费(元)" textColor:UIColorFromRGB(0x999999) textFont:Font_Title15 textAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_lbTitle];
    
    float proportion = 0.76;
    
    lineChartView *lineChart  = [[lineChartView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, proportion*(SCREEN_WIDTH - 40))];
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart buildUI];
    [self.contentView addSubview:lineChart];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
