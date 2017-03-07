//
//  ACCAViewController.m
//  ACCoreAnimationDemo
//
//  Created by AirChen on 2017/3/2.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACCAViewController.h"
#import "ACCAView.h"
#import "ACClockView.h"
#import "ACCATouchView.h"

@interface ACCAViewController ()<CALayerDelegate>

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
    
    CGRect viewRect = CGRectMake(subViewX, subViewY, subViewWidth, subViewHeight);
    
    [self touchViewLayerInRect:viewRect];
}

//calayer的基本属性
- (void)basicMethodInRect:(CGRect)rect{
    ACCAView *demoView = [[ACCAView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//代理方法的使用
- (void)drawDelegateMethodInRect:(CGRect)rect{
    
    CALayer *layer = [CALayer layer];
    layer.frame = rect;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.delegate = self;
    
    [self.view.layer addSublayer:layer];
    
    [layer display];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
    
}

//时钟
- (void)clockViewLayerInRect:(CGRect)rect{
    ACClockView *clockView = [[ACClockView alloc] initWithFrame:rect];
    [self.view addSubview:clockView];
}

//触摸
- (void)touchViewLayerInRect:(CGRect)rect{
    ACCATouchView *demoView = [[ACCATouchView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
