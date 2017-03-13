//
//  ACTransView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/12.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACTransView.h"

@implementation ACTransView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareTwoTrans3DDemo];
    }
    return self;
}

- (void)prepareTransDemo{
    
    CALayer *layer = [CALayer layer];
    layer.frame = self.layer.bounds;
    layer.contents = (__bridge id)[UIImage imageNamed:@"bird"].CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
//    layer.affineTransform = CGAffineTransformMakeRotation(M_PI_4);
    
    CGAffineTransform trans1 = CGAffineTransformIdentity;
    trans1 = CGAffineTransformScale(trans1, 1, 2);
    CGAffineTransform trans2 = CGAffineTransformMakeRotation(M_PI_4);
    layer.affineTransform = CGAffineTransformConcat(trans1, trans2);
    
    [self.layer addSublayer:layer];
}

- (void)prepareTrans3DDemo{
    
    CALayer *layer = [CALayer layer];
    layer.frame = self.layer.bounds;
    layer.contents = (__bridge id)[UIImage imageNamed:@"bird"].CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    
    layer.borderWidth = 2.0f;
    layer.cornerRadius = 10.0f;
    
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = -1.0/500.0;
    trans = CATransform3DRotate(trans, M_PI_4, 0, 1, 0);

    layer.transform = trans;
    
    [self.layer addSublayer:layer];
    
}

- (void)prepareTwoTrans3DDemo{
    
    CGSize orgSize = self.bounds.size;
    
    CGPoint sugP = CGPointMake(1/2.0 * orgSize.width, 0);
    CGSize sugS = CGSizeMake(1/2.0 * orgSize.width, orgSize.height);
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0, 0, sugS.width, sugS.height);
    layer1.contents = (__bridge id)[UIImage imageNamed:@"bird"].CGImage;
    layer1.contentsGravity = kCAGravityResizeAspect;
    layer1.borderWidth = 2.0f;
    layer1.cornerRadius = 10.0f;
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(sugP.x, sugP.y, sugS.width, sugS.height);
    layer2.contents = (__bridge id)[UIImage imageNamed:@"bird"].CGImage;
    layer2.contentsGravity = kCAGravityResizeAspect;
    layer2.borderWidth = 2.0f;
    layer2.cornerRadius = 10.0f;
    
    [self.layer addSublayer:layer1];
    [self.layer addSublayer:layer2];
    
    //trans
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = -1.0/200.0;
    self.layer.sublayerTransform = trans;
    
    layer1.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    layer2.transform = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
}

@end
