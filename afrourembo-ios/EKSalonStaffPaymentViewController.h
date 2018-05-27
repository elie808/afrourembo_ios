//
//  EKSalonStaffPaymentViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKDatePickerViewController.h"
#import "NSDate+Helpers.h"

@interface EKSalonStaffPaymentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EKDatePickerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *startDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *endDateLabel;

@end
