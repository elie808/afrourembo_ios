//
//  EKBookingViewController+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingViewController.h"

@interface EKBookingViewController (Helpers)

- (void)populateDataSourcesFrom:(NSArray<Day*> *)daysArray;

- (NSArray *)populateDayWithTimes:(NSNumber *)startHour endingHour:(NSNumber *)toHour lunchBreakStartHour:(NSNumber *)lbFromHour lunchBreakEndHour:(NSNumber *)lbToHour inMinuteIncrements:(NSNumber *)minIncrements;

- (NSArray *)markDayUnavailableFrom:(NSNumber *)startHour endingHour:(NSNumber *)toHour inMinuteIncrements:(NSNumber *)minIncrements;

- (void)highlightCellsForTimeSlotAtIndexPath:(NSIndexPath *)indexPath;

- (void)handleVendorAvailabilityErrors:(NSError *)error errorMessage:(NSString *)errorMessage statusCode:(NSInteger) statusCode;

@end
