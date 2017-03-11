//
//  ACStrenthView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/11.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACStrenthView.h"

@interface ACStrenthView()

@property (nonatomic, readwrite, assign) NSInteger scaleStrength;

@end

@implementation ACStrenthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareStrenthDemo];
    }
    return self;
}

- (void)prepareStrenthDemo{
    
    self.layer.contents = (__bridge id)[UIImage imageNamed:@"simple"].CGImage;
    self.layer.contentsGravity = kCAGravityResizeAspect;
    self.scaleStrength = 1;
    
    self.layer.magnificationFilter = kCAFilterNearest;
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scheduleAction) userInfo:nil repeats:YES];
}

- (void)scheduleAction{
    
    NSInteger strengthScale = self.scaleStrength;
    self.layer.contentsRect = CGRectMake(0.1*strengthScale, 0.1*strengthScale, 0.9*strengthScale, 0.9*strengthScale);
    
    self.scaleStrength++;
}

@end
