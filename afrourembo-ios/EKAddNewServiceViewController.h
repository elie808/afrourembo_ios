//
//  EKAddNewServiceViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKAddServiceViewController.h"
#import "EKAddNewServiceTableViewCell.h"
#import "Service.h"
#import "ServiceCategory.h"

@interface EKAddNewServiceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) Service *passedService;
@property (strong, nonatomic) Service *serviceToEdit; // to be passed down to presented segues, and edited by unwinding vc's

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *removeServiceButton;

- (IBAction)unwingToAddNewServiceVC:(UIStoryboardSegue *)segue;

@end
