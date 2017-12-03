//
//  EKSalonManageStaffViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 12/2/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalonManageStaffViewController.h"

static NSString * const kTableCell = @"staffTableCell";

@implementation EKSalonManageStaffViewController {
    NSMutableArray *_tableViewDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableViewDataSource = [NSMutableArray new];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Salon getJoinRequestsForSalon:[EKSettings getSavedSalon].token
                         withBlock:^(NSArray<JoinSalonRequest *> *staffArray) {
    
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [_tableViewDataSource addObjectsFromArray:staffArray];
                             
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
    return _tableViewDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKManageStaffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCell forIndexPath:indexPath];

    JoinSalonRequest *request = [_tableViewDataSource objectAtIndex:indexPath.row];
    
    cell.cellDelegate = self;
    cell.cellIndexPath = indexPath;

    cell.cellProfessionalNameLabel.text = [NSString stringWithFormat:@"%@ %@", request.professional.fName, request.professional.lName];
    cell.cellEmailLabel.text = request.professional.phone;
    [cell.cellImageView yy_setImageWithURL:[NSURL URLWithString:request.professional.profilePicture]
                                   options:YYWebImageOptionProgressive];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58.0;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - EKManageStaffCellDelegate

- (void)acceptStaffAtIndex:(NSIndexPath *)indexPath {
    
    JoinSalonRequest *request = [_tableViewDataSource objectAtIndex:indexPath.row];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Salon acceptJoinRequest:request.joinID
                    forSalon:[EKSettings getSavedSalon].token
                   withBlock:^{
                       
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                       
                       [_tableViewDataSource removeObjectAtIndex:indexPath.row];
                       [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                                     withRowAnimation:UITableViewRowAnimationMiddle];

                   } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                       
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                       [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                  }];
}

- (void)declineStaffAtIndex:(NSIndexPath *)indexPath {
   
    JoinSalonRequest *request = [_tableViewDataSource objectAtIndex:indexPath.row];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Salon declineJoinRequest:request.joinID
                     forSalon:[EKSettings getSavedSalon].token
                    withBlock:^{
                        
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                       
                        [_tableViewDataSource removeObjectAtIndex:indexPath.row];
                        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                                      withRowAnimation:UITableViewRowAnimationMiddle];
                        
                    } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                       
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                   }];
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
