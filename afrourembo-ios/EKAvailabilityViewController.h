//
//  EKAvailabilityViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/3/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKSwitchTableViewCell.h"
#import "EKDualButtonTableViewCell.h"
#import "Day.h"
#import "Day+API.h"
#import "Professional.h"
#import "UIViewController+Helpers.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface EKAvailabilityViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EKSwitchCellDelegate, EKDualButtonCellDelegate>

@property (strong, nonatomic) Professional *passedProfessional;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *datePickerView;

- (IBAction)didChangeDate:(UIDatePicker *)sender;
- (IBAction)didTapCancelDatePicker:(id)sender;

@end
