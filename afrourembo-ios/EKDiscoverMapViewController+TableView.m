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
    
    Professional *profObj = [self.dataSourceArray objectAtIndex:indexPath.row];

    [cell configureCellWithProfessional:profObj];
    
//  [cell configureCellWithSalon:salon];
    
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
    
    Professional *profObj = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kCompanyProfile sender:profObj];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;

    Professional *profObj = [self.dataSourceArray objectAtIndex:index];
    
    return profObj.schedule.count * 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    Professional *profObj = [self.dataSourceArray objectAtIndex:index];
    
    Day *schedule = profObj.schedule[0];
    
    NSString *dayOfTheWeek = [Day dayInitialsStringFromNumber:schedule.dayNumber];
    
    NSString *fromTime = [Day fromTimeString:schedule];
    NSString *toTime   = [Day toTimeString:schedule];

    if (indexPath.row % 3 == 0) {
    
        EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDayCollectionViewCell
                                                                                        forIndexPath:indexPath];

        cell.cellTextLabel.text = dayOfTheWeek;
    
        return cell;
        
    } else if (indexPath.row % 3 == 1) {
        
        NSLog(@"INDEX PATH ROW: %ld, FROM TIME: %@", (long)indexPath.row, fromTime);
        
        EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];

        cell.cellTextLabel.text = fromTime;
        
        return cell;
    
    } else if (indexPath.row % 3 == 2) {
        
        NSLog(@"INDEX PATH ROW: %ld, TO TIME: %@", (long)indexPath.row, toTime);
        
        EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    
        cell.cellTextLabel.text = toTime;
        
        return cell;
    
    } else {
    
        return nil;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
