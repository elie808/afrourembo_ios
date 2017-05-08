//
//  EKFilterSearchViewController+TableView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKFilterSearchViewController+TableView.h"

static NSString * const  kTableViewCell         = @"salonListCell";
static NSString * const  kCollectionViewCell    = @"yellowSalonListInCellCollectionViewCell";
static NSString * const  kDayCollectionViewCell = @"whiteSalonListInCellCollectionViewCell";

static NSString * const  kCategoryCell    = @"categoryCellID";
static NSString * const  kSubCategoryCell = @"subCategoryCellID";

@implementation EKFilterSearchViewController (TableView)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        return self.dataSourceArray.count;
    }
    
    if (tableView == self.categoryTableView) {
        return self.categoryDataSource.count;
    }
    
    if (tableView == self.subCategoryTableView) {
        return self.subCategoryDataSource.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        
        EKSalonListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell forIndexPath:indexPath];
        
        Salon *salon = [self.dataSourceArray objectAtIndex:indexPath.row];
        [cell configureCellWithSalon:salon];
        
        return cell;
    }
    
    if (tableView == self.categoryTableView) {
        
        EKFilterSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCategoryCell forIndexPath:indexPath];
        cell.cellTextLabel.text = [self.categoryDataSource objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    if (tableView == self.subCategoryTableView) {
        
        EKFilterSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSubCategoryCell forIndexPath:indexPath];
        cell.cellTextLabel.text = [self.subCategoryDataSource objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView || tableView == self.subCategoryTableView) {
        return 48.0;
    }
    
    return 230;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(EKSalonListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
    
        // keep track in which cell the collectionView is, to properly manage it's dataSource and display correctly
        cell.collectionView.collectionIndexPath = indexPath;
        [cell.collectionView reloadData];
        
        NSInteger index = cell.collectionView.collectionIndexPath.row;
        CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
        
        [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(EKSalonListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        
        CGFloat horizontalOffset = cell.collectionView.contentOffset.x;
        NSInteger index = cell.collectionView.collectionIndexPath.row;
        self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        
        [self performSegueWithIdentifier:kCompanyProfile sender:nil];
    }
    
    if (tableView == self.categoryTableView) {
        
        [self.subCategoryDataSource removeAllObjects];
        [self.subCategoryDataSource addObjectsFromArray:@[@"New Sub 1", @"New Sub 2", @"New Sub 3"]];
        [self.subCategoryTableView reloadData];
    }
    
    if (tableView == self.subCategoryTableView) {
        
        [self hideFilterTableViewsWithAnimation:YES];
    }
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
