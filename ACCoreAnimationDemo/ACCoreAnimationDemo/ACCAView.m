//
//  ACCAView.m
//  ACCoreAnimationDemo
//
//  Created by AirChen on 2017/3/2.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACCAView.h"

@implementation ACCAView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self coreAnimationDemo2];
    }
    return self;
}

- (void)coreAnimationDemo{
    UIImage *image = [UIImage imageNamed:@"Unknown"];
    
    self.layer.contents = (__bridge id)image.CGImage;
//    self.layer.contentsGravity = kCAGravityResizeAspect;
    
    //图片颗粒感修复，大小
    self.layer.contentsGravity = kCAGravityCenter;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    
    //裁边
    self.layer.masksToBounds = YES;
    
}

- (void)coreAnimationDemo1{
    //裁图
    UIImage *image = [UIImage imageNamed:@"Unknown"];
    
    self.layer.contents = (__bridge id)image.CGImage;
    
    self.layer.contentsGravity = kCAGravityResizeAspect;
    self.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
}

- (void)coreAnimationDemo2{
    //拉伸
    UIImage *image = [UIImage imageNamed:@"Unknown"];
    
    self.layer.contents = (__bridge id)image.CGImage;
    self.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
}

- (void)drawRect:(CGRect)rect {
    
}


@end
