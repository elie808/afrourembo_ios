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
    
    Appointment *appt1 = [Appointment new];
    appt1.clientName = @"Fannie Ballard";
    appt1.serviceDescription = @"Natural Hair";
    appt1.serviceTime = @"9:00 AM";
    appt1.serviceDuration = @15;
    appt1.serviceStatus = @"done";
    
    _dataSource = [NSMutableArray arrayWithObjects:appt1, appt1, appt1, nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCell forIndexPath:indexPath];
    
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
