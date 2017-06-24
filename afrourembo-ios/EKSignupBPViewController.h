//
//  EKSignupBPViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextFieldTableViewCell.h"
#import "Professional.h"
#import "Professional+API.h"
#import "EKRoleViewController.h"
#import "UIViewController+Helpers.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface EKSignupBPViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapSignUpButton:(id)sender;

@end
