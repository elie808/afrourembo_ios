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

static CGFloat const kTimePickerHeight = 230.;

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
        self.serviceToEdit.price = 0.0;
        self.serviceToEdit.time = 0.0;
        self.serviceToEdit.currency = @"";
        
        self.removeServiceButton.hidden = YES;
        
    } else {
    
        self.serviceToEdit.categoryId = self.passedService.categoryId;
        self.serviceToEdit.categoryName = self.passedService.categoryName;
        self.serviceToEdit.serviceId = self.passedService.serviceId;
        self.serviceToEdit.name = self.passedService.name;
        self.serviceToEdit.price = self.passedService.price;
        self.serviceToEdit.time = self.passedService.time;
        self.serviceToEdit.currency = self.passedService.currency;
    }
    
    [self initializeDataSource];
 
    
    self.keyboardToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.keyboardToolbar.barStyle = UIBarStyleDefault;
    self.keyboardToolbar.items = [NSArray arrayWithObjects:
                                  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil action:nil],
                                  [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self
                                                                 action:@selector(doneWithNumberPad)],
                                  nil];
    [self.keyboardToolbar sizeToFit];

    
    self.timePickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kTimePickerHeight);
    [self.view addSubview:self.timePickerView];
    self.timePickerView.hidden = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKAddNewServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTitleCell forIndexPath:indexPath];
    
    cell.cellIndexPath = indexPath;
    cell.cellTextLabel.text = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    cell.cellTextField.text = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    cell.cellTextField.enabled = NO;
    cell.cellTextField.tag = indexPath.row;
    
    cell.cellTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    if (indexPath.row == 0) {
        
        if (self.serviceToEdit.categoryId.length > 0 && self.serviceToEdit.name.length > 0) {
            cell.cellTextField.text = [NSString stringWithFormat:@"%@, %@", self.serviceToEdit.categoryName, self.serviceToEdit.name];
        }
    }
    
    if (indexPath.row == 1) {
        
        cell.cellTextField.enabled = YES;
        cell.cellTextField.inputAccessoryView = self.keyboardToolbar;
        
        if (self.serviceToEdit.price && self.serviceToEdit.price > 0) {
            cell.cellTextField.text = [NSString stringWithFormat:@"%.1f %@", self.serviceToEdit.price, self.serviceToEdit.currency];
        }
    }
    
    if (indexPath.row == 2) {

        if (self.serviceToEdit.time && self.serviceToEdit.time > 0) {
            cell.cellTextField.text = [NSString stringWithFormat:@"%.f minutes", self.serviceToEdit.time];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        
        case 0: [self performSegueWithIdentifier:kGroupListSegue sender:nil]; break;
            
        case 2: [self showDatePicker];
            
        default: break;
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    textField.text = @"";
    if (textField.tag == 1) { self.serviceToEdit.price = 0; }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 1) { self.serviceToEdit.price = [textField.text floatValue]; }
}

#pragma mark - Actions

- (IBAction)didTapDoneButton:(UIBarButtonItem *)sender {

    [self performSegueWithIdentifier:kUnwindSegue sender:nil];
}

- (IBAction)didTapRemoveServiceButton:(id)sender {
    
    [self performSegueWithIdentifier:kUnwindRemoveSegue sender:nil];
}

- (void)doneWithNumberPad {
    
    EKAddNewServiceTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathsForVisibleRows][1]];
    
    if (cell) {
    
        self.serviceToEdit.price = [cell.cellTextField.text floatValue];
        [cell.cellTextField resignFirstResponder];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (IBAction)didChangeTimePicker:(UIDatePicker *)sender {
    
    self.serviceToEdit.time = floor(sender.countDownDuration / 60);
    [self.tableView reloadData];
    
    [self hideDatePicker];
}

- (IBAction)unwingToAddNewServiceVC:(UIStoryboardSegue *)segue {

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

- (void)showDatePicker {
    
    self.timePickerView.hidden = NO;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.timePickerView.frame = CGRectMake(0, self.view.frame.size.height - kTimePickerHeight,
                                                                self.view.frame.size.width, kTimePickerHeight);
                     }];
}

- (void)hideDatePicker {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.timePickerView.frame = CGRectMake(0, self.view.frame.size.height,
                                                                self.view.frame.size.width, kTimePickerHeight);
                     }
                     completion:^(BOOL finished) {
                         self.timePickerView.hidden = YES;
                     }];
}

@end
