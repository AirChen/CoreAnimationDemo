//
//  ACTools.h
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/17.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;

@interface ACTools : NSObject

+ (instancetype)shareTools;

- (UIColor *)randomColor;

@end
