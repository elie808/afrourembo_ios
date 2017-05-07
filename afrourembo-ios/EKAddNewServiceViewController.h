//
//  EKAddNewServiceViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKAddServiceViewController.h"
#import "Service.h"
#import "EKAddNewServiceTableViewCell.h"

@interface EKAddNewServiceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Service *passedService;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *removeServiceButton;

@end
