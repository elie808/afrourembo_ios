//
//  EKAvailabilityViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/3/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKAvailabilityViewController.h"

static NSString * const kSwitchCell = @"availabilitySwitchCell";
static NSString * const kTimeCell   = @"availabilityTimeCell";

@implementation EKAvailabilityViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Availability";
    
    _dataSourceArray = @[
                         @{@"Password" : @"Your password"},
                         @{@"Password" : @"Your password"},
                         @{@"Password" : @"Your password"},
                         @{@"Password" : @"Your password"}
                         ];
}

#pragma mark - UITableViewDataSource

// return a plain uiview as a footer in-between section groups, to easily adjust height later
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

// set the size in-between section groups
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
            
        case 0: return 1; break;
            
        case 1: return 2; break;
            
        case 2: return 4; break;
            
        default: return 1; break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        EKSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSwitchCell forIndexPath:indexPath];
        
        //    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
        //    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeCell forIndexPath:indexPath];
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        
        EKSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSwitchCell forIndexPath:indexPath];
        
        return cell;
    }
    
    if (indexPath.row == 3) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeCell forIndexPath:indexPath];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Helpers

- (void)addRowAtIndexPath:(NSIndexPath*)indexPath {
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}

- (void)removeRowAtIndexPath:(NSIndexPath*)indexPath {
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
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
