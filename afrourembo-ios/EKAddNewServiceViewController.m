//
//  EKAddNewServiceViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKAddNewServiceViewController.h"

static NSString * const kTitleCell = @"createServiceCellTitle";
static NSString * const kGroupCell = @"createServiceCellGroup";
static NSString * const kPriceCell = @"createServiceCellPrice";
static NSString * const kTimeCell  = @"createServiceCellTime";

static NSString * const kAddService = @"createServiceCell";

@implementation EKAddNewServiceViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"New service";
    
    //TODO: Replace with Service/view model
    _dataSourceArray = @[
                         @{@"Password" : @"Your password"},
                         @{@"Password" : @"Your password"},
                         @{@"Password" : @"Your password"},
                         @{@"Password" : @"Your password"}
                         ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTitleCell forIndexPath:indexPath];
            return cell;
            
        } break;
        
        case 1: {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGroupCell forIndexPath:indexPath];
            return cell;
            
        } break;
            
        case 2: {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPriceCell forIndexPath:indexPath];
            return cell;
            
        } break;
            
        case 3: {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeCell forIndexPath:indexPath];
            return cell;
            
        } break;
            
        default: return nil; break;
    }

    //    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    //    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Actions

- (IBAction)didTapRemoveServiceButton:(id)sender {
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
