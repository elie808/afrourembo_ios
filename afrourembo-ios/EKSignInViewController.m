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
    
    if (self.signInRole == SignInRoleCustomer) {
        
        //    [Customer loginCustomer:@"email@address.com"
        //                   password:@"12345678"
        //                  withBlock:^(Customer *customerObj) {
        //
        //                      [self performSegueWithIdentifier:kExploreSegue sender:nil];
        //                  }
        //                 withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
        //                     
        //                 }];
        
        [self performSegueWithIdentifier:kExploreSegue sender:nil];
        
    } else {
     
        [self performSegueWithIdentifier:kBPDashSegue sender:nil];
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
