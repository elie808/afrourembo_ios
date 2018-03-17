//
//  EKBookingViewController+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingViewController+Helpers.h"

@implementation EKBookingViewController (Helpers)

- (NSArray<Day *> *)populateDataSourcesFrom:(NSArray<Day*> *)daysArray {

    NSMutableArray *populatedDays = [NSMutableArray new];
    
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    
    // create 10 days from today
    for (int i = 0; i < 10; i++) {

        // create a day that we'll populate with relevant data if it matches the pro's availability
        Day *weekDay = [Day new];
        weekDay.dayDate = [todayDate dateByAddingDays:i];
        weekDay.dayName = [NSDate stringFromDate:[todayDate dateByAddingDays:i] withFormat:DateFormatLetterDayMonthYearAbbreviated];
        weekDay.dayNumber = [Day dayNumberFromDay:[todayDate dateByAddingDays:i]];
        
        // check if the pro is available on this weekday
        NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"dayNumber = %@", weekDay.dayNumber]];
        NSArray *dayFromWeek = [daysArray filteredArrayUsingPredicate:pred];
        
        // if pro is available on that day
        if (dayFromWeek.count > 0) {

            // get the pro's available start-end times and add them to weekDay
            Day *proAvailableDay = [dayFromWeek firstObject];
            
            if (i == 0) {

                weekDay.timeSlotsArray = [NSArray arrayWithArray:[self markTodayAvailable:weekDay.dayDate
                                                                             startingHour:proAvailableDay.fromHours
                                                                               endingHour:proAvailableDay.toHours
                                                                      lunchBreakStartHour:proAvailableDay.lunchBreakFromHours
                                                                        lunchBreakEndHour:proAvailableDay.lunchBreakToHours
                                                                       inMinuteIncrements:@15
                                                                              atTimeToday:[[NSDate date] hour]]];
                
            } else {

                weekDay.timeSlotsArray = [NSArray arrayWithArray:[self markDayAvailable:weekDay.dayDate
                                                                           startingHour:proAvailableDay.fromHours
                                                                             endingHour:proAvailableDay.toHours
                                                                    lunchBreakStartHour:proAvailableDay.lunchBreakFromHours
                                                                      lunchBreakEndHour:proAvailableDay.lunchBreakToHours
                                                                     inMinuteIncrements:@15]];
            }

        } else {

            // since pro isn't available, mark weekDay as unavailable and populate with arbitrary start-end times
            weekDay.timeSlotsArray = [self markDayUnavailable:weekDay.dayDate from:@9 endingHour:@17 inMinuteIncrements:@15];
        }
        
        [populatedDays addObject:weekDay];
    }
    
    return [NSArray arrayWithArray:populatedDays];
}

- (NSArray *)markDayAvailable:(NSDate *)day startingHour:(NSNumber *)startHour endingHour:(NSNumber *)toHour lunchBreakStartHour:(NSNumber *)lbFromHour lunchBreakEndHour:(NSNumber *)lbToHour inMinuteIncrements:(NSNumber *)minIncrements {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:day];
    
    NSMutableArray *timeSlotsArray = [NSMutableArray new];
    BOOL isHourAvailable;

    for (int hour = [startHour intValue]; hour < [toHour intValue]; hour++) {
        
        for (int startingMin = 0; startingMin < 60; startingMin += [minIncrements intValue]) {

            // check if lunch break properties are non nil (or even exist) on server before acounting for lunchbreak hours
            if (lbFromHour && lbToHour) {

                // block out lunch break hours as long as those values make sense ( are > 0)
                if (lbFromHour > 0 && lbToHour > 0 && hour >= [lbFromHour intValue] && hour < [lbToHour intValue] ) {
                    
                    isHourAvailable = NO;
                    
                } else {
                    
                    isHourAvailable = YES;
                }
                
            } else {
                
                isHourAvailable = YES;
            }
    
                TimeSlot *slot = [TimeSlot new];
                
                [comps setHour:hour];
                [comps setMinute:startingMin];
                [comps setSecond:[@0 intValue]];
                slot.date = [calendar dateFromComponents:comps];
                
                slot.isAvailable = isHourAvailable;
                slot.isSelected = NO;
                
                slot.hourString = [NSDate stringFromDate:slot.date withFormat:DateFormatDigitHourMinute];

                [timeSlotsArray addObject:slot];
        }
    }
    
    return [NSArray arrayWithArray:timeSlotsArray];
}

/// Mark today as available, but disable the calendar till the current time
- (NSArray *)markTodayAvailable:(NSDate *)day startingHour:(NSNumber *)startHour endingHour:(NSNumber *)toHour lunchBreakStartHour:(NSNumber *)lbFromHour lunchBreakEndHour:(NSNumber *)lbToHour inMinuteIncrements:(NSNumber *)minIncrements atTimeToday:(NSInteger )currentTime {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:day];
    
    NSMutableArray *timeSlotsArray = [NSMutableArray new];
    BOOL isHourAvailable;
    
    for (int hour = [startHour intValue]; hour < [toHour intValue]; hour++) {
        
        for (int startingMin = 0; startingMin < 60; startingMin += [minIncrements intValue]) {

            // check if lunch break properties are non nil (or even exist) on server before acounting for lunchbreak hours
            if (lbFromHour && lbToHour) {
                
                // block out lunch break hours as long as those values make sense ( are > 0)
                if (lbFromHour > 0 && lbToHour > 0 && hour >= [lbFromHour intValue] && hour < [lbToHour intValue] ) {
                    isHourAvailable = NO;
                } else {
                    isHourAvailable = YES;
                }
                
            } else {
                
                isHourAvailable = YES;
            }
            
            if (hour <= currentTime) {
                isHourAvailable = NO;
            }
            
            TimeSlot *slot = [TimeSlot new];
            
            [comps setHour:hour];
            [comps setMinute:startingMin];
            [comps setSecond:[@0 intValue]];
            slot.date = [calendar dateFromComponents:comps];
            
            slot.isAvailable = isHourAvailable;
            slot.isSelected = NO;
            
            slot.hourString = [NSDate stringFromDate:slot.date withFormat:DateFormatDigitHourMinute];
            
            [timeSlotsArray addObject:slot];
        }
    }
    
    return [NSArray arrayWithArray:timeSlotsArray];
}


