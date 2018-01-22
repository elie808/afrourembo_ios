//
//  EKBookingViewController+CollectionView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingViewController+CollectionView.h"
#import "EKBookingViewController+Helpers.h"

static NSString * const kProCell = @"bookingProfessionalCell";
static NSString * const kDayCell = @"bookingDayCell";
static NSString * const kTimeCell = @"bookingTimeCell";

@implementation EKBookingViewController (CollectionView)

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.proCollectionView) {
        return self.professionalsDataSource.count;
    }
    
    if (collectionView == self.dayCollectionView) {
        return self.daysDataSource.count;
    }
    
    if (collectionView == self.timeCollectionView) {
        return self.timesDataSource.count;
    }
    
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.proCollectionView) {
        
        EKBookingProCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProCell forIndexPath:indexPath];
        
        Professional *pro = self.professionalsDataSource[indexPath.row];
        
        [cell configureCellWithPro:pro];
        
        return cell;
    }
    
    if (collectionView == self.dayCollectionView) {
        
        EKBookingDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDayCell forIndexPath:indexPath];
        
        Day *day = self.daysDataSource[indexPath.row];
        
        cell.cellDayLabel.text = day.dayName;
        
        return cell;
    }
    
    if (collectionView == self.timeCollectionView) {
        
        EKBookingTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTimeCell forIndexPath:indexPath];
        
        TimeSlot *timeSlot = self.timesDataSource[indexPath.row];
        
        [cell configureCell:timeSlot];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.proCollectionView) {
        
        Professional *pro = self.professionalsDataSource[indexPath.row];
        
        [self getDaysForPro:pro];
    }
    
    if (collectionView == self.dayCollectionView) {
        
        Day *day = self.daysDataSource[indexPath.row];
        
        [self.timesDataSource removeAllObjects];
        [self.timesDataSource addObjectsFromArray:day.timeSlotsArray];
        
        [self.timeCollectionView reloadData];
    }
    
    if (collectionView == self.timeCollectionView) {
        
        [self highlightCellsForTimeSlotAtIndexPath:indexPath];
        
        [self.timeCollectionView reloadData];
    }
}

// center solo cells
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (collectionView == self.proCollectionView && self.professionalsDataSource.count <= 1) {
        
        return UIEdgeInsetsMake(0, (self.view.frame.size.width/2) - 55., 0, 0);
        
    } else {
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark - Helpers

- (void)getDaysForPro:(Professional *)pro {

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Day getAvailabilityOfVendor:pro.professionalID
                          ofType:kProfessionalType // hardcoded, because we decided to only support this type for now ...
                       withToken:[EKSettings getSavedCustomer].token
                       withBlock:^(NSArray *daysArray) {
                           
                           self.selectedPro = pro;
                           self.emptyTimeDataView.hidden = YES;
                           [self.daysDataSource addObjectsFromArray:[self populateDataSourcesFrom:daysArray]];
                           // [self.dayCollectionView reloadData];
                           
                           // get the already booked slots/appointements of a professional
                           [Booking getBookingsForVendor:pro.professionalID
                                                  ofType:kProfessionalType
                                               withToken:[EKSettings getSavedCustomer].token
                                               withBlock:^(NSArray<VendorBookings *> *array) {
                                                   
                                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                   [self disableBookedTimeSlots:array];
                                                   [self.dayCollectionView reloadData];
                                                   
                                               } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                   
                                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                   [self handleVendorAvailabilityErrors:error errorMessage:errorMessage statusCode:statusCode];
                                               }];
                           
                       } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                           
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           self.emptyTimeDataView.hidden = NO;
                           
                           [self handleVendorAvailabilityErrors:error errorMessage:errorMessage statusCode:statusCode];
                       }];
}

@end
