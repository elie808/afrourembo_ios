//
//  EKDashboardViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EKSalesSummaryViewController.h"
#import "EKChartSummaryViewController.h"
#import "EKServicesChartViewController.h"

#import "Summary.h"
#import "EKConstants.h"
#import "EKSettings.h"

#import "Dashboard+API.h"

#import "UIViewController+Helpers.h"
#import <DateTools/DateTools.h>
#import <MBProgressHUD/MBProgressHUD.h>
@import Charts.Swift;

@interface EKDashboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) UIPageViewController *pageViewController;

//- (IBAction)didTapFilterButton:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet LineChartView *revenueGraph;

- (void)configureWithDashboardItems:(NSArray<Dashboard *> *)dashboardItemsArray;

@end
