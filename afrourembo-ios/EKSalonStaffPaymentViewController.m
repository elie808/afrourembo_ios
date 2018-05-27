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
    
    NSDate *_selectedDate;
    NSDate *_startDate;
    NSDate *_endDate;
    
    NSMutableArray<StaffPayment*> *_dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init
    _dataSource = [NSMutableArray new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKSalonStaffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    
    StaffPayment *obj = [_dataSource objectAtIndex:indexPath.row];
    
    [cell configureWith:obj];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - EKDatePickerDelegate

- (void)didPickDate:(NSDate *)date {

    if (_selectedLabel) {
        _selectedLabel.text = [NSDate stringFromDate:date withFormat:DateFormatLetterDayMonthYear];
    
        if (_selectedLabel == self.startDateLabel) {
            
            if (!_startDate) { _startDate = [NSDate new]; }
            _startDate = date;
        }
        
        if (_selectedLabel == self.endDateLabel) {
            if (!_endDate) { _endDate = [NSDate new]; }
            _endDate = date;
        }
    }
}

#pragma mark - Actions

- (IBAction)unwindToStaffPaymentVC:(UIStoryboardSegue *)segue {}

- (IBAction)didTapUpdate:(UIButton *)sender {
    
    NSString *fromDate;
    NSString *toDate;
    
    if (_startDate && _endDate) {
        
        fromDate = [NSString stringWithFormat:@"%f", [_startDate timeIntervalSince1970]];
        toDate = [NSString stringWithFormat:@"%f", [_endDate timeIntervalSince1970]];
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [StaffPayment getStaffPaymentDetailsFrom:fromDate
                                          to:toDate
                                    forSalon:[EKSettings getSavedSalon].token
                                   withBlock:^(NSArray<StaffPayment *> *staffPaymentArray) {
                                       
                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                       [_dataSource removeAllObjects];
                                       [_dataSource addObjectsFromArray:staffPaymentArray];
                                       [self.tableView reloadData];
                                       
                                   } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                       
                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                       [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                   }];
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
