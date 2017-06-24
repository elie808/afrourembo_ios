//
//  EKCategoryListViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCategoryListViewController.h"

static NSString * const kCellID         = @"categoryListCellID";

static NSString * const kServicesSegue  = @"categoryListToServiceListVC";
static NSString * const kUnwindSegue    = @"selectedCategoryUnwindSegue";

@implementation EKCategoryListViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _dataSourceArray = [NSArray arrayWithArray:[self createStubs]];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Category getCategoriesWithBlock:^(NSArray<Category *> *categoriesArray) {
    
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        _dataSourceArray = [NSArray arrayWithArray:categoriesArray];
        [self.tableView reloadData];
        
    } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showMessage:errorMessage
                withTitle:@"Error"
          completionBlock:nil];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Category *catObj = [_dataSourceArray objectAtIndex:indexPath.row];
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.cellTitleLabel.text = [catObj.name uppercaseString];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Category *obj = [_dataSourceArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kServicesSegue sender:obj];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kServicesSegue]) {

        EKServiceListViewController *vc = segue.destinationViewController;
        vc.passedCategory = (Category*)sender;
    }

    if ([segue.identifier isEqualToString:kUnwindSegue]) {
     
//        EKAddNewServiceViewController *vc = segue.destinationViewController;
//        vc.serviceToEdit.serviceGroup = ((Category*)sender).name;
//        
//        vc.serviceToEdit.name = @"TEST TITLE";
    }
}

#pragma mark - Helpers

- (NSArray *)createStubs {
 
    Service *obj1 = [Service new];
    obj1.name = @"";
//    obj1.icon = nil;
    obj1.serviceGroup = @"Category Title 1";
    obj1.servicePrice = 0;
    obj1.serviceLaborTime = 0;
    
    Service *obj2 = [Service new];
    obj2.name = @"";
//    obj2.serviceImage = nil;
    obj2.serviceGroup = @"Category Title 2";
    obj2.servicePrice = 0;
    obj2.serviceLaborTime = 0;
    
    Service *obj3 = [Service new];
    obj3.name = @"";
//    obj3.serviceImage = nil;
    obj3.serviceGroup = @"Category Title 3";
    obj3.servicePrice = 0;
    obj3.serviceLaborTime = 0;
    
    return @[obj1, obj2, obj3];
}

@end
