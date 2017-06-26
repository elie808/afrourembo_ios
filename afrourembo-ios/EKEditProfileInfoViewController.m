//
//  EKEditProfileInfoViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/24/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKEditProfileInfoViewController.h"

static NSString * const keditProfileInfoCell = @"editProfileInfoCell";
static NSString * const kExploreSegue = @"editVcToExploreVC";

@interface EKEditProfileInfoViewController () {
    NSArray *_dataSourceArray;
} @end

@implementation EKEditProfileInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Profile information";
    
    _dataSourceArray = @[
                         @{@"First name" : self.passedUser.fName.length > 0 ? self.passedUser.fName : @"Your name"},
                         @{@"Last name" : self.passedUser.lName.length > 0 ? self.passedUser.lName : @"Your last name"},
                         @{@"Phone number" : @"(___) ___ - ___"}
                         ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:keditProfileInfoCell forIndexPath:indexPath];
    
    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    cell.cellTitleLabel.text = labelValue;
    
    if (indexPath.row == 0 && self.passedUser.fName.length > 0) {
        cell.cellTextField.text = placeHolderValue;
    } else {
        cell.cellTextField.placeholder = placeHolderValue;
    }
    
    if (indexPath.row == 1 && self.passedUser.lName.length > 0) {
        cell.cellTextField.text = placeHolderValue;
    } else {
        cell.cellTextField.placeholder = placeHolderValue;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Actions

- (IBAction)didTapSubmitButton:(id)sender {

    EKTextFieldTableViewCell *fNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EKTextFieldTableViewCell *lNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    EKTextFieldTableViewCell *phoneCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    NSString *fNameStr  = fNameCell.cellTextField.text;
    NSString *lNameStr   = lNameCell.cellTextField.text;
    NSString *phoneStr   = phoneCell.cellTextField.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Customer updateInterests:fNameStr
                     lastName:lNameStr
                        phone:phoneStr
                      forUser:self.passedUser.token
                    withBlock:^(Customer *customerObj) {
                     
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [self performSegueWithIdentifier:kExploreSegue sender:nil];
                    }
                   withErrors:^(NSError *error, NSString *errorMessage) {
                       
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                       [self showMessage:errorMessage
                               withTitle:@"There is something wrong"
                         completionBlock:nil];
                   }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kExploreSegue]) {
        
    }
}

@end
