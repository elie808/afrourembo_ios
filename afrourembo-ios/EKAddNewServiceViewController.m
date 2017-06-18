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

static NSString * const kGroupListSegue = @"newServiceToCategoryList";
static NSString * const kServiceListSegue = @"newServiceToServiceList";

static NSString * const kUnwindSegue = @"unwindFromNewServiceToServiceVC";
static NSString * const kUnwindRemoveSegue = @"unwindNewServiceToServiceVCREMOVE";

@implementation EKAddNewServiceViewController {
    NSArray *_dataSourceArray;
    Service *_serviceToEdit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"New service";
    
    _serviceToEdit = [Service new];
    
    if (!self.passedService) {
        
        _serviceToEdit.serviceGroup = @"group";
        _serviceToEdit.serviceTitle = @"title here";
        _serviceToEdit.servicePrice = 10;
        _serviceToEdit.serviceLaborTime = 20;
        
        self.removeServiceButton.hidden = YES;
        
    } else {
    
        _serviceToEdit.serviceGroup = self.passedService.serviceGroup;
        _serviceToEdit.serviceTitle = self.passedService.serviceTitle;
        _serviceToEdit.servicePrice = self.passedService.servicePrice;
        _serviceToEdit.serviceLaborTime = self.passedService.serviceLaborTime;
    }
    
    _dataSourceArray = @[
                         @{@"Group" : _serviceToEdit.serviceGroup},
                         @{@"Title" : _serviceToEdit.serviceTitle},
                         @{@"Price" : [NSString stringWithFormat:@"%f", _serviceToEdit.servicePrice]},
                         @{@"Time for service" : [NSString stringWithFormat:@"%f", _serviceToEdit.serviceLaborTime]}
                         ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    EKAddNewServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTitleCell forIndexPath:indexPath];
    
    cell.cellIndexPath = indexPath;
    cell.cellTextLabel.text = labelValue;
    cell.cellTextField.text = placeHolderValue;
    
    cell.cellTextField.tag = indexPath.row;
    
    cell.cellTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    if (indexPath.row == 0 || indexPath.row == 1) {
    
        cell.cellTextField.enabled = NO;
    
    } else {
        
        cell.cellTextField.enabled = YES;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        
        case 0: [self performSegueWithIdentifier:kGroupListSegue sender:nil]; break;
            
        case 1: [self performSegueWithIdentifier:kServiceListSegue sender:nil]; break;
            
        default: break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 2) {
        
        _serviceToEdit.servicePrice = [textField.text floatValue];
        NSLog(@"service Price: %f", _serviceToEdit.servicePrice);
        
    } else if (textField.tag == 3) {
        
        _serviceToEdit.serviceLaborTime = [textField.text floatValue];
        NSLog(@"labor time: %f", _serviceToEdit.serviceLaborTime);
    }
}

#pragma mark - Actions

- (IBAction)didTapDoneButton:(UIBarButtonItem *)sender {

    [self performSegueWithIdentifier:kUnwindSegue sender:nil];
}

- (IBAction)didTapRemoveServiceButton:(id)sender {
    
    [self performSegueWithIdentifier:kUnwindRemoveSegue sender:nil];
}

#pragma mark - Navigation

- (IBAction)unwingToAddNewServiceVC:(UIStoryboardSegue *)segue {}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kUnwindSegue]) {
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        
        if (!self.passedService) {
            
            [vc.dataSourceArray addObject:_serviceToEdit];
            
        } else {
            
            [vc.dataSourceArray removeObject:self.passedService];
            [vc.dataSourceArray addObject:_serviceToEdit];
        }
     
        [vc.tableView reloadData];
    }
    
    if ([segue.identifier isEqualToString:kUnwindRemoveSegue]) {
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        [vc.dataSourceArray removeObject:self.passedService];
        [vc.tableView reloadData];
    }
}

@end
