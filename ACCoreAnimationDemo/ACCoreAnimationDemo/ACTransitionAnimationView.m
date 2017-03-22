//
//  ACTransitionAnimationView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/22.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACTransitionAnimationView.h"

@interface ACTransitionAnimationView()

@property(nonatomic,copy) NSArray *array;
@property (nonatomic, readwrite, assign) NSUInteger index;
@property (nonatomic, readwrite, strong) CALayer *changeLayer;

@end

@implementation ACTransitionAnimationView

-(NSArray *)array{
    if (!_array) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSUInteger i = 0; i < 6; i++) {
            [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"bird%lu",(unsigned long)i]]];
        }
        _array =arr;
    }
    return _array;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareTransitionDemo2];
    }
    return self;
}

- (void)prepareTransitionDemo{

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction)];
    [self addGestureRecognizer:gesture];
    
    self.index = 0;
    self.layer.contents = (__bridge id)[UIImage imageNamed:@"bird0"].CGImage;
    self.layer.contentsGravity = kCAGravityResizeAspect;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
}

- (void)touchAction{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.layer addAnimation:transition forKey:nil];
    
    /*
    CATransition *tran = [CATransition animation];
    tran.type = @"cube";
    tran.subtype = @"kCATransitionFromRight";
    tran.duration = 1;
    tran.startProgress = 0.2;
    tran.endProgress = 0.8;
    */
    
    if (self.index == 5) {
        self.index = -1;
    }
    self.index++;
    UIImage *img = self.array[self.index];
    self.layer.contents = (__bridge id)img.CGImage;
}

//影响子视图 -》可以对现有空间进行修改
- (void)prepareTransitionDemo2{
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction2)];
    [self addGestureRecognizer:gesture];
    
    self.index = 0;
    
    _changeLayer = [CALayer layer];
    _changeLayer.frame = self.bounds;
    _changeLayer.contents = (__bridge id)[UIImage imageNamed:@"bird0"].CGImage;
    _changeLayer.contentsGravity = kCAGravityResizeAspect;
    _changeLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:_changeLayer];
}

- (void)touchAction2{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.layer addAnimation:transition forKey:nil];
    
    if (self.index == 5) {
        self.index = -1;
    }
    self.index++;
    UIImage *img = self.array[self.index];
    _changeLayer.contents = (__bridge id)img.CGImage;
}

@end
