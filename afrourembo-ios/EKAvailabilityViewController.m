//
//  EKAvailabilityViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/3/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKAvailabilityViewController.h"

static NSString * const kVendorDashSegue = @"availabilityVcToVendorDashboard";

static NSString * const kSwitchCell = @"availabilitySwitchCell";
static NSString * const kTimeCell   = @"availabilityTimeCell";

@implementation EKAvailabilityViewController {
    NSMutableArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Availability";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                              target:self action:@selector(didTapDoneButton)];
    
    _dataSourceArray = [NSMutableArray arrayWithArray:[self createDataSource]];
}

- (NSArray *)createDataSource {
    
    Day *monday     = [Day defaultModelForDay:@"Monday"];
    Day *tuesday    = [Day defaultModelForDay:@"Tuesday"];
    Day *wednesday  = [Day defaultModelForDay:@"Wednesday"];
    Day *thursday   = [Day defaultModelForDay:@"Thursday"];
    Day *friday     = [Day defaultModelForDay:@"Friday"];
    Day *saturday   = [Day defaultModelForDay:@"Saturday"];
    Day *sunday     = [Day defaultModelForDay:@"Sunday"];
    
    return @[monday, tuesday, wednesday, thursday, friday, saturday, sunday];
}

#pragma mark - UITableViewDataSource

// return a plain uiview as a footer in-between section groups, to easily adjust height later
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

// set the size in-between section groups
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Day *dayModel = [_dataSourceArray objectAtIndex:section];
    
    if (dayModel.daySelected && !dayModel.lunchBreakSelected) {

        return 3;

    } else if (dayModel.daySelected && dayModel.lunchBreakSelected) {

        return 4;

    } else {

        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Day *dayModel = [_dataSourceArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        
        EKSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSwitchCell forIndexPath:indexPath];
        
        cell.delegate = self;
        [cell configureCellForDay:dayModel forIndex:indexPath];
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        EKDualButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeCell forIndexPath:indexPath];
        
        cell.delegate = self;
        cell.cellIndexPath = indexPath;
        [cell.leftButton setTitle:dayModel.serviceStartDate forState:UIControlStateNormal];
        [cell.rightButton setTitle:dayModel.serviceEndDate forState:UIControlStateNormal];
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        
        EKSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSwitchCell forIndexPath:indexPath];

        cell.delegate = self;
        [cell configureLunchCellForDay:dayModel forIndex:indexPath];

        return cell;
    }
    
    if (indexPath.row == 3) {
        
        EKDualButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeCell forIndexPath:indexPath];
        
        cell.delegate = self;
        cell.cellIndexPath = indexPath;
        [cell.leftButton setTitle:dayModel.lunchStartDate forState:UIControlStateNormal];
        [cell.rightButton setTitle:dayModel.lunchEndDate forState:UIControlStateNormal];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - EKSwitchCellDelegate

- (void)didChangeSwitchValue:(BOOL)switchValue atIndex:(NSIndexPath *)indexPath {

    Day *dayModel = [_dataSourceArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        
        dayModel.daySelected = switchValue;
        
        if (!switchValue) { [dayModel resetModel]; }
    }
    
    if (indexPath.row == 2) { dayModel.lunchBreakSelected = switchValue; }
    
    [self.tableView reloadData];
}

#pragma mark - EKDualButtonCellDelegate

- (void)didTapLeftButtonAtIndexPath:(NSIndexPath *)indexPath {
    
    Day *dayModel = [_dataSourceArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 1) {
        dayModel.serviceStartDate = @"YAS";
    }
    
    if (indexPath.row == 3) {
        dayModel.lunchStartDate = @"YAS-L";
    }
    
    [self.tableView reloadData];
}

- (void)didTapRightButtonAtIndexPath:(NSIndexPath *)indexPath {
    
    Day *dayModel = [_dataSourceArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 1) {
        dayModel.serviceEndDate = @"NAY";
    }
    
    if (indexPath.row == 3) {
        dayModel.lunchEndDate = @"NAY-L";
    }
    
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)didTapDoneButton {
    [self performSegueWithIdentifier:kVendorDashSegue sender:nil];
}

#pragma mark - Helpers

- (void)addRowAtIndexPath:(NSIndexPath*)indexPath {
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}

- (void)removeRowAtIndexPath:(NSIndexPath*)indexPath {
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
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
