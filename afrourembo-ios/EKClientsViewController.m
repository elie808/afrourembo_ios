//
//  EKClientsViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKClientsViewController.h"

static NSString * const kClientListCell = @"settingsClientsTableCell";

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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Professional getClients:[EKSettings getSavedVendor].token
                   withBlock:^(NSArray<Customer *> *customersArray) {
    
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                       if (customersArray.count == 0) {
                           
                           self.emptyDataView.hidden = YES;
                           
                           _dataSourceArray = [NSMutableArray arrayWithArray:customersArray];
                       }
                       
                       [self.tableView reloadData];

                   } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                       
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                       [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                  }];
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
//    [cell.cellImageView yy_setImageWithURL:[NSURL URLWithString:customerObj.pr]
//                                   options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    cell.cellImageView.image = [UIImage imageNamed:@"icPlaceholder"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
