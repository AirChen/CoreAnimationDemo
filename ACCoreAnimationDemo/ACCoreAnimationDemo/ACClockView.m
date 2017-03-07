//
//  ACClockView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/5.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACClockView.h"

@interface ACClockView()

@property (nonatomic, readwrite, strong) CALayer *secondHand;
@property (nonatomic, readwrite, strong) CALayer *minuteHand;
@property (nonatomic, readwrite, strong) CALayer *hourHand;

@end

@implementation ACClockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareClockHands];
    }
    return self;
}

- (void)prepareClockHands{
    
    self.layer.contents = (__bridge id)[UIImage imageNamed:@"clock"].CGImage;
    self.layer.contentsGravity = kCAGravityResizeAspect;
    
    _secondHand = [CALayer layer];
    _minuteHand = [CALayer layer];
    _hourHand = [CALayer layer];
    
    _secondHand.frame = CGRectMake(0, 0, 3, 30);
    _minuteHand.frame = CGRectMake(0, 0, 3, 30);
    _hourHand.frame = CGRectMake(0, 0, 3, 20);
    
    _secondHand.backgroundColor = [UIColor redColor].CGColor;
    _minuteHand.backgroundColor = [UIColor blackColor].CGColor;
    _hourHand.backgroundColor = [UIColor blackColor].CGColor;
    
    CGSize origanSize = self.bounds.size;
    
    _secondHand.position = CGPointMake(origanSize.width/2.0, origanSize.height/2.0);
    _minuteHand.position = _secondHand.position;
    _hourHand.position = _minuteHand.position;
    
    _secondHand.anchorPoint = CGPointMake(0.5, 1);
    _minuteHand.anchorPoint = CGPointMake(0.5, 1);
    _hourHand.anchorPoint = CGPointMake(0.5, 1);
    
    [self.layer addSublayer:_secondHand];
    [self.layer addSublayer:_minuteHand];
    [self.layer addSublayer:_hourHand];
    
    _secondHand.zPosition = 1.0f;//改变它的值，可以调整层级
    
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(loopClock) userInfo:nil repeats:YES];
}

- (void)loopClock{
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:now];
    
    CGFloat secAngle = components.second / 60.0 * M_PI * 2.0;
    CGFloat minAngle = components.minute / 60.0 * M_PI * 2.0;
    CGFloat hourAngle = components.hour / 12.0 * M_PI * 2.0;
    
    self.secondHand.transform = CATransform3DMakeRotation(secAngle, 0, 0, 1);
    self.minuteHand.transform = CATransform3DMakeRotation(minAngle, 0, 0, 1);
    self.hourHand.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1);
}


@end
