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
    
    NSNumberFormatter *_numberFormatter;
    NSDateFormatter *_completeDateFormatter;
    NSDateFormatter *_hoursDateFormatter;
    NSDateFormatter *_minutesDateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Availability";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                                                             target:self action:@selector(didTapDoneButton)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
    
    [self initializeDataFormatters];
    _dataSourceArray = [NSMutableArray arrayWithArray:[self createDataSource]];
    
    self.datePickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kDatePickerHeight);
    [self.view addSubview:self.datePickerView];
    self.datePickerView.hidden = YES;
}

- (void)initializeDataFormatters {
    
    _numberFormatter = [[NSNumberFormatter alloc] init];
    _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    _completeDateFormatter = [[NSDateFormatter alloc] init];
    _completeDateFormatter.dateFormat = @"HH:mm";
    
    _hoursDateFormatter = [[NSDateFormatter alloc] init];
    _hoursDateFormatter.dateFormat = @"HH";
    
    _minutesDateFormatter = [[NSDateFormatter alloc] init];
    _minutesDateFormatter.dateFormat = @"mm";
}

- (NSArray *)createDataSource {
    
    Day *monday     = [Day defaultModelForDay:@0];
    Day *tuesday    = [Day defaultModelForDay:@1];
    Day *wednesday  = [Day defaultModelForDay:@2];
    Day *thursday   = [Day defaultModelForDay:@3];
    Day *friday     = [Day defaultModelForDay:@4];
    Day *saturday   = [Day defaultModelForDay:@5];
    Day *sunday     = [Day defaultModelForDay:@6];
    
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
    
    // check which side of the cell is the selected button on
    // perform the update at the corresponding data model indexPath
    if (_leftSideSelected && !_rightSideSelected) {
        [self updateStartDate:[sender date] atIndexPath:_selectedIndexPath];
    }
    
    if (!_leftSideSelected && _rightSideSelected) {
        [self updateEndDate:[sender date] atIndexPath:_selectedIndexPath];
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

- (void)updateStartDate:(NSDate *)date atIndexPath:(NSIndexPath *)indexPath {
    
    //convert NSDate to NSString with a complete, hours and minutes versions
    NSString *hoursDateString = [[_hoursDateFormatter stringFromDate:date] capitalizedString];
    NSString *minutesDateString = [[_minutesDateFormatter stringFromDate:date] capitalizedString];
    NSString *completeDateString = [[_completeDateFormatter stringFromDate:date] capitalizedString];
    
    Day *dayModel = [_dataSourceArray objectAtIndex:indexPath.section];
    
    //service start date
    if (indexPath.row == 1) {
        dayModel.serviceStartDate = completeDateString;
        dayModel.fromHours      = [_numberFormatter numberFromString:hoursDateString];
        dayModel.fromMinutes    = [_numberFormatter numberFromString:minutesDateString];
    }
    
    //lunch start date
    if (indexPath.row == 3) {
        dayModel.lunchStartDate = completeDateString;
        dayModel.lbFromHours    = [_numberFormatter numberFromString:hoursDateString];
        dayModel.lbFromMinutes  = [_numberFormatter numberFromString:minutesDateString];
    }
    
    [self.tableView reloadData];
}

- (void)updateEndDate:(NSDate *)date atIndexPath:(NSIndexPath *)indexPath {
    
    //convert NSDate to NSString with a complete, hours and minutes versions
    NSString *hoursDateString   = [[_hoursDateFormatter stringFromDate:date] capitalizedString];
    NSString *minutesDateString = [[_minutesDateFormatter stringFromDate:date] capitalizedString];
    NSString *completeDateString = [[_completeDateFormatter stringFromDate:date] capitalizedString];
    
    Day *dayModel = [_dataSourceArray objectAtIndex:indexPath.section];
    
    //service end date
    if (indexPath.row == 1) {
        dayModel.serviceEndDate = completeDateString;
        dayModel.toHours    = [_numberFormatter numberFromString:hoursDateString];
        dayModel.toMinutes  = [_numberFormatter numberFromString:minutesDateString];
    }
    
    //lunch end date
    if (indexPath.row == 3) {
        dayModel.lunchEndDate = completeDateString;
        dayModel.lbToHours    = [_numberFormatter numberFromString:hoursDateString];
        dayModel.lbToMinutes  = [_numberFormatter numberFromString:minutesDateString];
    }
    
    [self.tableView reloadData];
}

@end
