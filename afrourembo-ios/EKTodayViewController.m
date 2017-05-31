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

- (NSArray *)createAppointmentStubs {
    
    Appointment *appt1 = [Appointment new];
    appt1.clientName = @"Fannie Ballard";
    appt1.serviceDescription = @"Natural Hair";
    appt1.serviceTime = @"9:00 AM";
    appt1.serviceDuration = 15;
    appt1.serviceStatus = 0;
    
    Appointment *appt2 = [Appointment new];
    appt2.clientName = @"Victoria Barker";
    appt2.serviceDescription = @"Extension & Weave";
    appt2.serviceTime = @"1:00 PM";
    appt2.serviceDuration = 30;
    appt2.serviceStatus = 1;
    
    Appointment *appt3 = [Appointment new];
    appt3.clientName = @"Violet Kelly";
    appt3.serviceDescription = @"Natural Hair";
    appt3.serviceTime = @"6:00 PM";
    appt3.serviceDuration = 45;
    appt3.serviceStatus = 0;
    
    Appointment *appt4 = [Appointment new];
    appt4.clientName = @"Corey Barret";
    appt4.serviceDescription = @"Some Other Service";
    appt4.serviceTime = @"5:00 PM";
    appt4.serviceDuration = 10;
    appt4.serviceStatus = 2;
    
    return @[appt1, appt2, appt3, appt4, appt2];
}

- (NSArray *)createStubs {
    
    Today *today = [Today new];
    today.appointmentsHour = @"10:00 AM";
    today.appointmentsArray = [self createAppointmentStubs];
    
    Today *today1 = [Today new];
    today1.appointmentsHour = @"11:00 AM";
    today1.appointmentsArray = [self createAppointmentStubs];
    
    Today *today2 = [Today new];
    today2.appointmentsHour = @"12:00 PM";
    today2.appointmentsArray = [self createAppointmentStubs];
    
    Today *today3 = [Today new];
    today3.appointmentsHour = @"01:00 PM";
    today3.appointmentsArray = [self createAppointmentStubs];
    
    Today *today4 = [Today new];
    today4.appointmentsHour = @"02:00 PM";
    today4.appointmentsArray = [self createAppointmentStubs];
    
    return @[today, today1, today2, today3, today4];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentOffsetDictionary = [NSMutableDictionary new];
    _dataSource = [NSMutableArray arrayWithArray:[self createStubs]];
    
    //TODO: abstract to NSDate categories
    NSDate *date = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEEE - MMMM dd, YYYY";
    
    self.dateLabel.text = [[dateFormatter stringFromDate:date] capitalizedString];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
