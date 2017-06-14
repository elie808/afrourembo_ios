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

@interface EKSalonInfoViewController() {
    NSArray *_dataSourceArray;
}
@end

@implementation EKSalonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSourceArray = @[@"Company Name", @"Role", @"Address"];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSalonCell forIndexPath:indexPath];
        cell.cellTitleLabel.text = _dataSourceArray[indexPath.row];
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRoleCell forIndexPath:indexPath];
        cell.textLabel.text = _dataSourceArray[indexPath.row];
        cell.detailTextLabel.text = @"my role";
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdressCell forIndexPath:indexPath];
        cell.textLabel.text = _dataSourceArray[indexPath.row];
        cell.detailTextLabel.text = @"my address";
        
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

#pragma mark - Actions

- (IBAction)didTapSubmit:(id)sender {
}

#pragma mark - Navigation

- (IBAction)unwindToSalonInfoVC:(UIStoryboardSegue *)segue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
}

@end
