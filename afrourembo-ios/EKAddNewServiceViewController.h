//
//  EKAddNewServiceViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKAddServiceViewController.h"
#import "EKAddNewServiceTableViewCell.h"
#import "Service.h"
#import "Category.h"
#import "NSDate+Helpers.h"

@interface EKAddNewServiceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) Service *passedService;
@property (strong, nonatomic) Service *serviceToEdit; // to be passed down to presented segues, and updated by unwinding vc's

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIView *timePickerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *removeServiceButton;
@property (strong, nonatomic) UIToolbar *keyboardToolbar;

- (IBAction)didChangeTimePicker:(UIDatePicker *)sender;

- (IBAction)unwingToAddNewServiceVC:(UIStoryboardSegue *)segue;

@end
