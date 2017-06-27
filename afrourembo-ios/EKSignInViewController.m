//
//  EKSignInViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSignInViewController.h"

static NSString * const kSigninCell = @"signinCell";
static NSString * const kExploreSegue = @"signInToExploreVC";
static NSString * const kBPDashSegue = @"signInToBPDashboardVC";

@interface EKSignInViewController() {
    NSArray *_dataSourceArray;
}
@end

@implementation EKSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sign in";
    
    _dataSourceArray = @[
                         @{@"Email" : @"address@mail.com"},
                         @{@"Password" : @"Your password"}
                         ];
    
    // check if Facebook user logged in
    //    if ([FBSDKAccessToken currentAccessToken]) {
    //    
    //        _dataSourceArray = @[
    //                             @{@"Email" : @"address@mail.com"},
    //                             @{@"Password" : [FBSDKAccessToken currentAccessToken].userID}
    //                             ];
    //    }
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
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSigninCell forIndexPath:indexPath];
    
    cell.cellTitleLabel.text = labelValue;
    cell.cellTextField.placeholder = placeHolderValue;
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Actions

- (IBAction)didTapSignInButton:(id)sender {
    
    EKTextFieldTableViewCell *emailCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EKTextFieldTableViewCell *passCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    NSString *emailStr  = emailCell.cellTextField.text;
    NSString *passStr   = passCell.cellTextField.text;
    
    [self signInEmail:emailStr andPass:passStr];
}

- (IBAction)didTapFacebookSignInButton:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
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
                                    
                                    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                                    [parameters setValue:@"id,name,email,first_name,last_name" forKey:@"fields"];
                                    
                                    // Query Facebook graph to get user's email, and use userID as password to signup
                                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                                       parameters:parameters]
                                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                         
                                         [self signInEmail:[result valueForKey:@"email"] andPass:[result valueForKey:@"id"]];
                                     }];
                                }
                            }];
}

#pragma mark - Helpers

- (void)signInEmail:(NSString *)email andPass:(NSString *)password {
 
    if (self.signInRole == SignInRoleCustomer) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Customer loginCustomer:email
                       password:password
                      withBlock:^(Customer *customerObj) {
                          
                          NSLog(@"USER LOGGED IN!!");
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          [self performSegueWithIdentifier:kExploreSegue sender:customerObj];
                      }
                     withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                         
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [self showMessage:errorMessage
                                 withTitle:@"There is something wrong"
                           completionBlock:nil];
                     }];
        
    } else if (self.signInRole == SignInRoleBP) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ProfessionalLogin loginProfessional:email
                                    password:password
                                   withBlock:^(Professional *professionalObj) {
                                       
                                       NSLog(@"PROFESSIONAL LOGGED IN!!");
                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                       [self performSegueWithIdentifier:kBPDashSegue sender:nil];
                                   }
                                  withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                      
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                      [self showMessage:errorMessage
                                              withTitle:@"There is something wrong"
                                        completionBlock:nil];
                                  }];
        
    } else if (self.signInRole == SignInRoleSalon) {
        
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
    
    if ([segue.identifier isEqualToString:kBPDashSegue]) {
        
    }
}

@end
