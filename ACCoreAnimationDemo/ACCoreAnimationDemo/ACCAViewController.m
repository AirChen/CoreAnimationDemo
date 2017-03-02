//
//  ACCAViewController.m
//  ACCoreAnimationDemo
//
//  Created by AirChen on 2017/3/2.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACCAViewController.h"
#import "ACCAView.h"

@interface ACCAViewController ()

@end

@implementation ACCAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    CGFloat subViewWidth = 100.0;
    CGFloat subViewHeight = 100.0;
    
    CGFloat subViewX = self.view.center.x - subViewWidth / 2.0;
    CGFloat subViewY = self.view.center.y - subViewHeight / 2.0;
    
    ACCAView *demoView = [[ACCAView alloc] initWithFrame:CGRectMake(subViewX, subViewY, subViewWidth, subViewHeight)];
    
    [self.view addSubview:demoView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
