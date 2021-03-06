//
//  ACAnimationView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/22.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACAnimationView.h"
#import "ACTools.h"

@interface ACAnimationView()<CAAnimationDelegate>

@property (nonatomic, readwrite, strong) CALayer *animateLayer;

@end

@implementation ACAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareAnimateDemo];
    }
    return self;
}

- (void)prepareAnimateDemo{
    
    _animateLayer = [CALayer layer];
    _animateLayer.frame = self.bounds;
    [self.layer addSublayer:_animateLayer];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction2)];
    [self addGestureRecognizer:gesture];
    
    [self setAnimateBackColor:[[ACTools shareTools] randomColor].CGColor];
}

- (void)touchAction{
    CABasicAnimation *animate = [CABasicAnimation animation];
    animate.duration = 2.0;
    animate.keyPath = @"backgroundColor";
    animate.toValue = (__bridge id)[[ACTools shareTools] randomColor].CGColor;
    animate.delegate = self;//代理！！！
    [_animateLayer addAnimation:animate forKey:nil];
}

- (void)touchAction2{
    CAKeyframeAnimation *animate = [CAKeyframeAnimation animation];
    animate.keyPath = @"backgroundColor";
//    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animate.timingFunctions = @[fn,fn,fn,fn];
    animate.values = @[
                       (__bridge id)[[ACTools shareTools] randomColor].CGColor,
                       (__bridge id)[[ACTools shareTools] randomColor].CGColor,
                       (__bridge id)[[ACTools shareTools] randomColor].CGColor,
                       (__bridge id)[[ACTools shareTools] randomColor].CGColor,
                       (__bridge id)[[ACTools shareTools] randomColor].CGColor
                       ];
    animate.duration = 3.0;
    [_animateLayer addAnimation:animate forKey:nil];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self setAnimateBackColor:(__bridge CGColorRef)anim.toValue];
    }
}

- (void)setAnimateBackColor:(CGColorRef)color{
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    _animateLayer.backgroundColor = color;
    
    [CATransaction commit];
}

- (void)prepareAnimateDemo2{
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(-100, 150)];
    [bezierPath addCurveToPoint:CGPointMake(200, 150) controlPoint1:CGPointMake(-25, 0) controlPoint2:CGPointMake(125, 300)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 2.0;
    [self.layer addSublayer:pathLayer];
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(0, 0, 64, 64);
    textLayer.anchorPoint = CGPointMake(0.5, 0.5);
    textLayer.position = CGPointMake(-100, 150);
    textLayer.string = @"I can fly!";
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    UIFont *font = [UIFont systemFontOfSize:15.0];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
//    CALayer *layer = [CALayer layer];
//    layer.frame = CGRectMake(0, 0, 64, 64);
//    layer.position = CGPointMake(-100, 150);
//    layer.contents = (__bridge id)[UIImage imageNamed:@"bird"].CGImage;
//    layer.contentsGravity = kCAGravityResizeAspect;
//    [self.layer addSublayer:layer];
    
    CAKeyframeAnimation *animate = [CAKeyframeAnimation animation];
    animate.keyPath = @"position";
    animate.path = bezierPath.CGPath;
    animate.duration = 10.0;
    animate.rotationMode = kCAAnimationRotateAuto;
    [textLayer addAnimation:animate forKey:nil];
    
    CALayer *colorLayer = [CALayer layer];
    colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(-100, 150);
    [self.layer addSublayer:colorLayer];
    [self.layer addSublayer:textLayer];
    
    CABasicAnimation *animate2 = [CABasicAnimation animation];
    animate2.keyPath = @"backgroundColor";
    animate2.toValue = (__bridge id)[UIColor redColor].CGColor;
//    animate2.duration = 10.0;
    
    CAAnimationGroup *animates = [CAAnimationGroup animation];
    animates.animations = @[animate,animate2];
    //CAMediaTiming************ 时间属性
    animates.duration = 10.0;
//    animates.repeatCount = 3;
    animates.repeatDuration = INFINITY;
    animates.autoreverses = YES;
    animates.beginTime = 3.0;
    animates.timeOffset = 1.0;
    animates.speed = 2.0;
    
    //缓冲函数
    animates.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [colorLayer addAnimation:animates forKey:nil];
}

@end
