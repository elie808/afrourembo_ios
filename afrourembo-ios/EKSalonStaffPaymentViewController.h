//
//  EKSalonStaffPaymentViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "EKDatePickerViewController.h"
#import "EKSalonStaffTableViewCell.h"
#import "EKSettings.h"
#import "StaffPayment+API.m"
#import "NSDate+Helpers.h"
#import "UIViewController+Helpers.h"

@interface EKSalonStaffPaymentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EKDatePickerDelegate, SalonStaffCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *startDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *endDateLabel;

@end
