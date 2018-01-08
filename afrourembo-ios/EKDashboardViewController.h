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

@interface DashboardUIModel : NSObject
@property NSInteger totalSales;
@property NSInteger totalBookings;
@property NSInteger monthlySales;
@property NSInteger monthlyBookings;
@end

@interface EKDashboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) UIPageViewController *pageViewController;

//- (IBAction)didTapFilterButton:(UIBarButtonItem *)sender;

@property DashboardUIModel *UIModel;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet BarChartView *revenueGraph;

- (void)configureWithDashboardItems:(NSArray<Dashboard *> *)dashboardItemsArray;

@end
