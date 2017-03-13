//
//  ACBoxView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/13.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACBoxView.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface ACBoxView()

@property(nonatomic, copy)NSArray *viewsDic;

@end

@implementation ACBoxView

- (NSArray *)viewsDic{
    if (!_viewsDic) {
        NSMutableArray *arr = [NSMutableArray array];
        
        void(^addView)(UIColor *) = ^(UIColor *viewColor) {
            CALayer *layer = [CALayer layer];
            layer.frame = self.bounds;
            layer.backgroundColor = viewColor.CGColor;
            
            [arr addObject:layer];
        };
        
        addView([UIColor magentaColor]);
        addView([UIColor whiteColor]);
        addView([UIColor grayColor]);
        addView([UIColor blueColor]);
        addView([UIColor purpleColor]);
        addView([UIColor yellowColor]);
        
        _viewsDic = arr;
    }
    return _viewsDic;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareBoxViewDemo];
    }
    return self;
}

- (void)prepareBoxViewDemo{

    CATransform3D parentTrans = CATransform3DIdentity;
    parentTrans.m34 = -1.0/500.0;
    parentTrans = CATransform3DRotate(parentTrans, -M_PI_4, 1, 0, 0);
    parentTrans = CATransform3DRotate(parentTrans, -M_PI_4, 0, 1, 0);
    self.layer.sublayerTransform = parentTrans;
    
    CGFloat translationLength = self.bounds.size.width/2.0;
    
    CATransform3D trans1 = CATransform3DMakeTranslation(0, 0, translationLength);
    [self addFaceWithIndex:0 andTransform:trans1];
    
    CATransform3D trans2 = CATransform3DMakeTranslation(translationLength, 0, 0);
    trans2 = CATransform3DRotate(trans2, M_PI_2, 0, 1, 0);
    [self addFaceWithIndex:1 andTransform:trans2];
    
    CATransform3D trans3 = CATransform3DMakeTranslation(-translationLength, 0, 0);
    trans3 = CATransform3DRotate(trans3, -M_PI_2, 0, 1, 0);
    [self addFaceWithIndex:2 andTransform:trans3];
    
    CATransform3D trans4 = CATransform3DMakeTranslation(0, translationLength, 0);
    trans4 = CATransform3DRotate(trans4, M_PI_2, 1, 0, 0);
    [self addFaceWithIndex:3 andTransform:trans4];
    
    CATransform3D trans5 = CATransform3DMakeTranslation(0, -translationLength, 0);
    trans5 = CATransform3DRotate(trans5, -M_PI_2, 1, 0, 0);
    [self addFaceWithIndex:4 andTransform:trans5];
    
    CATransform3D trans6 = CATransform3DMakeTranslation(0, 0, -translationLength);
    trans6 = CATransform3DRotate(trans6, M_PI, 0, 1, 0);
    [self addFaceWithIndex:5 andTransform:trans6];
}

- (void)addFaceWithIndex:(NSUInteger)index andTransform:(CATransform3D)trans{
    CALayer *layer = self.viewsDic[index];
    layer.transform = trans;
    [self.layer addSublayer:layer];

//    [self applyLightingToFace:view.layer];
}

- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    NSLog(@"%f",shadow);
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

@end
