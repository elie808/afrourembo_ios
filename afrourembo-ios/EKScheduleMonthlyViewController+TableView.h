//
//  EKScheduleMonthlyViewController+TableView.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/12/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKScheduleMonthlyViewController.h"

@interface EKScheduleMonthlyViewController (TableView) <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

- (void)createCalendarGrid;
//- (void)populateCalendarWithDashObjects:(NSArray *)dashboardItems;
- (void)populateCalendarWithDashObjects:(NSArray *)dashboardItems forDate:(NSDate *)date;

@end
