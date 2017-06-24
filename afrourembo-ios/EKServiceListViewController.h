//
//  EKServiceListViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextFieldTableViewCell.h"
#import "EKAddNewServiceViewController.h"
#import "Category.h"
#import "Service.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface EKServiceListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Category *passedCategory;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
