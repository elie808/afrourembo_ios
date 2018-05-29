//
//  EKSalonStaffPaymentViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKSalonStaffPaymentViewController.h"

static NSString * const kCell = @"staffPaymentCellID";
static NSString * const kEmptyCell = @"emptyCellID";
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
    
    if (_dataSource.count == 0) {

        return [tableView dequeueReusableCellWithIdentifier:kEmptyCell forIndexPath:indexPath];
    
    } else {
     
        EKSalonStaffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
        
        StaffPayment *obj = [_dataSource objectAtIndex:indexPath.row];
        cell.delegate = self;
        cell.indexPath = indexPath;
        
        [cell configureWith:obj];
        
        return cell;
    }
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

#pragma mark - SalonStaffCellDelegate

- (void)didTapCallAtIndex:(NSIndexPath *)index {
    
    StaffPayment *staffObj = [_dataSource objectAtIndex:index.row];
    
    NSString *unspacedPhoneNumber = [staffObj.professional.phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", unspacedPhoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneNumberURL]) {
        
        [[UIApplication sharedApplication] openURL:phoneNumberURL];
        
    } else {
        
    }
}

// it says Email, but using it for SMS. Shruggie.
- (void)didTapEmailAtIndex:(NSIndexPath *)index {
    
    StaffPayment *staffObj = [_dataSource objectAtIndex:index.row];
    
    NSString *unspacedPhoneNumber = [staffObj.professional.phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *messageURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", unspacedPhoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:messageURL]) {
        
        [[UIApplication sharedApplication] openURL:messageURL];
        
    } else {
        
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
                                       
                                       
                                       Professional *pro = [Professional new];
                                       pro.fName = @"Le firster";
                                       pro.lName = @"LastName";
                                       pro.profilePicture = @"http://www.gstatic.com/tv/thumb/persons/1579/1579_v9_ba.jpg";
                                       pro.email = @"tel7as@mail.com";
                                       pro.phone = @"+96106777999";
                                       
                                       StaffPayment *stafObj = [StaffPayment new];
                                       stafObj.price = 1000;
                                       stafObj.currency = @"KES";
                                       stafObj.professional = pro;
                                       
                                       [_dataSource addObject:stafObj];
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
