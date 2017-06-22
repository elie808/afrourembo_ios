//
//  EKSalonRoleViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/22/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKSalonInfoViewController.h"
#import "EKSalonSelectTableViewCell.h"

@interface EKSalonRoleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
