//
//  EKPaymentViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "Booking.h"

@interface EKPaymentViewController : UIViewController <UIPageViewControllerDataSource, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) RLMResults<Booking *> *bookingsArray;
@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) NSArray *vcDataSource;

@end
