//
//  EKScheduleMonthlyViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/28/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FSCalendar.h"
#import "EKTodayTableViewCell.h"
#import "EKTodayCollectionViewCell.h"

#import "Today.h"
#import "EKSettings.h"

#import "Dashboard+API.h"
#import <DateTools/DateTools.h>

@interface EKScheduleMonthlyViewController : UIViewController

/// calendar data source. Used to store the downloaded Dashboard items
@property (strong , nonatomic) NSMutableArray *dataSource;

/// daily schedule/calendar view's data source
@property (strong , nonatomic) NSMutableArray *tableDataSource;

@property (weak , nonatomic) IBOutlet FSCalendar *calendar;
@property (weak , nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *contentOffsetDictionary;

@end
