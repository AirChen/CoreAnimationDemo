//
//  ACDrawView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/25.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACDrawView.h"

@interface ACDrawView()

@property(nonatomic, strong)UIBezierPath *path;

@end

@implementation ACDrawView

+ (Class)layerClass{
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareDrawDemo];
    }
    return self;
}

- (void)prepareDrawDemo{
    
    self.path = [UIBezierPath bezierPath];
    
    CAShapeLayer *layer = (CAShapeLayer *)self.layer;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.lineJoin = kCALineJoinRound;
    layer.lineCap = kCALineCapRound;
    layer.lineWidth = 5;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint p = [[touches anyObject] locationInView:self];
    
    [self.path moveToPoint:p];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint p = [[touches anyObject] locationInView:self];
    
    [self.path addLineToPoint:p];
    
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
    
}

@end
