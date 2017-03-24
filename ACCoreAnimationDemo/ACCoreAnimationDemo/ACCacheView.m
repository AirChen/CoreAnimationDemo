//
//  ACCacheView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/24.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACCacheView.h"

@implementation ACCacheView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareCacheDemo];
    }
    return self;
}

- (void)prepareCacheDemo{
    self.backgroundColor = [UIColor whiteColor];

//    CAMediaTimingFunction *func = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAMediaTimingFunction *func = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
    
    float p1[2];
    float p2[2];
    [func getControlPointAtIndex:1 values:(float *)&p1];
    [func getControlPointAtIndex:2 values:(float *)&p2];
    
    CGPoint point1 = CGPointMake(p1[0], p1[1]);
    CGPoint point2 = CGPointMake(p2[0], p2[1]);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1) controlPoint1:point1 controlPoint2:point2];
    [path applyTransform:CGAffineTransformMakeScale(self.bounds.size.width, self.bounds.size.height)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = 2.0;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:layer];
    self.layer.geometryFlipped = YES;
}

@end
