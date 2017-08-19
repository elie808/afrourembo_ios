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
static NSString * const kSwitchCell         = @"professionalMobileCell";

static NSString * const kAddServiceSegue    = @"profInfoToAddServiceVC";
static NSString * const kAddressSegue       = @"professionalInfoToProfessionalAdressVC";

@implementation EKProfessionalInfoViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.businessName = @"";
    self.address = @"";
    self.addressCoords = CLLocationCoordinate2DMake(0, 0);
    self.isMobile = NO;
    
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
        
        EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfInfoCell forIndexPath:indexPath];
        cell.cellTitleLabel.text = labelValue;
        cell.cellTextField.text = placeHolderValue;
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdressCell forIndexPath:indexPath];
        cell.textLabel.text = labelValue;
        cell.detailTextLabel.text = placeHolderValue;
        
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
    
    self.businessName = textField.text;
}

#pragma mark - Actions

- (IBAction)didTapNextButton:(id)sender {
    
    //TODO: ADD API CALL
    [self performSegueWithIdentifier:kAddServiceSegue sender:nil];
}

- (IBAction)didChangeSwitch:(UISwitch*)sender {
    
    NSLog(@"IS MOBILE? %@", sender.isOn ? @"YES" : @"NO");
    
    self.isMobile = sender.isOn;
}

#pragma mark - Navigation

- (IBAction)unwindToProfessionalInfoVC:(UIStoryboardSegue *)segue {
    
    [self initializeDataSource];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kAddServiceSegue]) {
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        vc.passedProfessional = self.passedProfessional;

        Business *selectedBusinessAdress = [Business new];
        selectedBusinessAdress.name = self.businessName;
        selectedBusinessAdress.address = self.address;
        selectedBusinessAdress.location = @{@"longitude" : [NSNumber numberWithFloat:self.addressCoords.longitude],
                                            @"latitude" : [NSNumber numberWithFloat:self.addressCoords.latitude]};
        
        vc.passedProfessional.business = selectedBusinessAdress;
        
        vc.passedProfessional.isMobile = self.isMobile;
    }
    
    if ([segue.identifier isEqualToString:kAddressSegue]) {
        
//        EKProfessionalAddressViewController *vc = segue.destinationViewController;
    }
}

#pragma mark - Helpers

- (void)initializeDataSource {
    
    _dataSourceArray = @[
                         @{@"Company Name" : self.businessName},
                         @{@"Address" : self.address},
                         @{@"I am mobile" : @""}
                         ];
}

@end
