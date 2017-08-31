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
        
        Day *day = [Day new];
        
        day.dayName = [NSDate stringFromDate:[NSDate addDays:i after:[NSDate todayDate]]
                                  withFormat:DateFormatLetterDayMonthYearAbbreviated];
        
        day.dayNumber = [Day dayNumberFromDay:[NSDate addDays:i after:[NSDate todayDate]]];
        
        [self.daysDataSource addObject:day];
    }
    
    // check if day number matches anything in the passed daysArray
    //    for (Day *profAvailableDay in daysArray) {
    
    // go over the newly created days
    for (Day *dataSourceDay in self.daysDataSource) {
        
        if (dataSourceDay.dayNumber &&
            [[daysArray valueForKey:@"dayNumber"] containsObject:dataSourceDay.dayNumber] ) {
            
            NSString *predStr = [NSString stringWithFormat:@"dayNumber = %@", dataSourceDay.dayNumber];
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:predStr];
            Day *profAvailableDay = [[daysArray filteredArrayUsingPredicate:pred] firstObject];
            
            dataSourceDay.timeSlotsArray = [NSArray arrayWithArray:[self populateDayWithTimes:profAvailableDay.fromHours
                                                                                   endingHour:profAvailableDay.toHours
                                                                          lunchBreakStartHour:profAvailableDay.lunchBreakFromHours
                                                                            lunchBreakEndHour:profAvailableDay.lunchBreakToHours
                                                                           inMinuteIncrements:@15]];
        } else {
            
            NSLog(@"dataSourceDay.dayNumber: %@", dataSourceDay.dayNumber);
            
            dataSourceDay.timeSlotsArray = [self markDayUnavailableFrom:@9
                                                             endingHour:@17
                                                     inMinuteIncrements:@15];
        }
    }
    //    }
}

- (NSArray *)populateDayWithTimes:(NSNumber *)startHour endingHour:(NSNumber *)toHour lunchBreakStartHour:(NSNumber *)lbFromHour lunchBreakEndHour:(NSNumber *)lbToHour inMinuteIncrements:(NSNumber *)minIncrements {
    
    NSMutableArray *timeSlotsArray = [NSMutableArray new];
    BOOL isAvailable;
    
    for (int hour = [startHour intValue]; hour < [toHour intValue]; hour++) {
        
        for (int startingMin = 0; startingMin < 60; startingMin += [minIncrements intValue]) {
            
            if (lbFromHour > 0 && lbToHour > 0) {
                
                // block out lunch break hours
                if ( hour >= [lbFromHour intValue] && hour < [lbToHour intValue] ) {
                    
                    isAvailable = NO;
                    
                } else {
                    
                    isAvailable = YES;
                }
                
                TimeSlot *slot = [[TimeSlot alloc] initWithDate:[NSDate todayAtTime:[NSNumber numberWithInt:hour]
                                                                            minutes:[NSNumber numberWithInt:startingMin]]
                                                andAvailability:isAvailable];
                
                [timeSlotsArray addObject:slot];
            }
        }
    }
    
    return [NSArray arrayWithArray:timeSlotsArray];
}

- (NSArray *)markDayUnavailableFrom:(NSNumber *)startHour endingHour:(NSNumber *)toHour inMinuteIncrements:(NSNumber *)minIncrements {
    
    NSMutableArray *timeSlotsArray = [NSMutableArray new];
    
    for (int hour = [startHour intValue]; hour < [toHour intValue]; hour++) {
        
        for (int startingMin = 0; startingMin < 60; startingMin += [minIncrements intValue]) {
            
            TimeSlot *slot = [[TimeSlot alloc] initWithDate:[NSDate todayAtTime:[NSNumber numberWithInt:hour]
                                                                        minutes:[NSNumber numberWithInt:startingMin]]
                                            andAvailability:NO];
            
            [timeSlotsArray addObject:slot];
        }
    }
    
    return [NSArray arrayWithArray:timeSlotsArray];
}

- (void)highlightCellsForTimeSlotAtIndexPath:(NSIndexPath *)indexPath {
    
    TimeSlot *timeSlot = self.timesDataSource[indexPath.row];
    
    // compute how many time slots ahead to highlight
    int timeSlotsAhead = self.passedService.time / 15;
    
    if (timeSlot.isAvailable && (indexPath.row + timeSlotsAhead) < self.timesDataSource.count) {
        
        // check if slots to be selected, don't overlap with unavailable slots
        BOOL allSlotsAheadAvailable = YES;
        for (int i = 0; i <= timeSlotsAhead; i++) {
            
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
