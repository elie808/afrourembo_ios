//
//  EKScheduleMonthlyViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/28/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKScheduleMonthlyViewController.h"
#import "EKScheduleMonthlyViewController+TableView.h"

@implementation EKScheduleMonthlyViewController  {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray new];
    self.tableDataSource = [NSMutableArray new];
    self.contentOffsetDictionary = [NSMutableDictionary new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self.tabBarController.tabBar.items objectAtIndex:kScheduleVCIndex] setBadgeValue:nil];
    
    if ([EKSettings getSavedVendor]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Dashboard getDashboardOfVendor:[EKSettings getSavedVendor].token
                              withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                  
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self.dataSource addObjectsFromArray:dashboardItems];
                                  [self.calendar reloadData];
                                  [self createCalendarGrid];
                                  
                              } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                              }];
        
    } else if ([EKSettings getSavedSalon]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Dashboard getDashboardOfSalon:[EKSettings getSavedSalon].token
                             withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                 
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 [self.dataSource addObjectsFromArray:dashboardItems];
                                 [self.calendar reloadData];
                                 [self createCalendarGrid];
                                 
                             } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                             }];
    }
}

#pragma mark - FSCalendar

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
//    self.calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    // Do other updates here
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
 
    NSMutableArray *temp = [NSMutableArray new];
    
    for (Dashboard *dashObj in _dataSource) {
        
        if ([dashObj.startDate isSameDay:date]) {
            
            [temp addObject:dashObj];
        }
    }

    [self populateCalendarWithDashObjects:temp forDate:date];
    [self.tableView reloadData];
}

- (BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)date {
    
    for (Dashboard *dashObj in _dataSource) {
        
        if ([dashObj.startDate isSameDay:date]) {
            
            return YES;  
        }
    }
    
    return NO;
}

#pragma mark - Helpers

- (void)configureWithDashboardItems:(NSArray<Dashboard *> *)dashboardItemsArray {
    
    if (dashboardItemsArray && dashboardItemsArray.count > 0) {
        
        [self.dataSource removeAllObjects];

        NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];

        // used to display number as a badge on tab
        NSInteger appointementsToday = 0;
        
        for (Dashboard *dashObj in dashboardItemsArray) {
            
            // if the startDate is today
            if ([dashObj.startDate daysFrom:todayDate] == 0) {
                appointementsToday ++;
            }
        }

        [self.dataSource addObjectsFromArray:dashboardItemsArray];
        [self.calendar reloadData];
        
        // update tab bar badge
        if (appointementsToday > 0) {
            [[self.tabBarController.tabBar.items objectAtIndex:kTodayVCIndex]
             setBadgeValue:[NSString stringWithFormat:@"%ld", (long)appointementsToday]];
        }
    }
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
