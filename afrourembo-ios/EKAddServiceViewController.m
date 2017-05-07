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

static NSString * const kUnwindFromNewService = @"unwindFromNewServiceToServiceVC";

@implementation EKAddServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Services";
    
    self.dataSourceArray = [NSMutableArray new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKAccessoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kServiceCell forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.cellIndexPath = indexPath;
    
    Service *serviceObj = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    cell.cellTextLabel.text = serviceObj.serviceTitle;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - EKAccessoryCellDelegate

- (void)didTapAccessoryButtonAtIndex:(NSIndexPath *)indexPath {
    
    Service *serviceObj = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kEditServiceSegue sender:serviceObj];
}

#pragma mark - Actions

- (IBAction)didTapAddServiceButton:(id)sender {
    
    [self performSegueWithIdentifier:kNewServiceSegue sender:nil];
}

#pragma mark - Navigation

- (IBAction)unwindToAddServiceVC:(UIStoryboardSegue *)segue {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kNewServiceSegue]) {
        
    }
    
    if ([segue.identifier isEqualToString:kEditServiceSegue]) {
        
        EKAddNewServiceViewController *vc = segue.destinationViewController;
        vc.passedService = (Service*)sender;
    }
}

@end
