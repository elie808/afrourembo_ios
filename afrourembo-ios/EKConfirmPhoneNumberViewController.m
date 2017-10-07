//
//  EKConfirmPhoneNumberViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKConfirmPhoneNumberViewController.h"

static NSString * const kPhoneCell = @"phoneCell";

@interface EKConfirmPhoneNumberViewController() {
    NSArray *_dataSourceArray;
}
@end

@implementation EKConfirmPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sign in";
    
    _dataSourceArray = @[
                         @{@"Phone number" : @"+254 00 00000000"},
                         ];

}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
    
    NSString *phoneStr  = [self trimWhiteSpace:phoneCell.cellTextField.text];
    
    if (phoneStr.length > 0 && [self isValidPhoneNumber:phoneStr]) {
    
        [self confirmPhoneNumber:phoneStr];
    
    } else {
        
        [self showMessage:@"Please enter a valid phone number in the following format (+254-area code-number), before proceeding"
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
    
    NSString *phoneRegex = @"(+254){1}[0-9]{10}";
    
    NSPredicate *testPhoneEN = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [testPhoneEN evaluateWithObject:phoneNumber];
}

- (void)confirmPhoneNumber:(NSString *)phoneNumber {
    
    NSLog(@"PHONE NUMBER: %@", phoneNumber);
    
    if (self.signInRole == SignInRoleCustomer) {
        
    } else if (self.signInRole == SignInRoleBP) {

    } else if (self.signInRole == SignInRoleSalon) {

    }
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
