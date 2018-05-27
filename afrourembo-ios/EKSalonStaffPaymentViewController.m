//
//  EKSalonStaffPaymentViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKSalonStaffPaymentViewController.h"

static NSString * const kCell = @"staffPaymentCellID";
static NSString * const datePickerSegue = @"staffPaymentToDatePickerVC";

@implementation EKSalonStaffPaymentViewController {
    UILabel *_selectedLabel;
//    NSDate *startDate;
//    NSDate *endDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - EKDatePickerDelegate

- (void)didPickDate:(NSDate *)date {

    if (_selectedLabel) {
        _selectedLabel.text = [NSDate stringFromDate:date withFormat:DateFormatLetterDayMonthYearAbbreviated];
    }
}

#pragma mark - Actions

- (IBAction)unwindToStaffPaymentVC:(UIStoryboardSegue *)segue {}

- (IBAction)didTapUpdate:(UIButton *)sender {
}

- (IBAction)didTapStartDate:(UITapGestureRecognizer *)sender {
    
    _selectedLabel = self.startDateLabel;
    [self performSegueWithIdentifier:datePickerSegue sender:nil];
}

- (IBAction)didTapEndDate:(UITapGestureRecognizer *)sender {
    
    _selectedLabel = self.endDateLabel;
    [self performSegueWithIdentifier:datePickerSegue sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:datePickerSegue]) {
        EKDatePickerViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

@end
