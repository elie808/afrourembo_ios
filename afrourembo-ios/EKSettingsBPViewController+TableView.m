//
//  EKSettingsBPViewController+TableView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/12/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSettingsBPViewController+TableView.h"

static NSString * const kTableCell = @"settingsTableCell";

@implementation EKSettingsBPViewController (TableView)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCell forIndexPath:indexPath];
    
    cell.textLabel.text = [self.tableViewDataSource objectAtIndex:indexPath.row];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44.0;
//}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *selectedItem = self.tableViewDataSource[indexPath.row];
    
    if ([selectedItem isEqualToString:kProfile]) {
        [self performSegueWithIdentifier:kProfileSegue sender:nil];
    }
    
    if ([selectedItem isEqualToString:kBusinessInfo]) {
        [self performSegueWithIdentifier:kBusinessSegue sender:nil];
    }
    
    if ([selectedItem isEqualToString:kManagePhotos]) {
        [self performSegueWithIdentifier:kGallerySegue sender:nil];
    }
    
    if ([selectedItem isEqualToString:kServices]) {
        [self performSegueWithIdentifier:kAddServicesSegue sender:nil];
    }
    
    if ([selectedItem isEqualToString:kAvailability]) {
        [self performSegueWithIdentifier:kAvailabilitySegue sender:nil];
    }
}

@end
