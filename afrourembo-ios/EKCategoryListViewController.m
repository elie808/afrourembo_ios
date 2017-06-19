//
//  EKCategoryListViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCategoryListViewController.h"

static NSString * const kCellID         = @"categoryListCellID";
static NSString * const kUnwindSegue    = @"selectedCategoryUnwindSegue";

@implementation EKCategoryListViewController {
    NSMutableArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSourceArray = [NSMutableArray arrayWithArray:[self createStubs]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Service *catObj = [_dataSourceArray objectAtIndex:indexPath.row];
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    cell.cellTitleLabel.text = catObj.serviceGroup;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Service *obj = [_dataSourceArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kUnwindSegue sender:obj];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kUnwindSegue]) {
     
        EKAddNewServiceViewController *vc = segue.destinationViewController;
        vc.serviceToEdit.serviceGroup = ((Service*)sender).serviceGroup;
    }
}

#pragma mark - Helpers

- (NSArray *)createStubs {
 
    Service *obj1 = [Service new];
    obj1.serviceTitle = @"";
    obj1.serviceImage = nil;
    obj1.serviceGroup = @"Category Title 1";
    obj1.servicePrice = 0;
    obj1.serviceLaborTime = 0;
    
    Service *obj2 = [Service new];
    obj2.serviceTitle = @"";
    obj2.serviceImage = nil;
    obj2.serviceGroup = @"Category Title 2";
    obj2.servicePrice = 0;
    obj2.serviceLaborTime = 0;
    
    Service *obj3 = [Service new];
    obj3.serviceTitle = @"";
    obj3.serviceImage = nil;
    obj3.serviceGroup = @"Category Title 3";
    obj3.servicePrice = 0;
    obj3.serviceLaborTime = 0;
    
    return @[obj1, obj2, obj3];
}

@end
