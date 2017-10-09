//
//  EKConfirmPhoneNumberViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKConfirmPhoneNumberViewController.h"

static NSString * const kPhoneCell = @"phoneCell";
static NSString * const kResetPassSegue = @"confirmPhoneNumberToResetPasswordVC";

@interface EKConfirmPhoneNumberViewController() {
    NSArray *_dataSourceArray;
}
@end

@implementation EKConfirmPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Confirm phone number";
    
    _dataSourceArray = @[
                         @{@"Phone number" : @"00 12345678"},
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
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPhoneCell forIndexPath:indexPath];
    
    cell.cellTitleLabel.text = labelValue;
    cell.cellTextField.placeholder = placeHolderValue;

    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Action

- (IBAction)didTapConfirmButton:(id)sender {
    
    EKTextFieldTableViewCell *phoneCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSString *phoneNumbr = phoneCell.cellTextField.text;
    NSString *phoneStr = [self trimWhiteSpace:phoneNumbr];
    
    if (phoneStr.length > 0 && [self isValidPhoneNumber:phoneStr]) {
    
        [self confirmPhoneNumber:phoneStr];
    
    } else {
        
        [self showMessage:@"Please enter a valid phone number in the following format (area code-number), before proceeding"
                withTitle:@"Warning" completionBlock:nil];
    }
}

#pragma mark - Helpers

- (NSString *)trimWhiteSpace:(NSString *)text {
    return [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isValidPhoneNumber:(NSString *)phoneNumber {
    
    // Check if 53/54/56 exist as 1 piece
    // then check that the remaining 7 numbers range from 0-9
    // OR all conditions together using |
    
    // NSString *phoneRegex = @"(53){1}[0-9]{7}|(54){1}[0-9]{7}|(56){1}[0-9]{7}";
    
    NSString *phoneRegex = @"[0-9]{10}";
    
    NSPredicate *testPhoneEN = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [testPhoneEN evaluateWithObject:phoneNumber];
}

- (void)confirmPhoneNumber:(NSString *)phoneNumber {
    
    NSLog(@"PHONE NUMBER: %@", phoneNumber);
    
    if (self.signInRole == PhoneConfirmRoleCustomer) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Customer getResetCodeForPhonenumber:phoneNumber
                                   withBlock:^{
        
                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                       [self performSegueWithIdentifier:kResetPassSegue sender:nil];
                                       
                                   } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                       
                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                       [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                   }];
        
    } else if (self.signInRole == PhoneConfirmRoleBP) {

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ProfessionalLogin getResetCodeForPhonenumber:phoneNumber
                                            withBlock:^{
                                       
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                [self performSegueWithIdentifier:kResetPassSegue sender:nil];
                                       
                                            } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                       
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                            }];
        
    } else if (self.signInRole == PhoneConfirmRoleSalon) {

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [SalonLogin getResetCodeForPhonenumber:phoneNumber
                                     withBlock:^{
                                         
                                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                                         [self performSegueWithIdentifier:kResetPassSegue sender:nil];
                                         
                                     } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                        
                                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                                         [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                     }];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kResetPassSegue]) {
        
        EKResetPhoneNumberViewController *vc = segue.destinationViewController;
        vc.signInRole = self.signInRole;
        
        // pass phoneNumber
    }
}

@end
