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

static CGFloat const kDatePickerHeight = 180;

@implementation EKAvailabilityViewController {
    NSMutableArray *_dataSourceArray;
    
    // used for record keeping of time buttons selected, and trigerring the proper delegates...
    NSIndexPath *_selectedIndexPath;
    BOOL _leftSideSelected;
    BOOL _rightSideSelected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Availability";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                                                             target:self action:@selector(didTapDoneButton)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
    
    _dataSourceArray = [NSMutableArray arrayWithArray:[self createDataSource]];
    
    self.datePickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kDatePickerHeight);
    [self.view addSubview:self.datePickerView];
    self.datePickerView.hidden = YES;
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
        [cell configureCellForService:dayModel forIndex:indexPath];
        
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
        [cell configureCellForLunch:dayModel forIndex:indexPath];
        
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
    
    if (indexPath.row == 2) {
    
        dayModel.lunchBreakSelected = switchValue;
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationMiddle];
}

#pragma mark - EKDualButtonCellDelegate

- (void)didTapLeftButtonAtIndexPath:(NSIndexPath *)indexPath {
    
    _leftSideSelected   = YES;
    _rightSideSelected  = NO;
    _selectedIndexPath  = indexPath;
    
    [self showDatePicker];
}

- (void)didTapRightButtonAtIndexPath:(NSIndexPath *)indexPath {
    
    _leftSideSelected   = NO;
    _rightSideSelected  = YES;
    _selectedIndexPath  = indexPath;
    
    [self showDatePicker];
}

#pragma mark - Actions

- (void)didTapDoneButton {
    [self performSegueWithIdentifier:kVendorDashSegue sender:nil];
}

- (IBAction)didChangeDate:(UIDatePicker *)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSString *strDate = [[dateFormatter stringFromDate:[sender date]] capitalizedString];
    
    // check which side of the cell is the selected button on
    // perform the update at the corresponding data model indexPath
    if (_leftSideSelected && !_rightSideSelected) {
        [self updateStartDate:strDate atIndexPath:_selectedIndexPath];
    }
    
    if (!_leftSideSelected && _rightSideSelected) {
        [self updateEndDate:strDate atIndexPath:_selectedIndexPath];
    }
    
    [self hideDatePicker];
}

- (IBAction)didTapCancelDatePicker:(id)sender {

    [self hideDatePicker];
}

- (IBAction)didTapDummyButton:(id)sender {
    
    for (Day *day in _dataSourceArray) {
        
        if (day.daySelected) {
            
        }
    }
}

/*
 day        number
 fromHours  number
 fromMinutes number
 toHours    number
 toMinutes number
 lbFromHours number
 lbFromMinutes number
 lbToHours  number
 lbToMinutes number
  */

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - Helpers

- (void)showDatePicker {
    
    self.datePickerView.hidden = NO;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.datePickerView.frame = CGRectMake(0, self.view.frame.size.height - kDatePickerHeight,
                                                            self.view.frame.size.width, kDatePickerHeight);
    }];
}

- (void)hideDatePicker {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.datePickerView.frame = CGRectMake(0, self.view.frame.size.height,
                                                            self.view.frame.size.width, kDatePickerHeight);
                     }
                     completion:^(BOOL finished) {
                         self.datePickerView.hidden = YES;
                     }];
}

- (void)updateStartDate:(NSString *)date atIndexPath:(NSIndexPath *)indexPath {
    
    Day *dayModel = [_dataSourceArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 1) {
        dayModel.serviceStartDate = date;
    }
    
    if (indexPath.row == 3) {
        dayModel.lunchStartDate = date;
    }
    
    [self.tableView reloadData];
}

- (void)updateEndDate:(NSString *)date atIndexPath:(NSIndexPath *)indexPath {
    
    Day *dayModel = [_dataSourceArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 1) {
        dayModel.serviceEndDate = date;
    }
    
    if (indexPath.row == 3) {
        dayModel.lunchEndDate = date;
    }
    
    [self.tableView reloadData];
}

@end
