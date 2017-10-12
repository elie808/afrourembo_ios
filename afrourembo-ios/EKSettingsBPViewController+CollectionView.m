//
//  EKSettingsBPViewController+CollectionView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/12/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSettingsBPViewController+CollectionView.h"

static NSString * const kCollectionCell = @"settingsCollectionCell";

@implementation EKSettingsBPViewController (CollectionView)

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
     return 1;
}
 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCell
                                                                           forIndexPath:indexPath];
 
 //    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
 //    Salon *salon = [self.dataSourceArray objectAtIndex:index];
 //    cell.cellTextLabel.text = [salon.timesArray objectAtIndex:indexPath.row];
 
    return cell;
}
 
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end
