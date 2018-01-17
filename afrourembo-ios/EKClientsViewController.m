//
//  EKClientsViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKClientsViewController.h"

static NSString * const kClientListCell = @"settingsClientsTableCell";
static NSString * const kClientsDetailSegue = @"clientsListToClientsDetailsVC";

@implementation EKClientsViewController {
    NSMutableArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSourceArray = [NSMutableArray new];
    
    self.emptyDataView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y,
                                          self.tableView.frame.size.width, self.tableView.frame.size.height);
    self.emptyDataView.hidden = NO;
    [self.view addSubview:self.emptyDataView];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([EKSettings getSavedVendor]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Professional getClientsForProfessional:[EKSettings getSavedVendor].token
                                      withBlock:^(NSArray<Customer *> *customersArray) {
                                          
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          [self configureWithDashboardItems:customersArray];
                                          
                                      } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                      }];
        
    } else if ([EKSettings getSavedSalon]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Professional getClientsForSalon:[EKSettings getSavedSalon].token
                               withBlock:^(NSArray<Customer *> *customersArray) {
                                   
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   [self configureWithDashboardItems:customersArray];
                                   
                               } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                               }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Customer *customerObj = _dataSourceArray[indexPath.row];
    
    EKClientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kClientListCell forIndexPath:indexPath];

    cell.cellTitleLabel.text = [NSString stringWithFormat:@"%@ %@", customerObj.fName, customerObj.lName];
    
//    [cell.cellImageView yy_setImageWithURL:[NSURL URLWithString:customerObj.profilePicture]
//                                   options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    [cell.cellImageView yy_setImageWithURL:[NSURL URLWithString:customerObj.profilePicture]
                               placeholder:[UIImage imageNamed:@"icPlaceholder"]
                                   options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation
                                completion:nil];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    Customer *customerObj = _dataSourceArray[indexPath.row];
    
    [self performSegueWithIdentifier:kClientsDetailSegue sender:customerObj];
}

#pragma mark - Helpers

- (void)configureWithDashboardItems:(NSArray<Customer *> *)customersArray {
    
    if (customersArray && customersArray.count > 0) {
        
        self.emptyDataView.hidden = YES;
        _dataSourceArray = [NSMutableArray arrayWithArray:customersArray];
        
    } else {
        
        self.emptyDataView.hidden = NO;
    }
    
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kClientsDetailSegue]) {
        
        EKClientDetailsViewController *vc = segue.destinationViewController;
        vc.passedCustomer = (Customer *)sender;
    }
}

@end
