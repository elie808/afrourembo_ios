//
//  EKSalonSelectViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKSalonSelectTableViewCell.h"
#import "Salon.h"

@interface EKSalonSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
