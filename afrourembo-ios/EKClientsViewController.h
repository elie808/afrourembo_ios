//
//  EKClientsViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "EKSettings.h"
#import "EKClientTableViewCell.h"
#import "EKClientDetailsViewController.h"

#import "Professional+API.h"
#import "UIViewController+Helpers.h"

@interface EKClientsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *emptyDataView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
