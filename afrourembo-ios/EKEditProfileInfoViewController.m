//
//  EKEditProfileInfoViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/24/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKEditProfileInfoViewController.h"

static NSString * const keditProfileInfoCell = @"editProfileInfoCell";

@interface EKEditProfileInfoViewController () {
    NSArray *_dataSourceArray;
} @end

@implementation EKEditProfileInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Profile information";
    
    _dataSourceArray = @[
                         @{@"First name" : @"Your name"},
                         @{@"Last name" : @"Your last name"},
                         @{@"Phone number" : @"(___) ___ - ___"}
                         ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:keditProfileInfoCell forIndexPath:indexPath];
    
    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    cell.cellTitleLabel.text = labelValue;
    cell.cellTextField.placeholder = placeHolderValue;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
