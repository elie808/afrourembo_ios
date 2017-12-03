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
    self.dataSource = [NSMutableArray new];
    self.tableDataSource = [NSMutableArray new];
    self.contentOffsetDictionary = [NSMutableDictionary new];
    
    [self createCalendarGrid];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([EKSettings getSavedVendor]) {
     
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Dashboard getDashboardOfVendor:[EKSettings getSavedVendor].token
                              withBlock:^(NSArray<Dashboard *> *dashboardItems) {
        
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self.dataSource removeAllObjects];
                                  [self.dataSource addObjectsFromArray:dashboardItems];
                                  [self.calendar reloadData];
                                  
                              } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                  
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                              }];
        
    } else if ([EKSettings getSavedSalon]) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
