//
//  EKSalonManageStaffViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 12/2/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "EKSettings.h"
#import "EKManageStaffTableViewCell.h"

#import "UIViewController+Helpers.h"
#import "Salon+API.h"

@interface EKSalonManageStaffViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EKManageStaffCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
