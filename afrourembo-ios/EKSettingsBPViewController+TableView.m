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
}

@end
