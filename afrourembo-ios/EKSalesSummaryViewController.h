//
//  EKSalesSummaryViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Dashboard.h"
#import "Summary.h"
#import "EKConstants.h"

#import "EKSalesSummaryTableViewCell.h"

#import <DateTools/DateTools.h>

@interface EKSalesSummaryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<Dashboard *> *dataSource;

@end
