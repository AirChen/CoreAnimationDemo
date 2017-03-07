//
//  ACCATouchView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/7.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACCATouchView.h"

@interface ACCATouchView()

@property (nonatomic, readwrite, strong) CALayer *subLayer;

@end

@implementation ACCATouchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareInital];
    }
    return self;
}

- (void)prepareInital{
    
    if (!_subLayer) {
        _subLayer = [CALayer layer];
    }
    _subLayer.frame = CGRectMake(0, 0, 50, 50);
    _subLayer.position = [_subLayer convertPoint:self.layer.position toLayer:self.layer];
    _subLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_subLayer];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchActionZero:)];
    [self addGestureRecognizer:gesture];
}

- (void)touchAction:(UIGestureRecognizer *)gesture{

    CGPoint touchP = [gesture locationInView:self];
    
    if ([self.layer containsPoint:touchP]) {
        touchP = [_subLayer convertPoint:touchP fromLayer:self.layer];
        if ([_subLayer containsPoint:touchP]) {
            NSLog(@"sublayer touch!!");
        }else{
            NSLog(@"self.layer touch!!");
        }
    }
    
}

- (void)touchActionZero:(UIGestureRecognizer *)gesture{
    
    CGPoint touchP = [gesture locationInView:self.superview];
    
    CALayer *layer = [self.layer hitTest:touchP];
    if ([layer isEqual:self.layer]) {
        NSLog(@"self.layer touch!!");
    }else if ([layer isEqual:_subLayer])
        NSLog(@"subLayer touch!!");
    
}

@end
