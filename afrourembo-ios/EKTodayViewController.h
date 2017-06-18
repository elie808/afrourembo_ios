//
//  EKTodayViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/26/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTodayTableViewCell.h"
#import "EKTodayCollectionViewCell.h"
#import "Appointment.h"
#import "Today.h"

@interface EKTodayViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

// used to keep track of collectionViews scrolling positions/offsets
@property (strong, nonatomic) NSMutableDictionary *contentOffsetDictionary;

@end