//
//  ACProfessionalView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/13.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACProfessionalView.h"
#import "ACTools.h"
#import <CoreText/CoreText.h>

@implementation ACProfessionalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareReflactDemo];
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

//box cube
- (void)prepareTransformLayerDemo{

    CATransform3D ct = CATransform3DIdentity;
    ct = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    ct = CATransform3DRotate(ct, M_PI_4, 1, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_4, 0, 0, 1);
    
    [self.layer addSublayer:[self cubeWithTransform:ct]];
    
    ct = CATransform3DTranslate(ct, 0, 300, 0);
    ct = CATransform3DScale(ct, 0.5, 0.8, 0.1);
    
    [self.layer addSublayer:[self cubeWithTransform:ct]];
}

- (void)prepareReplicatorLayerDemo{
    
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.frame = self.bounds;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 200, 0, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, -200, 0, 0);
    layer.instanceTransform = transform;
    layer.instanceCount = 3;
    
    CATransform3D ct = CATransform3DIdentity;
    ct = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    ct = CATransform3DRotate(ct, M_PI_4, 1, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_4, 0, 0, 1);
    
    [layer addSublayer:[self cubeWithTransform:ct]];
    [self.layer addSublayer:layer];
}

- (void)prepareReflactDemo{

    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.frame = self.bounds;
    
    CATransform3D ct = CATransform3DIdentity;
    CGFloat verticalOffset = self.bounds.size.height - 2.0;
    ct = CATransform3DTranslate(ct, 0, verticalOffset, 0);
    ct = CATransform3DScale(ct, 1, -1, 0);
    layer.instanceTransform = ct;
    layer.instanceCount = 2;
    layer.instanceAlphaOffset = -0.6;
    
    CATransform3D ct1 = CATransform3DIdentity;
    ct1 = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    ct1 = CATransform3DRotate(ct1, M_PI_4, 1, 0, 0);
    ct1 = CATransform3DRotate(ct1, M_PI_4, 0, 0, 1);
    [layer addSublayer:[self cubeWithTransform:ct1]];
    [self.layer addSublayer:layer];
    
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform{
    
    CGFloat translationLength = self.bounds.size.width/2.0;
    
    CATransformLayer *cube = [CATransformLayer layer];
    
    CATransform3D ct = CATransform3DIdentity;
    ct = CATransform3DMakeTranslation(0, 0, translationLength);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, translationLength, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, -translationLength, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(translationLength, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(-translationLength, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, 0, -translationLength);
    ct = CATransform3DRotate(ct, M_PI, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    cube.frame = self.bounds;
    cube.transform = transform;
    
    return cube;
    
}

- (CALayer *)faceWithTransform:(CATransform3D)transform{

    CALayer *layer = [CALayer layer];
    
    layer.frame = self.bounds;
//    layer.backgroundColor = [self randomColor].CGColor;
    [layer addSublayer:[self gradientLayer]];
    layer.transform = transform;
    
    return layer;
    
}

//渐变
- (CALayer *)gradientLayer{
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    
    layer.colors = [NSArray arrayWithObjects:(__bridge id)[[ACTools shareTools] randomColor].CGColor,(__bridge id)[[ACTools shareTools] randomColor].CGColor,(__bridge id)[[ACTools shareTools] randomColor].CGColor, nil];
    layer.locations = @[@0.0,@0.25,@0.5];
    
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    
    return layer;
    
}

@end
