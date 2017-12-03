//
//  EKSalonManageStaffViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 12/2/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalonManageStaffViewController.h"

static NSString * const kJoinRequestsCell = @"joinRequestCell";
static NSString * const kStaffCell = @"salonStaffCell";
static NSString * const kEmptyCell = @"emptyCell";

@implementation EKSalonManageStaffViewController {
    NSMutableArray *_salonJoinsDataSource;
    NSMutableArray *_salonStaffDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _salonJoinsDataSource = [NSMutableArray new];
    _salonStaffDataSource = [NSMutableArray new];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Salon getCurrentStaffForSalon:[EKSettings getSavedSalon].token
                         withBlock:^(NSArray<Professional *> *staffArray) {
                             
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [_salonStaffDataSource addObjectsFromArray:staffArray];
                             
                             [self.tableView reloadData];
                             
                         } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                             
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                         }];
    
    [Salon getJoinRequestsForSalon:[EKSettings getSavedSalon].token
                         withBlock:^(NSArray<JoinSalonRequest *> *joinRequestsArray) {
    
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [_salonJoinsDataSource addObjectsFromArray:joinRequestsArray];
                             
                             [self.tableView reloadData];
                             
                         } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                            
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                        }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0: return _salonJoinsDataSource.count > 0 ? _salonJoinsDataSource.count : 1 ; break;
        case 1: return _salonStaffDataSource.count > 0 ? _salonStaffDataSource.count : 1; break;
        default: return 0; break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) { // Join Requests
     
        if (_salonJoinsDataSource.count > 0) {
         
            EKManageStaffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJoinRequestsCell forIndexPath:indexPath];

            [cell configureCellWithJoinRequest:(JoinSalonRequest *)[_salonJoinsDataSource objectAtIndex:indexPath.row]
                                   atIndexPath:indexPath withDelegate:self];
            
            return cell;
            
        } else {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEmptyCell forIndexPath:indexPath];
            cell.textLabel.text = @"No joins requests pending ...";
            return cell;
        }
        
    } else if (indexPath.section == 1) { // Salon Staff
        
        if (_salonStaffDataSource.count > 0) {

            EKManageStaffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStaffCell forIndexPath:indexPath];
            
            [cell configureCellWithProfessional:(Professional *)[_salonStaffDataSource objectAtIndex:indexPath.row]
                                    atIndexPath:indexPath withDelegate:self];
            
            return cell;
            
        } else {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEmptyCell forIndexPath:indexPath];
            cell.textLabel.text = @"No staff members available.";
            return cell;
        }

    } else {
        
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
            
        case 0: return @"Join Requests"; break;
            
        case 1: return @"Staff"; break;
            
        default: return @""; break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.contentView.backgroundColor = [UIColor whiteColor];
    header.textLabel.textColor = [UIColor blackColor];
    header.textLabel.font = [UIFont boldSystemFontOfSize:20.];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - EKManageStaffCellDelegate

- (void)acceptStaffAtIndex:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
     
        JoinSalonRequest *request = [_salonJoinsDataSource objectAtIndex:indexPath.row];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Salon acceptJoinRequest:request.joinID
                        forSalon:[EKSettings getSavedSalon].token
                       withBlock:^{
                           
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           
                           [_salonJoinsDataSource removeObjectAtIndex:indexPath.row];
                           [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                                         withRowAnimation:UITableViewRowAnimationMiddle];
                           
                       } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                           
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                       }];
        
    } else if (indexPath.section == 1) {
        
    }
}

- (void)declineStaffAtIndex:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) { // decline Professional's request
        
        JoinSalonRequest *request = [_salonJoinsDataSource objectAtIndex:indexPath.row];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Salon declineJoinRequest:request.joinID
                         forSalon:[EKSettings getSavedSalon].token
                        withBlock:^{
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            
                            [_salonJoinsDataSource removeObjectAtIndex:indexPath.row];
                            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                                          withRowAnimation:UITableViewRowAnimationMiddle];
                            
                        } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                        }];
        
    } else if (indexPath.section == 1) { // remove Professional from staff
        
        Professional *professional = [_salonStaffDataSource objectAtIndex:indexPath.row];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Salon removeFromSalonStaffMember:professional.professionalID
                                 forSalon:[EKSettings getSavedSalon].token
                                withBlock:^(NSArray<Professional *> *staffArray) {
                            
                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                    
                                    [_salonStaffDataSource removeObjectAtIndex:indexPath.row];
                                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                                                  withRowAnimation:UITableViewRowAnimationMiddle];
                                    
                                } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                   
                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                    [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                }];
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
