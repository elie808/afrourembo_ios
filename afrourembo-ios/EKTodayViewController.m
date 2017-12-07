//
//  EKTodayViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/26/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKTodayViewController.h"

static NSString * const kTableCell = @"todayTableCell";
static NSString * const kCollectionCell = @"todayCell";

@implementation EKTodayViewController {
    NSMutableArray *_dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentOffsetDictionary = [NSMutableDictionary new];
    _dataSource = [NSMutableArray new];
    
    //TODO: abstract to NSDate categories
    NSDate *date = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEEE - MMMM dd, YYYY";

    self.dateLabel.text = [[dateFormatter stringFromDate:date] capitalizedString];
    
    [self createCalendarGrid];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([EKSettings getSavedVendor]) {
     
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Dashboard getDashboardOfVendor:[EKSettings getSavedVendor].token
                              withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                  
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self populateCalendarWithDashObjects:dashboardItems];
                                  [self.tableView reloadData];
                                  
                              } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                  
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                              }];
        
    } else if ([EKSettings getSavedSalon]) {
        
        [Dashboard getDashboardOfSalon:[EKSettings getSavedSalon].token
                             withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                 
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 [self populateCalendarWithDashObjects:dashboardItems];
                                 [self.tableView reloadData];
                                 
                             } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                 
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                             }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCell forIndexPath:indexPath];
    
    // when time slot falls within time of the day
    if (indexPath.row == 2) {
//            cell.backgroundColor = [UIColor colorWithRed:255./255. green:195./255. blue:0 alpha:1.0];
        // make font bold
        // make text color white
        // abstract into config cell method
    }
    
    Today *todayObj = [_dataSource objectAtIndex:indexPath.row];
    
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
    Today *todayObj = [_dataSource objectAtIndex:index];
    
    return todayObj.appointmentsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    Today *todayObj = [_dataSource objectAtIndex:index];
    Appointment *aptObj = [todayObj.appointmentsArray objectAtIndex:indexPath.row];
    
    EKTodayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCell forIndexPath:indexPath];
    
    [cell configureCellForAppointment:aptObj];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - Helpers

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

/// create empty calendar UI
- (void)createCalendarGrid {
    
    [_dataSource removeAllObjects];
    
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh a";
    
    for (int hoursIncrement = 0; hoursIncrement < 24; hoursIncrement++) {
        
        NSDate *hour = [todayDate dateByAddingHours:hoursIncrement];
        
        Today *today = [Today new];
        today.appointmentsHour = [dateFormatter stringFromDate:hour];
        today.appointmentsArray = @[];
        
        [_dataSource addObject:today];
    }
}

/// create calendar UI with booked appointements
- (void)populateCalendarWithDashObjects:(NSArray *)dashboardItems {
    
    [_dataSource removeAllObjects];
    
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    
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
                
//                NSLog(@"\n \n Booking with ID: %@", dashObj.bookingId);
//                NSLog(@"Hour: %@", hour);
//                NSLog(@"today.appointmentsHour: %@", today.appointmentsHour);
//                NSLog(@"dashObj.fName: %@ - dashObj.lName: %@", dashObj.fName, dashObj.lName);
//                NSLog(@"Starts on date: %@ \n \n", dashObj.startDate);
                
                today.appointmentsArray = @[[self convertToAppointementObject:dashObj]];
            }
        }
        
        [_dataSource addObject:today];
    }
}

@end
