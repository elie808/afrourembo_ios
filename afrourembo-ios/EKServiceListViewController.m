//
//  EKServiceListViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKServiceListViewController.h"

static NSString * const kCellID         = @"serviceListCellID";
static NSString * const kUnwindSegue    = @"selectedTitleUnwindSegue";

@implementation EKServiceListViewController {
    NSMutableArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationBar.hidden = YES;
    
    _dataSourceArray = [NSMutableArray arrayWithArray:self.passedCategory.services];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Service *obj = [_dataSourceArray objectAtIndex:indexPath.row];
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    cell.cellTitleLabel.text = obj.name;
    
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
        vc.serviceToEdit.categoryId = self.passedCategory.categoryId;
        vc.serviceToEdit.categoryName = self.passedCategory.name;
        vc.serviceToEdit.name = ((Service *)sender).name;
        vc.serviceToEdit.serviceId = ((Service *)sender).serviceId;
    }
}

#pragma mark - Helpers

- (NSArray *)createStubs {
    
    Service *obj1 = [Service new];
    obj1.name = @"Service Title 1";
//    obj1.serviceImage = nil;
    obj1.categoryId = @"";
    obj1.price = 0;
    obj1.time = 0;
    
    Service *obj2 = [Service new];
    obj2.name = @"Service Title 2";
//    obj2.serviceImage = nil;
    obj2.categoryId = @"";
    obj2.price = 0;
    obj2.time = 0;
    
    Service *obj3 = [Service new];
    obj3.name = @"Service Title 3";
//    obj3.serviceImage = nil;
    obj3.categoryId = @"";
    obj3.price = 0;
    obj3.time = 0;
    
    return @[obj1, obj2, obj3];
}

@end
