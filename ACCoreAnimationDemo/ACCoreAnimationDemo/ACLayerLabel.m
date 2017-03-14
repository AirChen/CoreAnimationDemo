//
//  ACLayerLabel.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/14.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACLayerLabel.h"

@implementation ACLayerLabel

+ (Class)layerClass{
    return [CATextLayer class];
}

- (CATextLayer *)textLayer{
    return (CATextLayer *)self.layer;
}

- (void)setupUI{
    self.font = self.font;
    self.text = self.text;
    self.textColor = self.textColor;
    
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    [self textLayer].wrapped = YES;
    [self textLayer].contentsScale = [UIScreen mainScreen].scale;
    
    [self.layer display];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setText:(NSString *)text{
    super.text = text;
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor{
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font{
    super.font = font;
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    
    CGFontRelease(fontRef);
}

@end
