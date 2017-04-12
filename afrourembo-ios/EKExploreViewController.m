//
//  EKExploreViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKExploreViewController.h"

static NSString * const kExploreCell = @"exploreCollectionCell";
static NSString * const kSideMenuSegue = @"exploreVcToSideMenuVC";

@implementation EKExploreViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO: REMOVE AFTER TESTING
    _dataSourceArray = [self createStubs];
    [self.collectionView reloadData];
}

- (NSArray *)createStubs {
    
    Service *service1 = [Service new];
    service1.serviceTitle = @"NATURAL HAIR";
    service1.serviceImage = @"dummy_portrait1";
    
    Service *service2 = [Service new];
    service2.serviceTitle = @"BEST WEAVING & EXTENSIONS";
    service2.serviceImage = @"dummy_portrait2";
    
    Service *service3 = [Service new];
    service3.serviceTitle = @"TRENDING BARBERS";
    service3.serviceImage = @"dummy_portrait3";
    
    Service *service4 = [Service new];
    service4.serviceTitle = @"SPECIAL OCCASIONS PROS";
    service4.serviceImage = @"dummy_portrait4";
    
    return @[service1, service2, service3, service4, service1, service2, service3, service4, service1, service2, service3, service4];
}

#pragma mark - UICollectionViewLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(1, 2, 1, 2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = (collectionView.bounds.size.width - 8) / 2 ;
    CGFloat cellHeight = cellWidth * 0.75;
    
    return CGSizeMake(cellWidth, cellHeight);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Service *service = [_dataSourceArray objectAtIndex:indexPath.row];
    
    EKExploreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kExploreCell forIndexPath:indexPath];
    cell.cellTitleLabel.text = service.serviceTitle;
    cell.cellImageView.image = [UIImage imageNamed:service.serviceImage];

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Navigation

- (IBAction)unwindToExploreVC:(UIStoryboardSegue *)segue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
