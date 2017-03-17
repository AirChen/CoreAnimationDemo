//
//  ACProfessionalLayerView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/17.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACProfessionalLayerView.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@implementation ACProfessionalLayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareAVPlayerLayerDemo];
    }
    return self;
}

- (void)prepareEmitterlayerDemo{
    
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    
    layer.renderMode = kCAEmitterLayerAdditive;
    layer.emitterPosition = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"bird"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor whiteColor].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50.0;
    cell.velocityRange = 50.0;
    cell.emissionRange = M_PI * 2.0;
    
    layer.emitterCells = @[cell];
    
}

- (void)prepareAVPlayerLayerDemo{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"movie" withExtension:@"mp4"];
    
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = self.bounds;
    [self.layer addSublayer:playerLayer];
    
    [player play];
    
    playerLayer.borderColor = [UIColor whiteColor].CGColor;
    playerLayer.borderWidth = 2.0f;
    playerLayer.cornerRadius = 5.0f;
    playerLayer.doubleSided = NO;
    playerLayer.masksToBounds = YES;
    
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = -1/500.0;
    trans = CATransform3DRotate(trans, M_PI_4, 1, 1, 0);
    playerLayer.transform = trans;
    
}

@end
