//
//  EKSalesSummaryViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKSalesSummaryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
