//
//  ACTransactionView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/17.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACTransactionView.h"
#import "ACTools.h"

@interface ACTransactionView()

@property (nonatomic, readwrite, strong) CALayer *colorLayer;//需添加子层，才能发动事物的作用。

@end

@implementation ACTransactionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self preparePresentLayerDemo];
    }
    return self;
}

- (void)prepareTransactionDemo{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:gesture];
    
    _colorLayer = [CALayer layer];
    _colorLayer.frame = self.bounds;
    [self.layer addSublayer:_colorLayer];
    
    self.colorLayer.backgroundColor = [[ACTools shareTools] randomColor].CGColor;
}

- (void)tapAction{
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setCompletionBlock:^{
       
        self.colorLayer.transform = CATransform3DRotate(self.colorLayer.transform, M_PI_4, 0, 0, 1);
        
    }];
    
    self.colorLayer.backgroundColor = [[ACTools shareTools] randomColor].CGColor;

    [CATransaction commit];
}

- (void)prepareTransactionDemo2{

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushColor)];
    [self addGestureRecognizer:gesture];
    
    _colorLayer = [CALayer layer];
    _colorLayer.frame = self.bounds;
    [self.layer addSublayer:_colorLayer];
    
    //过渡行为
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor":transition};
    
    self.colorLayer.backgroundColor = [[ACTools shareTools] randomColor].CGColor;
}

- (void)pushColor{
    self.colorLayer.backgroundColor = [[ACTools shareTools] randomColor].CGColor;
}

- (void)preparePresentLayerDemo{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hitAction:)];
    [self addGestureRecognizer:gesture];
    
    _colorLayer = [CALayer layer];
    _colorLayer.frame = self.bounds;
    [self.layer addSublayer:_colorLayer];
}

- (void)hitAction:(UIGestureRecognizer *)gesture{
    CGPoint locP = [gesture locationInView:self];
    
    if ([self.colorLayer.presentationLayer hitTest:locP]) {
        
        self.colorLayer.backgroundColor = [[ACTools shareTools] randomColor].CGColor;
        
    }else{
    
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        
        self.colorLayer.position = locP;
        
        [CATransaction commit];
        
    }
}

@end
