//
//  ACMunImagesView.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/4/3.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACNumLayersView.h"

#define WIDTH 100
#define HEIGHT 100
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500
#define PERSPECTIVE(z) (float)CAMERA_DISTANCE/(z + CAMERA_DISTANCE)

@interface ACNumLayersView()<UIScrollViewDelegate>

@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableSet *recyclePool;

@end

@implementation ACNumLayersView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareNumsLayersMethod];
    }
    return self;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)prepareNumImageDemo{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    
    //set content size
    scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING, (HEIGHT - 1)*SPACING);
    
    //set up perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    scrollView.layer.sublayerTransform = transform;
    
    //create layers
    for (int z = DEPTH - 1; z >= 0; z--) {
        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) {
                //create layer
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING;
                //set background color
                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
                //attach to scroll view
                [scrollView.layer addSublayer:layer];
            }
        }
    }
    
    //log
    NSLog(@"displayed: %i", DEPTH*HEIGHT*WIDTH);
    
}

- (void)prepareNumsLayersMethod{
    
    self.recyclePool = [NSMutableSet set];
    
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING, (HEIGHT - 1)*SPACING);
    //set up perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;
    
    [self updateLayers];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateLayers];
}

- (void)updateLayers {
    
    //calculate clipping bounds
    CGRect bounds = self.scrollView.bounds;
    bounds.origin = self.scrollView.contentOffset;
    bounds = CGRectInset(bounds, -SIZE/2, -SIZE/2);
    //add existing layers to pool
    [self.recyclePool addObjectsFromArray:self.scrollView.layer.sublayers];
    //disable animation
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    //create layers
    NSInteger recycled = 0;
    NSMutableArray *visibleLayers = [NSMutableArray array];
    for (int z = DEPTH - 1; z >= 0; z--)
    {
        //increase bounds size to compensate for perspective
        CGRect adjusted = bounds;
        adjusted.size.width /= PERSPECTIVE(z*SPACING);
        adjusted.size.height /= PERSPECTIVE(z*SPACING);
        adjusted.origin.x -= (adjusted.size.width - bounds.size.width) / 2; adjusted.origin.y -= (adjusted.size.height - bounds.size.height) / 2;
        for (int y = 0; y < HEIGHT; y++) {
            //check if vertically outside visible rect
            if (y*SPACING < adjusted.origin.y || y*SPACING >= adjusted.origin.y + adjusted.size.height)
            {
                continue;
            }
            for (int x = 0; x < WIDTH; x++) {
                //check if horizontally outside visible rect
                if (x*SPACING < adjusted.origin.x || x*SPACING >= adjusted.origin.x + adjusted.size.width)
                {
                    continue;
                }
                //recycle layer if available
                CALayer *layer = [self.recyclePool anyObject];
                if (layer)
                {
                    recycled ++;
                    [self.recyclePool removeObject:layer];
                }
                else
                {
                    layer = [CALayer layer];
                    layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                }
                //set position
                layer.position = CGPointMake(x*SPACING, y*SPACING); layer.zPosition = -z*SPACING;
                //set background color
                layer.backgroundColor =
                [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
                //attach to scroll view
                [visibleLayers addObject:layer];
            }
        }
    }
    [CATransaction commit]; //update layers
    self.scrollView.layer.sublayers = visibleLayers;
}

@end
