//
//  ACImageIOViewController.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/29.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACImageIOViewController.h"
#import "ACCollectionViewLayout.h"
#import <ImageIO/ImageIO.h>

@interface ACImageIOViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CALayerDelegate>

@property(nonatomic, copy)NSArray *imagesArray;
@property (nonatomic, readwrite, strong) UICollectionView *collectionView;

@end

@implementation ACImageIOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[ACCollectionViewLayout alloc] init]];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.dataSource = self;
    
    self.imagesArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@"images"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UICollectionViewCell alloc] initWithFrame:self.collectionView.bounds];
    }
    
//    [self mutableThreadMethodWithIndex:indexPath inCell:cell];
//    [self imageIOMethodWithIndex:indexPath inCell:cell];
    
//    [self cgcontextMethodWithIndex:indexPath inCell:cell];
    
//    [self catiledLayerMethodWithIndex:indexPath inCell:cell];
    [self cacheLoadMethodWithIndex:indexPath inCell:cell];
    
    return cell;
    
}

- (void)mutableThreadMethodWithIndex:(NSIndexPath *)indexPath inCell:(UICollectionViewCell *)cell{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    
    NSString *path = self.imagesArray[indexPath.row%self.imagesArray.count];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
        
    });
    [cell.contentView addSubview:imageView];
}

- (void)imageIOMethodWithIndex:(NSIndexPath *)indexPath inCell:(UICollectionViewCell *)cell{

    /*
     这样就可以使用kCGImageSourceShouldCache来创建图片，强制图片立刻解压，然后在图片的生命周期保留解压后的版本。
     */
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    
    NSString *path = self.imagesArray[indexPath.row%self.imagesArray.count];
    NSURL *imageUrl = [NSURL fileURLWithPath:path];
    NSDictionary *options = @{(__bridge id)kCGImageSourceShouldCache:@YES};
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)imageUrl, NULL);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, (__bridge CFDictionaryRef)options);
    
    imageView.image = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    [cell.contentView addSubview:imageView];
    
}

- (void)cgcontextMethodWithIndex:(NSIndexPath *)indexPath inCell:(UICollectionViewCell *)cell{

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSString *path = self.imagesArray[indexPath.row%self.imagesArray.count];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        UIGraphicsBeginImageContextWithOptions(cell.bounds.size, YES, 0);
        [image drawInRect:imageView.bounds];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
    [cell.contentView addSubview:imageView];
}

- (void)catiledLayerMethodWithIndex:(NSIndexPath *)indexPath inCell:(UICollectionViewCell *)cell{
    
    CATiledLayer *tiledLayer = (CATiledLayer *)cell.contentView.layer.sublayers.lastObject;
    if (!tiledLayer) {
        tiledLayer = [CATiledLayer layer];
        tiledLayer.frame = cell.bounds;
        tiledLayer.tileSize = CGSizeMake(cell.bounds.size.width * [UIScreen mainScreen].scale, cell.bounds.size.height * [UIScreen mainScreen].scale);
        tiledLayer.contentsScale = [UIScreen mainScreen].scale;
        tiledLayer.delegate = self;
        [cell.contentView.layer addSublayer:tiledLayer];
    }
    
    tiledLayer.contents = nil;
    [tiledLayer setValue:@(indexPath.row) forKey:@"index"];
    [tiledLayer setNeedsDisplay];
}

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx
{
    //get image index
    NSInteger index = [[layer valueForKey:@"index"] integerValue];
    //load tile image
    NSString *imagePath = self.imagesArray[index%self.imagesArray.count];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
    //calculate image rect
    CGFloat aspectRatio = tileImage.size.height / tileImage.size.width;
    CGRect imageRect = CGRectZero;
    imageRect.size.width = layer.bounds.size.width;
    imageRect.size.height = layer.bounds.size.height * aspectRatio;
    imageRect.origin.y = (layer.bounds.size.height - imageRect.size.height)/2;
    //draw tile
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:imageRect];
    UIGraphicsPopContext();
}

- (void)cacheLoadMethodWithIndex:(NSIndexPath *)indexPath inCell:(UICollectionViewCell *)cell{

    UIImageView *imageView = [cell.contentView.subviews lastObject];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imageView];
    }
    //set or load image for this index
    imageView.image = [self loadImageAtIndex:indexPath.item];
    //preload image for previous and next index
    if (indexPath.item < 100 - 1) {
        [self loadImageAtIndex:indexPath.item + 1]; }
    if (indexPath.item > 0) {
        [self loadImageAtIndex:indexPath.item - 1]; }
    
}

- (UIImage *)loadImageAtIndex:(NSUInteger)index
{
    //set up cache
    static NSCache *cache = nil;
    if (!cache) {
        cache = [[NSCache alloc] init];
    }
    //if already cached, return immediately
    UIImage *image = [cache objectForKey:@(index)];
    if (image) {
        return [image isKindOfClass:[NSNull class]]? nil: image;
    }
    //set placeholder to avoid reloading image multiple times
    [cache setObject:[NSNull null] forKey:@(index)];
    //switch to background thread
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        //load image
        NSString *imagePath = self.imagesArray[index%self.imagesArray.count];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        //redraw image using device context
        UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //set image for correct image view
        dispatch_async(dispatch_get_main_queue(), ^{ //cache the image
            [cache setObject:image forKey:@(index)];
            //display the image
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem: index inSection:0]; UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            UIImageView *imageView = [cell.contentView.subviews lastObject];
            imageView.image = image;
        });
    });
    //not loaded yet
    return nil;
}

@end
