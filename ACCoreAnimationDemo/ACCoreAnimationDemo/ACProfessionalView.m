//
//  ACProfessionalView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/13.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACProfessionalView.h"
#import <CoreText/CoreText.h>

@implementation ACProfessionalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareTextLayerDemo2];
    }
    return self;
}

- (void)prepareShapeLayerDemo{
    
    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //corners
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner coner = UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight;
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:coner cornerRadii:radii];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = cornerPath.CGPath;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)prepareTextLayerDemo{

    CATextLayer *layer = [CATextLayer layer];
    layer.frame = self.layer.bounds;
    [self.layer addSublayer:layer];
    
    layer.foregroundColor = [UIColor blackColor].CGColor;
    layer.alignmentMode = kCAAlignmentJustified;
    layer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15.0];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    layer.font = fontRef;
    layer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    
    layer.string = text;
    layer.contentsScale = [UIScreen mainScreen].scale;
}

- (void)prepareTextLayerDemo2{
    
    CATextLayer *layer = [CATextLayer layer];
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    
    layer.alignmentMode = kCAAlignmentJustified;
    layer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15.0];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName,fontSize,NULL);
    
    NSString *text = @"Lorem ipsum dolor sit amet";
    
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    [textString setAttributes:attribs range:NSMakeRange(0, [textString length])];
    
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    
    [textString setAttributes:attribs range:NSMakeRange(0, 6)];
    
    CFRelease(fontRef);
    
    layer.string = textString;
}

@end
