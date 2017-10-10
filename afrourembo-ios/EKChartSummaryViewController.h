//
//  EKChartSummaryViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/31/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Dashboard+API.h"
#import "EKConstants.h"
#import "EKSettings.h"

#import "UIViewController+Helpers.h"
#import <DateTools/DateTools.h>
#import <MBProgressHUD/MBProgressHUD.h>
@import Charts.Swift;

@interface EKChartSummaryViewController : UIViewController

@property (strong, nonatomic) IBOutlet LineChartView *revenueGraph;

- (IBAction)didChangeSegmentedValue:(UISegmentedControl *)sender;

@end
