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
    return self.collectionViewDataSource.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EKCompanyProfessionalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCell
                                                                                              forIndexPath:indexPath];
    
    if (indexPath.row == self.collectionViewDataSource.count) {
        
        cell.cellImageView.image = [UIImage imageNamed:@"icAdd"];
        cell.cellImageView.backgroundColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
        cell.cellNameLabel.text = @"Add new";
        
    } else {

        //TODO: Show salon profile pictures here
        // [cell.cellImageView yy_setImageWithURL:[NSURL URLWithString:@""] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        cell.cellImageView.backgroundColor = [UIColor clearColor];
//        cell.cellNameLabel.text = @"First Last name";
    }
 
    return cell;
}
 
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.collectionViewDataSource.count) {
        NSLog(@"ADD SALON");
    } else {
        NSLog(@"Salon cell");
    }
}

@end
