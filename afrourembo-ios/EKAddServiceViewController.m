//
//  EKAddServiceViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKAddServiceViewController.h"

static NSString * const kEditServiceSegue = @"serviceListToEditService";
static NSString * const kNewServiceSegue  = @"serviceListToNewService";

static NSString * const kServiceCell = @"addServiceCell";

@implementation EKAddServiceViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Services";
    
    _dataSourceArray = @[
                         @{@"Password" : @"Your password"}
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
    
    EKAccessoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kServiceCell forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.cellIndexPath = indexPath;
    
    cell.cellTextLabel.text = @"Hair";
//    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
//    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - EKAccessoryCellDelegate

- (void)didTapAccessoryButtonAtIndex:(NSIndexPath *)indexPath {
    
    //TODO: Pass sender Service obj
    [self performSegueWithIdentifier:kEditServiceSegue sender:nil];
}

#pragma mark - Actions

- (IBAction)didTapAddServiceButton:(id)sender {
    
    [self performSegueWithIdentifier:kNewServiceSegue sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kNewServiceSegue]) {
        
    }
    
    if ([segue.identifier isEqualToString:kEditServiceSegue]) {
        
    }
}

@end
