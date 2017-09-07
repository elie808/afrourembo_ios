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
    
    if (indexPath.row == 2) {
        cell.cellTextField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    
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
                               [EKSettings saveVendor:professionalObj];
                               
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

- (IBAction)didTapFacebookSignUpButton:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        [login logOut];
        
    } else {
        
        // Login using Facebook account
        [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                     fromViewController:self
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                    
                                    if (error) {
                                        
                                        NSLog(@"Process error");
                                        
                                    } else if (result.isCancelled) {
                                        
                                        NSLog(@"Cancelled");
                                        
                                    } else {
                                        
                                        NSLog(@"Logged in");
                                        NSLog(@"/n /n ~~~~~NAME: %@", [FBSDKProfile currentProfile].name);
                                        
                                        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                        
                                        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                                        [parameters setValue:@"id,name,email,first_name,last_name" forKey:@"fields"];
                                        
                                        // Query Facebook graph to get user's email, and use userID as password to signup
                                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                                           parameters:parameters]
                                         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                             
                                             [Professional signUpProfessional:[result valueForKey:@"email"]
                                                                     password:[result valueForKey:@"id"]
                                                                    firstName:[result valueForKey:@"first_name"]
                                                                     lastName:[result valueForKey:@"last_name"]
                                                                    withBlock:^(Professional *professionalObj) {
                                                                        
                                                                        NSLog(@"PROFESSIONAL SIGNED UP!!");
                                                                        
                                                                        [EKSettings saveVendor:professionalObj];
                                                                        
                                                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                        
                                                                        professionalObj.fName = [result valueForKey:@"first_name"];
                                                                        professionalObj.lName = [result valueForKey:@"last_name"];
                                                                        
                                                                        [self performSegueWithIdentifier:kRoleSegue sender:professionalObj];
                                                                    }
                                                                   withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                                       
                                                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                       [self showMessage:errorMessage
                                                                               withTitle:@"There is something wrong"
                                                                         completionBlock:nil];
                                                                   }];
                                         }];
                                    }
                                }];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kRoleSegue]) {
        
        EKRoleViewController *vc = segue.destinationViewController;
        Professional *profObj = (Professional *)sender;
        vc.passedProfessional = profObj;
    }
}

@end
