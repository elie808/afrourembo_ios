//
//  EKDiscoverMapViewController+TableView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDiscoverMapViewController+TableView.h"

static NSString * const  kTableViewCell = @"proListCell";
static NSString * const  kSalonTableViewCell = @"salonListCell";
static NSString * const  kDayCollectionViewCell = @"salonListInCellCollectionViewCell";

@implementation EKDiscoverMapViewController (TableView)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    id venueObj = [self.dataSourceArray objectAtIndex:indexPath.row];

    if ([venueObj isKindOfClass:[Professional class]]) {
        
        EKSalonListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell forIndexPath:indexPath];
        
        [cell configureCellWithProfessional:venueObj];
        
        return cell;
    }

    if ([venueObj isKindOfClass:[Salon class]]) {
        
        EKSalonListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSalonTableViewCell forIndexPath:indexPath];
        
        [cell configureCellWithSalon:venueObj];
        
        return cell;
    }

    return nil;
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
    
    id venueObj = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kCompanyProfile sender:venueObj];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;

    id venueObj = [self.dataSourceArray objectAtIndex:index];
    
    if ([venueObj isKindOfClass:[Professional class]]) {
    
//        return ((Professional*)venueObj).schedule.count * 3;
        return ((Professional*)venueObj).schedule.count;
    
    } else if ([venueObj isKindOfClass:[Salon class]]) {
        
        return 0;
    
    } else {
        
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    
    id venueObj = [self.dataSourceArray objectAtIndex:index];
    
    if ([venueObj isKindOfClass:[Professional class]]) {
        
        Day *schedule = ((Professional *)venueObj).schedule[indexPath.row];
        
        NSString *dayOfTheWeek = [Day dayStringFromNumber:schedule.dayNumber];
        NSString *fromTime = [Day formatTimeStringFromHour:schedule.fromHours andMinutes:schedule.fromMinutes];
        NSString *toTime   = [Day formatTimeStringFromHour:schedule.toHours andMinutes:schedule.toMinutes];
        
        EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDayCollectionViewCell
                                                                                        forIndexPath:indexPath];
        
        cell.cellDayLabel.text  = dayOfTheWeek;
        cell.cellStartHourLabel.text = fromTime;
        cell.cellEndHourLabel.text   = toTime;
        
        return cell;
        
        /*
        if (indexPath.row % 3 == 0) {
            
            EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDayCollectionViewCell
                                                                                            forIndexPath:indexPath];
            
//            cell.cellTextLabel.text = dayOfTheWeek;
            
            return cell;
            
        } else if (indexPath.row % 3 == 1) {

            EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
            
            cell.cellTextLabel.text = fromTime;
            
            return cell;
            
        } else if (indexPath.row % 3 == 2) {

            EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
            
            cell.cellTextLabel.text = toTime;
            
            return cell;
            
        } else {
            
            return nil;
        }
        */
    
    } else if ([venueObj isKindOfClass:[Salon class]]) {
        
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
