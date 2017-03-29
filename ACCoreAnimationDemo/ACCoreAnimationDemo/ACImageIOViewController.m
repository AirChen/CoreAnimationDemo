//
//  ACImageIOViewController.m
//  ACCoreAnimationDemo
//
//  Created by Air_chen on 2017/3/29.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACImageIOViewController.h"
#import "ACCollectionViewLayout.h"

@interface ACImageIOViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

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
    return self.imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UICollectionViewCell alloc] initWithFrame:self.collectionView.bounds];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    
    NSString *path = self.imagesArray[indexPath.row];
    imageView.image = [UIImage imageWithContentsOfFile:path];
    
    [cell.contentView addSubview:imageView];
    
    return cell;
    
}

@end
