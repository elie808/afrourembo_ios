//
//  EKSalonSelectViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "EKSalonSelectTableViewCell.h"
#import "EKAddServiceViewController.h"
#import "Professional.h"
#import "Salon.h"

#import "Explore+API.h"
#import "UIViewController+Helpers.h"


@interface EKSalonSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Professional *passedProfessional;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
