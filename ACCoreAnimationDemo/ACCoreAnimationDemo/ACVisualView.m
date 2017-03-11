//
//  ACVisualView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/9.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACVisualView.h"

@interface ACVisualView()

@end

@implementation ACVisualView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareShadowPath];
    }
    return self;
}

- (void)prepareDemo{
    
    self.backgroundColor = [UIColor redColor];
    
    CGSize oriSize = self.bounds.size;
    
    CGPoint suggestOrigan = CGPointMake(1/3.0*oriSize.width, 1/3.0*oriSize.height);
    CGSize suggestSize = CGSizeMake(2/3.0*oriSize.width, 2/3.0*oriSize.height);
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(suggestOrigan.x, suggestOrigan.y, suggestSize.width, suggestSize.height)];
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, suggestSize.width, suggestSize.height)];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    blueView.backgroundColor = [UIColor blueColor];
    
    [self addSubview:whiteView];
    [self addSubview:blueView];
    
    //corner
    whiteView.layer.contents = (__bridge id)[UIImage imageNamed:@"Unknown"].CGImage;
    whiteView.layer.contentsGravity = kCAGravityResizeAspect;
    whiteView.layer.cornerRadius = 5.0f;
    whiteView.layer.masksToBounds = YES;
    
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
    
    //border
    whiteView.layer.borderColor = [UIColor blackColor].CGColor;
    whiteView.layer.borderWidth = 2.0f;
    
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 5.0f;//发现外层加边之后，内部视图的圆角效果没有了!!!
    
    //shadow
    self.layer.shadowOpacity = 0.5f;//这里是没有阴影效果的
    self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layer.shadowRadius = 5.0f;
}

//添加一个视图层专门负责阴影效果，相邻内部的一层用masksToBounds，就不会隔离阴影了
- (void)prepareShadowDemo{
    
    CGSize oriSize = self.bounds.size;
    
    CGPoint suggestOrigan = CGPointMake(1/3.0*oriSize.width, 1/3.0*oriSize.height);
    CGSize suggestSize = CGSizeMake(2/3.0*oriSize.width, 2/3.0*oriSize.height);
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(suggestOrigan.x, suggestOrigan.y, suggestSize.width, suggestSize.height)];
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, suggestSize.width, suggestSize.height)];
    UIView *containerView = [[UIView alloc] initWithFrame:self.bounds];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    blueView.backgroundColor = [UIColor blueColor];
    containerView.backgroundColor = [UIColor redColor];
    
    [containerView addSubview:whiteView];
    [containerView addSubview:blueView];
    [self addSubview:containerView];
    
    //corner
    whiteView.layer.contents = (__bridge id)[UIImage imageNamed:@"Unknown"].CGImage;
    whiteView.layer.contentsGravity = kCAGravityResizeAspect;
    whiteView.layer.cornerRadius = 5.0f;
    whiteView.layer.masksToBounds = YES;
    
    containerView.layer.cornerRadius = 10.0f;
    containerView.layer.masksToBounds = YES;
    
    //border
    whiteView.layer.borderColor = [UIColor blackColor].CGColor;
    whiteView.layer.borderWidth = 2.0f;
    
    containerView.layer.borderColor = [UIColor blackColor].CGColor;
    containerView.layer.borderWidth = 5.0f;//发现外层加边之后，内部视图的圆角效果没有了!!!
    
    //shadow
    self.layer.shadowOpacity = 0.5f;//这里是没有阴影效果的
    self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layer.shadowRadius = 5.0f;
}

- (void)prepareShadowPath{

    self.layer.contents = (__bridge id)[UIImage imageNamed:@"dog"].CGImage;
    self.layer.contentsGravity = kCAGravityResizeAspect;
    self.layer.shadowOpacity = 0.5f;
    
//    CGMutablePathRef squrePath = CGPathCreateMutable();
//    CGPathAddRect(squrePath, NULL, self.bounds);
//    self.layer.shadowPath = squrePath;
//    CGPathRelease(squrePath);
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, self.bounds);
    self.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
    
}

@end
