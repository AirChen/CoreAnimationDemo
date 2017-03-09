//
//  ACVisualView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/9.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACVisualView.h"

@interface ACVisualView()

@property (nonatomic, readwrite, strong) UIView *whiteView;
@property (nonatomic, readwrite, strong) UIView *blueView;

@end

@implementation ACVisualView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareDemo];
    }
    return self;
}

- (void)prepareDemo{
    
    self.backgroundColor = [UIColor redColor];
    
    CGSize oriSize = self.bounds.size;
    
    CGPoint suggestOrigan = CGPointMake(1/3.0*oriSize.width, 1/3.0*oriSize.height);
    CGSize suggestSize = CGSizeMake(2/3.0*oriSize.width, 2/3.0*oriSize.height);
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(suggestOrigan.x, suggestOrigan.y, suggestSize.width, suggestSize.height)];
    _blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, suggestSize.width, suggestSize.height)];
    
    _whiteView.backgroundColor = [UIColor whiteColor];
    _blueView.backgroundColor = [UIColor blueColor];
    
    [self addSubview:_whiteView];
    [self addSubview:_blueView];
    
    //corner
    _whiteView.layer.contents = (__bridge id)[UIImage imageNamed:@"Unknown"].CGImage;
    _whiteView.layer.contentsGravity = kCAGravityResizeAspect;
    _whiteView.layer.cornerRadius = 5.0f;
    _whiteView.layer.masksToBounds = YES;
    
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
    
    //border
    _whiteView.layer.borderColor = [UIColor blackColor].CGColor;
    _whiteView.layer.borderWidth = 2.0f;
    
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 5.0f;
    
}

@end
