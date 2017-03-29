//
//  ACCollectionViewLayout.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/29.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACCollectionViewLayout.h"

@implementation ACCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        self.itemSize = CGSizeMake(size.width - 20.0, size.height - 20.0);
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.minimumInteritemSpacing = 10.0f;
        self.minimumLineSpacing = 10.0f;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

@end
