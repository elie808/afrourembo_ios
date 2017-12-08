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

@interface EKDashboardViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

- (IBAction)didTapFilterButton:(UIBarButtonItem *)sender;

- (void)configureWithDashboardItems:(NSArray<Dashboard *> *)dashboardItemsArray;

@end
