//
//  EKSalesSummaryViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalesSummaryViewController.h"

@implementation EKSalesSummaryViewController {
    Summary *_summary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _summary = [Summary new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:kDashboardNotification
                                               object:nil];
}

- (void)receivedNotification:(NSNotification *) notification {
    
    _summary = [self computeAnalyticsForItems:[notification.userInfo valueForKey:kDashObjKey]];
    [self.tableView reloadData];
}

- (Summary *)computeAnalyticsForItems:(NSArray<Dashboard *> *)dashboardItems {
    
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    Summary *summary = [Summary new];
    
    // compute totals
    for (Dashboard *dashObj in dashboardItems) {
        
        summary.totalSalesValue += [dashObj.price integerValue];
      
        // this month
        if ([dashObj.startDate monthsAgo] == 0) {
            summary.monthlySalesValue += [dashObj.price integerValue];
            summary.monthlyBookingsValue ++;
        }
        
        // last week
        if ([dashObj.startDate weeksAgo] == 1) {
            summary.lastWeekSalesValue += [dashObj.price integerValue];
            summary.lastWeekBookingsValue ++;
        }
        
        // next week
        if ([dashObj.startDate weeksLaterThan:todayDate] == 1) {
            summary.nextWeekSalesValue += [dashObj.price integerValue];
            summary.nextWeekBookingsValue ++;
        }
    }
    
    summary.totalBookingsValue = dashboardItems.count;

    return summary;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKSalesSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SummaryCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0: {
            
            cell.cellLeftTitleLabel.text = @"Total sales YTD";
            cell.cellLeftValueLabel.text = [NSString stringWithFormat:@"KES %ld", (long)_summary.totalSalesValue];
            cell.cellRightTitleLabel.text = @"Total books YTD";
            cell.cellRightValueLabel.text = [NSString stringWithFormat:@"%ld", (long)_summary.totalBookingsValue];
            
        } break;

        case 1: {
            
            cell.cellLeftTitleLabel.text = @"Month sales YTD";
            cell.cellLeftValueLabel.text = [NSString stringWithFormat:@"KES %ld", (long)_summary.monthlySalesValue];
            cell.cellRightTitleLabel.text = @"Month books YTD";
            cell.cellRightValueLabel.text = [NSString stringWithFormat:@"%ld", (long)_summary.monthlyBookingsValue];
            
        } break;
            
        case 2: {
            
            cell.cellLeftTitleLabel.text = @"Last week";
            cell.cellLeftValueLabel.text = [NSString stringWithFormat:@"KES %ld", (long)_summary.lastWeekSalesValue];
            cell.cellRightTitleLabel.text = @"Last week";
            cell.cellRightValueLabel.text = [NSString stringWithFormat:@"%ld", (long)_summary.lastWeekBookingsValue];
            
        } break;
            
        case 3: {
            
            cell.cellLeftTitleLabel.text = @"Next week";
            cell.cellLeftValueLabel.text = [NSString stringWithFormat:@"KES %ld", (long)_summary.nextWeekSalesValue];
            cell.cellRightTitleLabel.text = @"Next week";
            cell.cellRightValueLabel.text = [NSString stringWithFormat:@"%ld", (long)_summary.nextWeekBookingsValue];
            
        } break;
            
        default: break;
    }

    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"section text placeholder";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
