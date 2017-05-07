//
//  EKAddServiceViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKAddNewServiceViewController.h"
#import "EKAccessoryTableViewCell.h"
#import "Service.h"

@interface EKAddServiceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EKAccessoryCellDelegate>

@property (strong, nonatomic) NSMutableArray *dataSourceArray;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
