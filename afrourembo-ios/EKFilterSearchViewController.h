//
//  EKSearchFilterViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKFilterSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
