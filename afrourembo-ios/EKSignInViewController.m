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
    _dataSourceArray = @[@"Email", @"Password"];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSigninCell forIndexPath:indexPath];
    
    cell.cellTitleLabel.text = _dataSourceArray[indexPath.row];;
    cell.cellTextField.placeholder = @"address@mail";
    
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
    
    if (self.signInRole == SignInRoleCustomer) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Customer loginCustomer:emailStr
                       password:passStr
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
        
//        [self performSegueWithIdentifier:kExploreSegue sender:nil];
        
    } else {
     
        [self performSegueWithIdentifier:kBPDashSegue sender:nil];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kExploreSegue]) {

        Customer *customerObj = (Customer *)sender;
        UINavigationController *navController = [segue destinationViewController];
        EKExploreViewController *vc = (EKExploreViewController *)([navController viewControllers][0]);
        vc.passedCustomer = customerObj;
    }
    
    if ([segue.identifier isEqualToString:kBPDashSegue]) {
        
    }
}

@end
