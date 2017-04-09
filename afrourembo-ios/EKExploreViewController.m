//
//  EKExploreViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKExploreViewController.h"

static NSString * const kExploreCell = @"exploreCollectionCell";

@implementation EKExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EKExploreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kExploreCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
    
    switch (indexPath.row % 2) {
            
        case 0: cell.cellTitleLabel.text = @"BEST WEAVING & EXTENSIONS"; break;
        case 1: cell.cellTitleLabel.text = @"NATURAL HAIR"; break;
            
        default: break;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
