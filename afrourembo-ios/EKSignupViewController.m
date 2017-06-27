//
//  EKSignupViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/18/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSignupViewController.h"

static NSString * const kSignUpCell = @"signUpCell";

static NSString * const kEditProfileSegue = @"signUpToEditProfile";

@interface EKSignupViewController() {
    NSArray *_dataSourceArray;
}
@end

@implementation EKSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sign up";
    _dataSourceArray = @[
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
    
    cell.cellIndexPath = indexPath;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Navigation

- (IBAction)didTapSignUpButton:(id)sender {
    
    EKTextFieldTableViewCell *emailCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EKTextFieldTableViewCell *passCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    NSString *emailStr  = emailCell.cellTextField.text;
    NSString *passStr   = passCell.cellTextField.text;
 
    [self signUpEmail:emailStr andPassword:passStr];
}

- (IBAction)didTapFBSignUpButton:(id)sender {
 
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
                                             
                                             NSLog(@"RESULT: %@", [result valueForKey:@"email"]);
                                             
                                             [Customer signUpCustomer:[result valueForKey:@"email"]
                                                             password:[result valueForKey:@"id"]
                                                            withBlock:^(Customer *customerObj) {
                                                                
                                                                NSLog(@"USER SIGNED UP!!");
                                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                
                                                                customerObj.fName = [result valueForKey:@"first_name"];
                                                                customerObj.lName = [result valueForKey:@"last_name"];

                                                                [self performSegueWithIdentifier:kEditProfileSegue sender:customerObj];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kEditProfileSegue]) {
        
        EKEditProfileInfoViewController *vc = segue.destinationViewController;
        Customer *customerObj = (Customer *)sender;
        vc.passedUser = customerObj;
    }
}

#pragma mark - Helpers

- (void)signUpEmail:(NSString *)email andPassword:(NSString *)password {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Customer signUpCustomer:email
                    password:password
                   withBlock:^(Customer *customerObj) {
                       
                       NSLog(@"USER SIGNED UP!!");
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                       [self performSegueWithIdentifier:kEditProfileSegue sender:customerObj];
                   }
                  withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                      
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      [self showMessage:errorMessage
                              withTitle:@"There is something wrong"
                        completionBlock:nil];
                  }];
}

@end
