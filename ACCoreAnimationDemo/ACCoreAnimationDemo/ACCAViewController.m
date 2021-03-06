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
#import "ACVisualView.h"
#import "ACStrenthView.h"
#import "ACTransView.h"
#import "ACBoxView.h"
#import "ACProfessionalView.h"
#import "ACProfessionalLayerView.h"
#import "ACTransactionView.h"
#import "ACAnimationView.h"
#import "ACTransitionAnimationView.h"
#import "ACCacheView.h"
#import "ACDrawView.h"
#import "ACBrushView.h"

#import "ACNumLayersView.h"

#import "ACLayerLabel.h"

@interface ACCAViewController ()<CALayerDelegate>

@end

@implementation ACCAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    CGFloat subViewWidth = 300.0;
    CGFloat subViewHeight = 300.0;
    
    CGFloat subViewX = self.view.center.x - subViewWidth / 2.0;
    CGFloat subViewY = self.view.center.y - subViewHeight / 2.0;
    
    CGRect viewRect = CGRectMake(subViewX, subViewY, subViewWidth, subViewHeight);

    [self numLayersViewInRect:viewRect];
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

//视觉效果1
- (void)visualViewLayerInRect:(CGRect)rect{
    ACVisualView *demoView = [[ACVisualView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//视觉效果2 strenth
- (void)strenthViewLayerInRect:(CGRect)rect{
    ACStrenthView *demoView = [[ACStrenthView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//变换
- (void)transViewLayerInRect:(CGRect)rect{
    ACTransView *demoView = [[ACTransView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//变换2 box
- (void)boxViewLayerInRect:(CGRect)rect{
    ACBoxView *demoView = [[ACBoxView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//专用图层
- (void)professionalLayerInRect:(CGRect)rect{
    ACProfessionalView *demoView = [[ACProfessionalView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//专用图层2
- (void)professionalLayer2InRect:(CGRect)rect{
    ACProfessionalLayerView *demoView = [[ACProfessionalLayerView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//事务
- (void)transactionViewInRect:(CGRect)rect{
    ACTransactionView *demoView = [[ACTransactionView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//显示动画
- (void)animateViewInRect:(CGRect)rect{
    ACAnimationView *demoView = [[ACAnimationView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//显示动画
- (void)transitionAnimateViewInRect:(CGRect)rect{
    ACTransitionAnimationView *demoView = [[ACTransitionAnimationView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//动画缓冲
- (void)animateCacheViewInRect:(CGRect)rect{
    ACCacheView *demoView = [[ACCacheView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//矢量做图
- (void)drawViewInRect:(CGRect)rect{
    ACDrawView *demoView = [[ACDrawView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//刷子
- (void)brushViewInRect:(CGRect)rect{
    ACBrushView *demoView = [[ACBrushView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

//多图层
- (void)numLayersViewInRect:(CGRect)rect{
    ACNumLayersView *demoView = [[ACNumLayersView alloc] initWithFrame:rect];
    [self.view addSubview:demoView];
}

- (void)layerLabelInRect:(CGRect)rect{
    ACLayerLabel *lab = [[ACLayerLabel alloc] initWithFrame:rect];
    
    lab.textColor = [UIColor blueColor];
    lab.text = @"Hello!";
    lab.font = [UIFont systemFontOfSize:15.0];
    
    [self.view addSubview:lab];
}

@end
