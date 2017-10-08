//
//  EKResetPhoneNumberViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/8/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKResetPhoneNumberViewController.h"

static NSString * const kResetCell = @"resetCell";
static NSString * const kExploreSegue = @"resetPassToExploreVC";
static NSString * const kDashboardSegue = @"resetPassToDashboardVC";

@interface EKResetPhoneNumberViewController () {
    NSArray *_dataSourceArray;
}
@end

@implementation EKResetPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Reset password";
    
    _dataSourceArray = @[
                         @{@"Confirmation code" : @"confirmation code"},
                         @{@"New password" : @"password"},
                         ];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResetCell forIndexPath:indexPath];
    
    cell.cellTitleLabel.text = labelValue;
    cell.cellTextField.placeholder = placeHolderValue;
    
    if (indexPath.row == 0) {
        cell.cellTextField.text = @"abc123";
    }
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Actions

- (IBAction)didTapResetButton:(id)sender {
    
    EKTextFieldTableViewCell *codeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EKTextFieldTableViewCell *passCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    NSString *confirmationCodeStr = codeCell.cellTextField.text;
    NSString *passwordStr = passCell.cellTextField.text;
    
    if (confirmationCodeStr.length > 0 && passwordStr.length > 0) {
        
        if (self.signInRole == ResetRoleCustomer) {
            
            [self performSegueWithIdentifier:kExploreSegue sender:nil];
            
        } else if (self.signInRole == ResetRoleBP) {
            
            [self performSegueWithIdentifier:kDashboardSegue sender:nil];
            
        } else if (self.signInRole == ResetRoleSalon) {
            
            [self performSegueWithIdentifier:kDashboardSegue sender:nil];
        }
        
    } else {
        
        [self showMessage:@"Please enter a valid phone number in the following format (area code-number), before proceeding"
                withTitle:@"Warning" completionBlock:nil];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kExploreSegue]) {
     
        if (sender) {
            
            Customer *customerObj = (Customer *)sender;
            
            [EKSettings saveCustomer:customerObj];
            
            UINavigationController *navController = [segue destinationViewController];
            EKExploreViewController *vc = (EKExploreViewController *)([navController viewControllers][0]);
            vc.passedCustomer = customerObj;
        }
    }
    
    if ([segue.identifier isEqualToString:kDashboardSegue]) {
        
    }
}

@end
