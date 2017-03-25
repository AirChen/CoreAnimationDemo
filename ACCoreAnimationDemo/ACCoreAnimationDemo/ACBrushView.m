//
//  ACBrushView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/25.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACBrushView.h"

#define BRUSH_SIZE 10
@interface ACBrushView()

@property(nonatomic, strong)NSMutableArray *stroks;

@end

@implementation ACBrushView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareCGDrawDemo];
    }
    return self;
}

- (void)prepareCGDrawDemo{
    
    self.stroks = [NSMutableArray array];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self addBrushPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self addBrushPoint:point];
}

- (void)addBrushPoint:(CGPoint) point{
    
    [self.stroks addObject:[NSValue valueWithCGPoint:point]];
    
    //局部刷新
    [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
    
}

- (CGRect)brushRectForPoint:(CGPoint)point
{
    return CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
}

- (void)drawRect:(CGRect)rect{
    
    for (NSValue *value in self.stroks) {
        CGPoint point = value.CGPointValue;
        CGRect brushRect = [self brushRectForPoint:point];
        
        if (CGRectIntersectsRect(rect, brushRect)) {
            [[UIImage imageNamed:@"bird0"] drawInRect:brushRect];
        }
        
    }
    
}

@end
