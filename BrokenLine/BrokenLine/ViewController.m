//
//  ViewController.m
//  BrokenLine
//
//  Created by 君未央 on 2017/5/16.
//  Copyright © 2017年 ZDQ. All rights reserved.
//

#import "ViewController.h"
#import "lineChartView.h"
#import "Header.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    float proportion = 0.76;
    
    lineChartView *lineChart  = [[lineChartView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, proportion*(SCREEN_WIDTH - 40))];
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart buildUI];
    [self.view addSubview:lineChart];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
