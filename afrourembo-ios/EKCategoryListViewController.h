//
//  EKCategoryListViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextFieldTableViewCell.h"
#import "Service.h"
#import "Category+API.h"
#import "EKAddNewServiceViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIViewController+Helpers.h"

@interface EKCategoryListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
