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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"New service";
    
    self.serviceToEdit = [Service new];
    
    if (!self.passedService) {
        
        // initialize fields to avoid nil errors when inserting into the datasource dictionary
        self.serviceToEdit.serviceId = @"";
        self.serviceToEdit.categoryId = @"";
        self.serviceToEdit.categoryName = @"";
        self.serviceToEdit.name = @"";
        self.serviceToEdit.price = 0;
        self.serviceToEdit.time = 0;
        
        self.removeServiceButton.hidden = YES;
        
    } else {
    
        self.serviceToEdit.categoryId = self.passedService.categoryId;
        self.serviceToEdit.categoryName = self.passedService.categoryName;
        self.serviceToEdit.serviceId = self.passedService.serviceId;
        self.serviceToEdit.name = self.passedService.name;
        self.serviceToEdit.price = self.passedService.price;
        self.serviceToEdit.time = self.passedService.time;
    }
    
    [self initializeDataSource];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
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
    
//    if (indexPath.row == 0 || indexPath.row == 1) {

    if (indexPath.row == 0) {
        
        cell.cellTextField.enabled = NO;
        
        if (self.serviceToEdit.categoryId.length > 0 && self.serviceToEdit.name.length > 0) {
            cell.cellTextField.text = [NSString stringWithFormat:@"%@, %@", self.serviceToEdit.categoryName, self.serviceToEdit.name];
        }
        
    } else {
        
        cell.cellTextField.enabled = YES;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        
        case 0: [self performSegueWithIdentifier:kGroupListSegue sender:nil]; break;
            
//        case 1: {
//     
//            if (self.serviceToEdit.categoryId.length > 0 && self.serviceToEdit.name.length > 0) {
//            
//                [self performSegueWithIdentifier:kServiceListSegue sender:nil]; break;
//            }
//        }
            
        default: break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 1) {
        
        self.serviceToEdit.price = [textField.text floatValue];
        
    } else if (textField.tag == 2) {
        
        self.serviceToEdit.time = [textField.text floatValue];
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

- (IBAction)unwingToAddNewServiceVC:(UIStoryboardSegue *)segue {

//    if ([segue.identifier isEqualToString:@"selectedCategoryUnwindSegue"]) {
//        
//    }
    
//    if ([segue.identifier isEqualToString:@"selectedTitleUnwindSegue"]) {
//        
//    }
    
    [self initializeDataSource];
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kUnwindSegue]) {
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        
        if (!self.passedService) {
            
            [vc.dataSourceArray addObject:self.serviceToEdit];
            
        } else {
            
            [vc.dataSourceArray removeObject:self.passedService];
            [vc.dataSourceArray addObject:self.serviceToEdit];
        }
     
        [vc.tableView reloadData];
    }
    
    if ([segue.identifier isEqualToString:kUnwindRemoveSegue]) {
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        [vc.dataSourceArray removeObject:self.passedService];
        [vc.tableView reloadData];
    }
}

#pragma mark - Helpers

/// used to make populating and updating the tabelView values simple, with a backing data model and minimal code in tableView:cellForRow
- (void)initializeDataSource {
    
//    if (self.serviceToEdit.name.length > 0) {
//    
//        _dataSourceArray = @[
//                             @{@"Group" : self.serviceToEdit.categoryId},
//                             @{@"Title" : self.serviceToEdit.name},
//                             @{@"Price" : [NSString stringWithFormat:@"%f", self.serviceToEdit.price]},
//                             @{@"Time for service" : [NSString stringWithFormat:@"%f", self.serviceToEdit.time]}
//                             ];
//        
//    } else {
    
        _dataSourceArray = @[
                             @{@"Service" : self.serviceToEdit.categoryName},
                             @{@"Price" : [NSString stringWithFormat:@"%f", self.serviceToEdit.price]},
                             @{@"Time for service" : [NSString stringWithFormat:@"%f", self.serviceToEdit.time]}
                             ];
//    }
}

@end
