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
                         @{@"Phone number" : @"00 12345678"},
                         @{@"New password" : @"password"},
                         ];
    
    NSLog(@"\n \n \n \n PHON NUMEBR : %@", self.passedPhoneNumber);
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
    
//    if (indexPath.row == 0) { cell.cellTextField.text = @"0012345678"; }//self.passedPhoneNumber; }
    if (indexPath.row == 1) { cell.cellTextField.text = @"abc123"; }
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Actions

- (IBAction)didTapResetButton:(id)sender {
    
    EKTextFieldTableViewCell *codeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EKTextFieldTableViewCell *phoneCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    EKTextFieldTableViewCell *passCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    NSString *phonenumberStr = phoneCell.cellTextField.text;
    NSString *confirmationCodeStr = codeCell.cellTextField.text;
    NSString *passwordStr = passCell.cellTextField.text;
    
    if (confirmationCodeStr.length > 0 && passwordStr.length > 0 && phonenumberStr.length > 0) {
        
        [self resetPassword:passwordStr forConfirmationCode:confirmationCodeStr andPhoneNumber:phonenumberStr];
        
    } else {
        
        [self showMessage:@"Please enter a valid phone number and a new password, before proceeding"
                withTitle:@"Warning" completionBlock:nil];
    }
}

- (void)resetPassword:(NSString *)newPass forConfirmationCode:(NSString *)confirmationCode andPhoneNumber:(NSString*)phoneNumber{
    
    if (self.signInRole == ResetRoleCustomer) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Customer resetPassword:newPass forPhoneNumber:phoneNumber andConfirmationCode:confirmationCode
                      withBlock:^(Customer *customerObj) {
                          
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          [self performSegueWithIdentifier:kExploreSegue sender:customerObj];
                          
                      } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                         
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                     }];

    } else if (self.signInRole == ResetRoleBP) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Professional resetPassword:newPass forPhoneNumber:phoneNumber andConfirmationCode:confirmationCode
                          withBlock:^(Professional *professionalObj) {
        
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              [self performSegueWithIdentifier:kDashboardSegue sender:nil];
                              
                          } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                          
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                          }];

    } else if (self.signInRole == ResetRoleSalon) {
        
        [self performSegueWithIdentifier:kDashboardSegue sender:nil];
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
