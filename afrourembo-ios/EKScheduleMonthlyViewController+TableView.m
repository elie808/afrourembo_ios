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

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    Today *todayObj = [self.tableDataSource objectAtIndex:index];
    Appointment *aptObj = [todayObj.appointmentsArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kAptDetailsSegue sender:aptObj];
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

/// create calendar UI with booked appointements
- (void)populateCalendarWithDashObjects:(NSArray *)dashboardItems forDate:(NSDate *)date {
    
    [self.tableDataSource removeAllObjects];
    
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh a";
    
    // create a Today object for each hour of the day, and add appointements at the right hours
    for (int hoursIncrement = 0; hoursIncrement < 24; hoursIncrement++) {
        
        NSDate *hour = [todayDate dateByAddingHours:hoursIncrement];
        
        Today *today = [Today new];
        today.appointmentsHour = [dateFormatter stringFromDate:hour];
        today.appointmentsArray = [NSMutableArray new];
        
        // check if any booked appointement is at "hour"
        for (Dashboard *dashObj in dashboardItems) {
            
            // if the startDate is today, and at the same hour as the current iteration of timeOfDay (but earlier than the next iteration)
            if ([dashObj.startDate daysFrom:todayDate] == 0 &&
                ([dashObj.startDate hoursFrom:hour] == 0 ||
                 ([dashObj.startDate hoursFrom:hour] > 0 && [dashObj.startDate hoursFrom:hour] < 1 )
                 )) {
                    
                    [today.appointmentsArray addObject:[Appointment convertToAppointementObject:dashObj]];
            }
        }
        
        [self.tableDataSource addObject:today];
    }
    
    // scroll daily calendar to show the first appointement
    if (self.tableDataSource.count > 0) {
        
        // go through the tableDataSource array and find the first Today obj with a non-empty appointmentsArray
        for (NSUInteger i = 0; i < self.tableDataSource.count; i++) {
            
            Today *todayObj = [self.tableDataSource objectAtIndex:i];
            
            // todayObj has an appointment
            if (todayObj.appointmentsArray.count > 0) {
         
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView scrollToRowAtIndexPath:indexPath
                                      atScrollPosition:UITableViewScrollPositionTop
                                              animated:YES];
                
                i = self.tableDataSource.count;
            }
        }
    }
    
    
}

@end
