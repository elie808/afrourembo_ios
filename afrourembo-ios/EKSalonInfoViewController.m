//
//  EKSalonInfoViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalonInfoViewController.h"

static NSString * const kSalonCell = @"textFieldSalonSignUpCell";
static NSString * const kRoleCell = @"salonRoleSignUpCell";
static NSString * const kAdressCell = @"salonAddressSignUpCell";

static NSString * const kAdressSegue = @"salonInfoToSalonAdressVC";
static NSString * const kRoleSegue = @"salonInfoToRoleVC";
static NSString * const kSalonDashSegue = @"salonInfoToMainVendorDash";

@implementation EKSalonInfoViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.companyName = @"";
    self.role = @"";
    self.address = @"";
    self.addressCoords = CLLocationCoordinate2DMake(0, 0);
    
    [self initializeDataSource];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    if (indexPath.row == 0) {
        
        EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSalonCell forIndexPath:indexPath];
        cell.cellTitleLabel.text = labelValue;
        cell.cellTextField.text = placeHolderValue;
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRoleCell forIndexPath:indexPath];
        cell.textLabel.text = labelValue;
        cell.detailTextLabel.text = placeHolderValue;
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdressCell forIndexPath:indexPath];
        cell.textLabel.text = labelValue;
        cell.detailTextLabel.text = placeHolderValue;
        
        return cell;
    }
    
    return nil;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {

        case 0: break;

        case 1: [self performSegueWithIdentifier:kRoleSegue sender:nil]; break;
        
        case 2: [self performSegueWithIdentifier:kAdressSegue sender:nil]; break;
            
        default: break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    _companyName = textField.text;
}

#pragma mark - Actions

- (IBAction)didTapSubmit:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Salon postSalonInfo:self.companyName
                 address:self.address
               longitude:[NSNumber numberWithFloat:self.addressCoords.longitude]
               lattitude:[NSNumber numberWithFloat:self.addressCoords.latitude]
                andToken:self.passedSalon.token
               withBlock:^(Salon *salonObj) {
                   
                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                   [EKSettings updateSavedSalon:salonObj];

                   [self performSegueWithIdentifier:kSalonDashSegue sender:nil];
                   
//                   if (self.unwindSegueID && self.unwindSegueID.length) {
//                       [self performSegueWithIdentifier:self.unwindSegueID sender:nil]; //unwind to bpSettingsVC
//                   } else {
//                       [self performSegueWithIdentifier:kAddServiceSegue sender:nil];
//                   }
                   
               } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                   
                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                   [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
               }];
}

#pragma mark - Navigation

- (IBAction)unwindToSalonInfoVC:(UIStoryboardSegue *)segue {

    [self initializeDataSource];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kSalonDashSegue]) {
        
    }
}

#pragma mark - Helpers

- (void)initializeDataSource {
    
    _dataSourceArray = @[
                         @{@"Company Name" : self.companyName},
                         @{@"Role" : self.role},
                         @{@"Address" : self.address}
                         ];
}

@end
