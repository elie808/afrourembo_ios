//
//  EKCompanyProfileViewController+TableView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/15/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyProfileViewController+TableView.h"

static NSString * const kServicesCell       = @"companyServicesCell";
static NSString * const kReviewsCell        = @"companyReviewsCell";
static NSString * const kProfessionalsCell  = @"companyProfessionalsCell";
static NSString * const kContactsCell       = @"companyContactsCell";

static NSString * const kProfessionalsCollectionCell = @"companyProfessionalsCollectionCell";

@implementation EKCompanyProfileViewController (TableView)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
            
        case 0: return self.salon.servicesArray.count > 0 ? self.salon.servicesArray.count : 1; break; // Services
            
        case 1: return 2; break; // Reviews
            
        case 2: return 1; break; // Professionals
            
        case 3: return 3; break; // Contacts
            
        default: return 0; break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
            
        case 0: { // Services

            EKCompanyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kServicesCell forIndexPath:indexPath];
            
            if (self.salon.servicesArray.count > 0) {
            
                Service *serviceObj = [self.salon.servicesArray objectAtIndex:indexPath.row];
             
                cell.cellDelegate = self;
                [cell configureCellForService:serviceObj];
            
            } else {
            
                [cell configureEmptyCell];
            }
            
            return cell;
            
        } break;
            
        case 1: { // Reviews
            
            EKCompanyReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReviewsCell forIndexPath:indexPath];
            
            return cell;
            
        } break;
            
        case 2: { // Professionals
            
            EKCompanyProfessionalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfessionalsCell forIndexPath:indexPath];
            
            return cell;
            
        } break;
            
        case 3: { // Contacts
            
            EKCompanyContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactsCell forIndexPath:indexPath];
            
            return cell;
            
        } break;
            
        default: return nil; break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
            
            // Services
        case 0: return 82.0; break;
            
            // Reviews
        case 1: {
            
//            if (indexPath.row == 0) return 350;
            
            return 380.0;
            
        } break;
            
            // Professionals
        case 2: return 110.0; break;
            
            // Contacts
        case 3: return 72.0; break;
            
        default: return 44.0; break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
            
        case 0: return @"SERVICES"; break; // Services
            
        case 1: return @"REVIEWS"; break; // Reviews
            
        case 2: return @"BEAUTY PROFESSIONALS"; break; // Professionals
            
        case 3: return @"CONTACT INFO"; break; // Contacts
            
        default: return @""; break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.contentView.backgroundColor = [UIColor whiteColor];
    header.textLabel.font = [UIFont boldSystemFontOfSize:22.];
    
    if (section == 3) {
        
        header.contentView.backgroundColor = [UIColor colorWithRed:51./255. green:51./255. blue:51./255. alpha:1.0];
        header.textLabel.textColor = [UIColor whiteColor];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(EKCompanyProfessionalTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // keep track in which cell the collectionView is, to properly manage it's dataSource and display correctly
//    cell.cellCollectionView.collectionIndexPath = indexPath;
    //    [cell.cellCollectionView reloadData];
    
    //    NSInteger index = cell.cellCollectionView.collectionIndexPath.row;
    //    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    //    [cell.cellCollectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(EKCompanyProfessionalTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFloat horizontalOffset = cell.collectionView.contentOffset.x;
    //    NSInteger index = cell.collectionView.collectionIndexPath.row;
    //    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    //    Salon *salon = [self.dataSourceArray objectAtIndex:index];
    
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EKCompanyProfessionalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProfessionalsCollectionCell forIndexPath:indexPath];
    
    //    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    //    Salon *salon = [self.dataSourceArray objectAtIndex:index];
    //    cell.cellTextLabel.text = [salon.timesArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
