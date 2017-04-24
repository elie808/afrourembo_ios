//
//  EKEditProfileInformationViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKEditFacebookProfileInfoViewController.h"

static NSString * const keditProfileInfoCell = @"editProfileInfoCell";

@interface EKEditFacebookProfileInfoViewController() {
    NSArray *_dataSourceArray;
}
@end

@implementation EKEditFacebookProfileInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Profile information";
    self.changeProfilePicButton.layer.borderColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.].CGColor;
    
    _dataSourceArray = @[
                         @{@"First name" : @"Your name"},
                         @{@"Last name" : @"Your last name"},
                         @{@"Email" : @"address@mail.com"}
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
