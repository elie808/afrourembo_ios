//
//  EKProfessionalInfoViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKProfessionalInfoViewController.h"

static NSString * const kProfInfoCell       = @"textFieldProfessionalInfoCell";
static NSString * const kAdressCell         = @"professionalAddressCell";
static NSString * const kPhoneCell          = @"professionalPhoneNumberCell";
static NSString * const kSwitchCell         = @"professionalMobileCell";

static NSString * const kAddServiceSegue    = @"profInfoToAddServiceVC";
static NSString * const kAddressSegue       = @"professionalInfoToProfessionalAdressVC";

@implementation EKProfessionalInfoViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([EKSettings getSavedVendor].token.length > 0) { // if viewcontroller is accessed from professional's Settings
    
        [Professional getProfileForProfessional:[EKSettings getSavedVendor].token
                                      withBlock:^(Professional *professionalObj) {
                                          
                                          self.businessName = professionalObj.business.name;
                                          self.address = professionalObj.business.address;
                                          self.phoneNumber = professionalObj.phone;
                                          self.isMobile = professionalObj.isMobile;
                                          
                                          [self updateDataSource];
                                          [self.tableView reloadData];
                                          
                                      } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                         [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                     }];
    } else {
        
        [self initializeDataSource];
    }
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
        
        EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfInfoCell forIndexPath:indexPath];
        cell.cellTitleLabel.text = labelValue;
        cell.cellTextField.text = placeHolderValue;
        cell.cellTextField.tag = 0;
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdressCell forIndexPath:indexPath];
        cell.cellTitleLabel.text = labelValue;
        cell.cellTextField.text = placeHolderValue;
        cell.cellTextField.tag = 1;
        
        return cell;
    }

    if (indexPath.row == 2) {
        
        EKProfessionalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSwitchCell forIndexPath:indexPath];
        cell.cellLabel.text = labelValue;
        [cell.cellSwitch setOn:self.isMobile];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            
        case 0: break;
            
        case 1: [self performSegueWithIdentifier:kAddressSegue sender:nil]; break;
            
        default: break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 0) {
        self.businessName = textField.text;
    }
    
    if (textField.tag == 1) {
        self.address = textField.text;
    }
}

#pragma mark - Actions

- (IBAction)didTapNextButton:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ProfessionalInfo postProInfo:self.businessName
                          address:self.address
                        longitude:[NSNumber numberWithFloat:self.addressCoords.longitude]
                        lattitude:[NSNumber numberWithFloat:self.addressCoords.latitude]
                         andToken:[EKSettings getSavedVendor].token
                        withBlock:^(Professional *professionalObj) {
                          
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [EKSettings updateSavedProfessional:professionalObj];
                            
                            if (self.unwindSegueID && self.unwindSegueID.length) {
                                [self performSegueWithIdentifier:self.unwindSegueID sender:nil]; //unwind to bpSettingsVC
                            } else {
                                [self performSegueWithIdentifier:kAddServiceSegue sender:nil];
                            }
                            
                        } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                           
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                       }];
}

- (IBAction)didChangeSwitch:(UISwitch*)sender {
    
    self.isMobile = sender.isOn;
}

#pragma mark - Navigation

- (IBAction)unwindToProfessionalInfoVC:(UIStoryboardSegue *)segue {
    
    [self updateDataSource];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kAddServiceSegue]) {
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        vc.passedProfessional = self.passedProfessional;
        
        BusinessInfo *selectedBusinessAdress = [BusinessInfo new];
        selectedBusinessAdress.name = self.businessName;
        selectedBusinessAdress.address = self.address;
        selectedBusinessAdress.longitude = self.addressCoords.longitude;
        selectedBusinessAdress.latitude = self.addressCoords.latitude;
        
//        selectedBusinessAdress.location = @{@"longitude" : [NSNumber numberWithFloat:self.addressCoords.longitude],
//                                            @"latitude" : [NSNumber numberWithFloat:self.addressCoords.latitude]};
        
        vc.passedProfessional.business = selectedBusinessAdress;
        
        vc.passedProfessional.phone = self.phoneNumber;
        vc.passedProfessional.isMobile = self.isMobile;
    }
    
    if ([segue.identifier isEqualToString:kAddressSegue]) {

        EKProfessionalAddressViewController *vc = segue.destinationViewController;
        vc.passedCoords = self.addressCoords;
    }
}

#pragma mark - Helpers

- (void)initializeDataSource {
    
    self.businessName = @"";
    self.address = @"";
    self.phoneNumber = @"";
    self.addressCoords = CLLocationCoordinate2DMake(0, 0);
    self.isMobile = NO;
    
    _dataSourceArray = @[
                         @{@"Company Name" : self.businessName},
                         @{@"Address" : self.address},
//                         @{@"Phone number" : self.phoneNumber},
                         @{@"I am mobile" : @""}
                         ];
}

- (void)updateDataSource {
    
    _dataSourceArray = @[
                         @{@"Company Name" : self.businessName ? self.businessName : @""},
                         @{@"Address" : self.address ? self.address : @""},
//                         @{@"Phone number" : self.phoneNumber},
                         @{@"I am mobile" : @""}
                         ];
}

@end