- (NSArray *)markDayUnavailable:(NSDate *)day from:(NSNumber *)startHour endingHour:(NSNumber *)toHour inMinuteIncrements:(NSNumber *)minIncrements {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:day];
    
    NSMutableArray *timeSlotsArray = [NSMutableArray new];
    
    for (int hour = [startHour intValue]; hour < [toHour intValue]; hour++) {
        
        for (int startingMin = 0; startingMin < 60; startingMin += [minIncrements intValue]) {
            
            TimeSlot *slot = [TimeSlot new];
            
            [comps setHour:hour];
            [comps setMinute:startingMin];
            [comps setSecond:[@0 intValue]];
            slot.date = [calendar dateFromComponents:comps];
            
            slot.isAvailable = NO;
            slot.isSelected = NO;
            
            slot.hourString = [NSDate stringFromDate:slot.date withFormat:DateFormatDigitHourMinute];
            
            [timeSlotsArray addObject:slot];
        }
    }
    
    return [NSArray arrayWithArray:timeSlotsArray];
}

- (void)disableBookedTimeSlots:(NSArray<VendorBookings *> *)vendorBookingsArray {
    
    if (self.daysDataSource.count > 0 && vendorBookingsArray.count > 0) {
        
        // go over the 10 weekdays in the data source
        for (Day *weekDay in self.daysDataSource) {
            
            // check all the booked dates of professional
            for (VendorBookings *bookedDate in vendorBookingsArray) {
                
                // if a booked date coincides with a day in the data source
                if ([weekDay.dayDate isSameDay:bookedDate.fromTime]) {
                    
                    // set unavailable slots
                    for (TimeSlot *timeSlot in weekDay.timeSlotsArray) {
                        
                        if ( [timeSlot.date hoursFrom:bookedDate.fromTime] == 0 && [timeSlot.date minutesFrom:bookedDate.fromTime] == 0) {
                            
                            timeSlot.isAvailable = NO;
                            
                        } else if ([timeSlot.date hoursFrom:bookedDate.toTime] == 0 && [timeSlot.date minutesFrom:bookedDate.toTime] == 0) {
                            
                            timeSlot.isAvailable = NO;
                            
                        } else if ([timeSlot.date hoursFrom:bookedDate.fromTime] > 0 && [timeSlot.date hoursFrom:bookedDate.toTime] < 0) {
                            
                            timeSlot.isAvailable = NO;
                        }
                        
                    }
                }
            }
        }
    }
}

- (void)highlightCellsForTimeSlotAtIndexPath:(NSIndexPath *)indexPath {
    
    TimeSlot *timeSlot = self.timesDataSource[indexPath.row];
    
    // compute how many time slots ahead to highlight. Knowing that the minimum service duration is 15 mins
    NSInteger timeSlotsAhead = self.passedService.time / 15;
    
    if (timeSlot.isAvailable && (indexPath.row + timeSlotsAhead) < self.timesDataSource.count) {
        
        // check if slots to be selected, don't overlap with unavailable slots
        BOOL allSlotsAheadAvailable = YES;
        for (NSInteger i = 0; i <= timeSlotsAhead; i++) {
            
            TimeSlot *nextSlot = self.timesDataSource[indexPath.row+i];
            if (!nextSlot.isAvailable) {
                allSlotsAheadAvailable = NO;
                i = timeSlotsAhead;
            }
        }
        
        // deselect all slots
        for (int j = 0; j < self.timesDataSource.count; j++) {
            TimeSlot *timeSlot = self.timesDataSource[j];
            timeSlot.isSelected = NO;
        }
        
        // highlight needed cells
        if (allSlotsAheadAvailable) {
            
            // nullify selected dates from before
            self.selectedFromDate   = nil;
            self.selectedToDate     = nil;
            
            for (int i = 0; i <= timeSlotsAhead; i++) {
                TimeSlot *nextSlot = self.timesDataSource[indexPath.row+i];
                nextSlot.isSelected = YES;
            }
            
            // update view model
            self.selectedFromDate   = ((TimeSlot *)(self.timesDataSource[indexPath.row])).date;
            self.selectedToDate     = ((TimeSlot *)(self.timesDataSource[indexPath.row + timeSlotsAhead])).date;
        }
    }
}

- (void)handleVendorAvailabilityErrors:(NSError *)error errorMessage:(NSString *)errorMessage statusCode:(NSInteger) statusCode {
    
    if (statusCode == 401) { // invalid token
        
        [self showLoginDialog:^(UIAlertAction *action, NSString *emailString, NSString *passString) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [Customer loginCustomer:emailString
                           password:passString
                          withBlock:^(Customer *customerObj) {
                              
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              [EKSettings saveCustomer:customerObj];
                          }
                         withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                             
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [self showMessage:errorMessage withTitle:@"There is something wrong"
                               completionBlock:nil];
                         }];
            
        } andSignUpBlock:^(UIAlertAction *action) {
            
            [EKSettings deleteBookingsForCustomer:[EKSettings getSavedCustomer]];
            [EKSettings deleteSavedCustomer];
            [self performSegueWithIdentifier:kSignUpSegue sender:nil];
        }];
        
    } else {
        
        [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
    }
}

@end
