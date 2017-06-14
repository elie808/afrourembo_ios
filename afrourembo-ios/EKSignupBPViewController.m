//
//  EKSignupBPViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSignupBPViewController.h"

static NSString * const kSignUpCell = @"signUpBPCell";

static NSString * const kRoleSegue = @"signupBPToRoleVC";

@interface EKSignupBPViewController () {
    NSArray *_dataSourceArray;
} @end

@implementation EKSignupBPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sign up";
    _dataSourceArray = @[
                         @{@"First name" : @"Your name"},
                         @{@"Last name" : @"Your last name"},
                         @{@"Email" : @"address@mail.com"},
                         @{@"Password" : @"Your password"}
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
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSignUpCell forIndexPath:indexPath];
    
    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    cell.cellTitleLabel.text = labelValue;
    cell.cellTextField.placeholder = placeHolderValue;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Actions

- (IBAction)didTapSignUpButton:(id)sender {
    
    EKTextFieldTableViewCell *fNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EKTextFieldTableViewCell *lNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    EKTextFieldTableViewCell *emailCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    EKTextFieldTableViewCell *passCell  = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    NSString *fNameStr = fNameCell.cellTextField.text;
    NSString *lNameStr = lNameCell.cellTextField.text;
    NSString *emailStr = emailCell.cellTextField.text;
    NSString *passStr  = passCell.cellTextField.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Professional signUpProfessional:emailStr
                            password:passStr
                           firstName:fNameStr
                            lastName:lNameStr
                           withBlock:^(Professional *professionalObj) {

                               NSLog(@"PROFESSIONAL SIGNED UP!!");
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               [self performSegueWithIdentifier:kRoleSegue sender:professionalObj];
                           }
                          withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {

                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              [self showMessage:errorMessage
                                      withTitle:@"There is something wrong"
                                completionBlock:nil];
                          }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kRoleSegue]) {
        
        Professional *profObj = (Professional *)sender;
    }
}

@end
