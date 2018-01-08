//
//  EKScheduleMonthlyViewController+TableView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/12/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKScheduleMonthlyViewController+TableView.h"

static NSString * const kTableCell = @"calendarTodayTableCell";
static NSString * const kCollectionCell = @"todayCell";

@implementation EKScheduleMonthlyViewController (TableView)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCell forIndexPath:indexPath];

    Today *todayObj = [self.tableDataSource objectAtIndex:indexPath.row];
    
    cell.cellHourOfTheDayLabel.text = todayObj.appointmentsHour;

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(EKTodayTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.collectionView.collectionIndexPath = indexPath;
    [cell.collectionView reloadData];
    
    NSInteger index = cell.collectionView.collectionIndexPath.row;
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(EKTodayTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat horizontalOffset = cell.collectionView.contentOffset.x;
    NSInteger index = cell.collectionView.collectionIndexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger index = ((EKInCellCollectionView *)collectionView).collectionIndexPath.row;
    Today *todayObj = [self.tableDataSource objectAtIndex:index];
    
    return todayObj.appointmentsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    Today *todayObj = [self.tableDataSource objectAtIndex:index];
    Appointment *aptObj = [todayObj.appointmentsArray objectAtIndex:indexPath.row];
    
    EKTodayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCell forIndexPath:indexPath];
    
    [cell configureCellForAppointment:aptObj];
    
    return cell;
}

#pragma mark - Helpers

/// create empty calendar UI
- (void)createCalendarGrid {
    
    [self.tableDataSource removeAllObjects];
    
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh a";
    
    for (int hoursIncrement = 0; hoursIncrement < 24; hoursIncrement++) {
        
        NSDate *hour = [todayDate dateByAddingHours:hoursIncrement];
        
        Today *today = [Today new];
        today.appointmentsHour = [dateFormatter stringFromDate:hour];
        today.appointmentsArray = @[];
        
        [self.tableDataSource addObject:today];
    }
    
    [self.tableView reloadData];
}

/// pure convenience method, to keep using Appointment objects, since this view's UI was built on them initially...
- (Appointment *)convertToAppointementObject:(Dashboard *)dashboardObject {
    
    Appointment *appt1 = [Appointment new];
    appt1.clientName = [NSString stringWithFormat:@"%@ %@", dashboardObject.fName, dashboardObject.lName];
    appt1.serviceDescription = dashboardObject.service;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh a";
    appt1.serviceTime = [dateFormatter stringFromDate:dashboardObject.startDate];
    
    appt1.serviceDuration = [dashboardObject.endDate minutesFrom:dashboardObject.startDate];
    appt1.serviceStatus = 2; //mark as scheduled
    
    return appt1;
}

/// create calendar UI with booked appointements
//- (void)populateCalendarWithDashObjects:(NSArray *)dashboardItems {
//    
//    [self.tableDataSource removeAllObjects];
//    
//    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"hh a";
//    
//    for (int hoursIncrement = 0; hoursIncrement < 24; hoursIncrement++) {
//        
//        NSDate *hour = [todayDate dateByAddingHours:hoursIncrement];
//        
//        Today *today = [Today new];
//        today.appointmentsHour = [dateFormatter stringFromDate:hour];
//        today.appointmentsArray = @[];
//        
//        for (Dashboard *dashObj in dashboardItems) {
//            
//            // if the startDate is today
//            if ([dashObj.startDate daysFrom:todayDate] == 0 &&
//                [dashObj.startDate hoursFrom:hour] == 0) {
//                
//                //                NSLog(@"\n \n Booking with ID: %@", dashObj.bookingId);
//                //                NSLog(@"Hour: %@", hour);
//                //                NSLog(@"today.appointmentsHour: %@", today.appointmentsHour);
//                //                NSLog(@"dashObj.fName: %@ - dashObj.lName: %@", dashObj.fName, dashObj.lName);
//                //                NSLog(@"Starts on date: %@ \n \n", dashObj.startDate);
//                
//                today.appointmentsArray = @[[self convertToAppointementObject:dashObj]];
//            }
//        }
//        
//        [self.tableDataSource addObject:today];
//    }
//    
//}

/// create calendar UI with booked appointements
- (void)populateCalendarWithDashObjects:(NSArray *)dashboardItems forDate:(NSDate *)date {
    
    [self.tableDataSource removeAllObjects];
    
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh a";
    
    for (int hoursIncrement = 0; hoursIncrement < 24; hoursIncrement++) {
        
        NSDate *hour = [todayDate dateByAddingHours:hoursIncrement];
        
        Today *today = [Today new];
        today.appointmentsHour = [dateFormatter stringFromDate:hour];
        today.appointmentsArray = @[];
        
        for (Dashboard *dashObj in dashboardItems) {
            
            // if the startDate is today
            if ([dashObj.startDate daysFrom:todayDate] == 0 &&
                [dashObj.startDate hoursFrom:hour] == 0) {
                
                NSLog(@"\n \n Booking with ID: %@", dashObj.bookingId);
                NSLog(@"Hour: %@", hour);
                NSLog(@"today.appointmentsHour: %@", today.appointmentsHour);
                NSLog(@"dashObj.fName: %@ - dashObj.lName: %@", dashObj.fName, dashObj.lName);
                NSLog(@"Starts on date: %@ \n \n", dashObj.startDate);
                
                today.appointmentsArray = @[[self convertToAppointementObject:dashObj]];
            }
        }
        
        [self.tableDataSource addObject:today];
    }
}

@end
