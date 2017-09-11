//
//  EKBookingViewController+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingViewController+Helpers.h"

@implementation EKBookingViewController (Helpers)

- (void)populateDataSourcesFrom:(NSArray<Day*> *)daysArray {
    
    // create 10 days from today
    for (int i = 0; i < 10; i++) {
        
        NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
        Day *day = [Day new];
        
        day.dayDate = [todayDate dateByAddingDays:i];

        day.dayName = [NSDate stringFromDate:[todayDate dateByAddingDays:i] withFormat:DateFormatLetterDayMonthYearAbbreviated];
        
        day.dayNumber = [Day dayNumberFromDay:[todayDate dateByAddingDays:i]];

        NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"dayNumber = %@", day.dayNumber]];
        if ([daysArray filteredArrayUsingPredicate:pred].count > 0) {

            Day *availableDay = [[daysArray filteredArrayUsingPredicate:pred] firstObject];
            
            day.timeSlotsArray = [NSArray arrayWithArray:[self markDayAvailable:day.dayDate
                                                                   startingHour:availableDay.fromHours
                                                                     endingHour:availableDay.toHours
                                                            lunchBreakStartHour:availableDay.lunchBreakFromHours
                                                              lunchBreakEndHour:availableDay.lunchBreakToHours
                                                             inMinuteIncrements:@15]];
        } else {

            day.timeSlotsArray = [self markDayUnavailable:day.dayDate from:@9 endingHour:@17 inMinuteIncrements:@15];
        }
        
        [self.daysDataSource addObject:day];
    }
}

- (NSArray *)markDayAvailable:(NSDate *)day startingHour:(NSNumber *)startHour endingHour:(NSNumber *)toHour lunchBreakStartHour:(NSNumber *)lbFromHour lunchBreakEndHour:(NSNumber *)lbToHour inMinuteIncrements:(NSNumber *)minIncrements {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:day];
    
    NSMutableArray *timeSlotsArray = [NSMutableArray new];
    BOOL isHourAvailable;

    for (int hour = [startHour intValue]; hour < [toHour intValue]; hour++) {
        
        for (int startingMin = 0; startingMin < 60; startingMin += [minIncrements intValue]) {
            
            if (lbFromHour > 0 && lbToHour > 0) {
                
                // block out lunch break hours
                if ( hour >= [lbFromHour intValue] && hour < [lbToHour intValue] ) {
                    
                    isHourAvailable = NO;
                    
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
