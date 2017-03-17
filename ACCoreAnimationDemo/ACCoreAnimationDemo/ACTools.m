//
//  ACTools.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/17.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACTools.h"
#import <UIKit/UIKit.h>

@implementation ACTools

static ACTools *instance;

+ (instancetype)shareTools{

    if (instance == nil) {
        instance = [[ACTools alloc] init];
    }
    return instance;
}

- (UIColor *)randomColor{
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
