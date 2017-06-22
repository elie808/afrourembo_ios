//
//  EKSalonRoleViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/22/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalonRoleViewController.h"

static NSString * const kRoleCell = @"salonRoleCell";
static NSString * const kUnwindSegue = @"salonRoleVcToSalonInfoVC";

@implementation EKSalonRoleViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSourceArray = @[
                         @{@"Manager" : @""},
                         @{@"Owner" : @""},
                         @{@"Sales" : @""}
                         ];
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
//    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    EKSalonSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRoleCell forIndexPath:indexPath];
    cell.cellTextLabel.text = labelValue;
//    cell.cellImageView.image = [UIImage imageNamed:placeHolderValue];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *roleObj = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    
    [self performSegueWithIdentifier:kUnwindSegue sender:roleObj];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kUnwindSegue]) {
        
        EKSalonInfoViewController *vc = segue.destinationViewController;
        vc.role = (NSString *)sender;
    }
}

@end
