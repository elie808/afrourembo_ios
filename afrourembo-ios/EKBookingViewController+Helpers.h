//
//  EKBookingViewController+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingViewController.h"

@interface EKBookingViewController (Helpers)

/// Helper method to take in the API response, and return a days data source array usable with the UI
- (NSArray<Day *> *)populateDataSourcesFrom:(NSArray<Day*> *)daysArray;

/// Helper method called by populateDataSourcesFrom:, to abstract populating the hours inside each day
- (NSArray *)markDayAvailable:(NSDate *)day startingHour:(NSNumber *)startHour endingHour:(NSNumber *)toHour lunchBreakStartHour:(NSNumber *)lbFromHour lunchBreakEndHour:(NSNumber *)lbToHour inMinuteIncrements:(NSNumber *)minIncrements;

/// Helper method called by populateDataSourcesFrom:, to abstract populating the hours inside each day
- (NSArray *)markDayUnavailable:(NSDate *)day from:(NSNumber *)startHour endingHour:(NSNumber *)toHour inMinuteIncrements:(NSNumber *)minIncrements;

- (void)highlightCellsForTimeSlotAtIndexPath:(NSIndexPath *)indexPath;

- (void)handleVendorAvailabilityErrors:(NSError *)error errorMessage:(NSString *)errorMessage statusCode:(NSInteger) statusCode;

@end
