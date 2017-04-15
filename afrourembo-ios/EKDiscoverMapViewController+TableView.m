//
//  EKDiscoverMapViewController+TableView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDiscoverMapViewController+TableView.h"

static NSString * const  kTableViewCell = @"salonListCell";
static NSString * const  kCollectionViewCell = @"yellowSalonListInCellCollectionViewCell";
static NSString * const  kDayCollectionViewCell = @"whiteSalonListInCellCollectionViewCell";

@implementation EKDiscoverMapViewController (TableView)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKSalonListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell forIndexPath:indexPath];
    
    Salon *salon = [self.dataSourceArray objectAtIndex:indexPath.row];
    [cell configureCellWithSalon:salon];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(EKSalonListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // keep track in which cell the collectionView is, to properly manage it's dataSource and display correctly
    cell.collectionView.collectionIndexPath = indexPath;
    [cell.collectionView reloadData];
    
    NSInteger index = cell.collectionView.collectionIndexPath.row;
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(EKSalonListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat horizontalOffset = cell.collectionView.contentOffset.x;
    NSInteger index = cell.collectionView.collectionIndexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:kCompanyProfile sender:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    Salon *salon = [self.dataSourceArray objectAtIndex:index];
    
    return salon.timesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 4 == 0) {
        
        EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDayCollectionViewCell forIndexPath:indexPath];
        
        NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
        Salon *salon = [self.dataSourceArray objectAtIndex:index];
        cell.cellTextLabel.text = [salon.timesArray objectAtIndex:indexPath.row];
        
        return cell;
        
    } else {
        
        EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
        
        NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
        Salon *salon = [self.dataSourceArray objectAtIndex:index];
        cell.cellTextLabel.text = [salon.timesArray objectAtIndex:indexPath.row];
        
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
