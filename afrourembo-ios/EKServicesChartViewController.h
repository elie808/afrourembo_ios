//
//  EKServicesChartViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EKSalesSummaryTableViewCell.h"

#import "Dashboard+API.h"
#import "EKSettings.h"

#import "UIViewController+Helpers.h"
#import <DateTools/DateTools.h>
#import <MBProgressHUD/MBProgressHUD.h>

// helper model to use for UI display
@interface ServicesUIModel : NSObject
@property NSString *serviceName;
@property NSInteger serviceCount;
@end

@interface EKServicesChartViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didChangeSegmentedValue:(UISegmentedControl *)sender;

@end
