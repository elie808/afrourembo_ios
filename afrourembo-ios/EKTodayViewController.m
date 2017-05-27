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

- (NSArray *)createStubs {
    
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
    appt3.clientName = @"Fannie Ballard";
    appt3.serviceDescription = @"Natural Hair";
    appt3.serviceTime = @"6:00 PM";
    appt3.serviceDuration = 45;
    appt3.serviceStatus = 2;
    
    Appointment *appt4 = [Appointment new];
    appt4.clientName = @"Corey Barret";
    appt4.serviceDescription = @"Some Other Service";
    appt4.serviceTime = @"5:00 PM";
    appt4.serviceDuration = 10;
    appt4.serviceStatus = 1;
    
    return @[appt1, appt2, appt3, appt4];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataSource = [NSMutableArray arrayWithArray:[self createStubs]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCell forIndexPath:indexPath];
    
    cell.cellHourOfTheDayLabel.text = @"12:34 PM";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Appointment *aptObj = [_dataSource objectAtIndex:indexPath.row];
    
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
