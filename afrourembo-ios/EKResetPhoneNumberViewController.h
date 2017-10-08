//
//  EKResetPhoneNumberViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/8/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKExploreViewController.h"
#import "EKTextFieldTableViewCell.h"
#import "UIViewController+Helpers.h"
#import "EKSettings.h"
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSUInteger, ResetRole) {
    ResetRoleCustomer,
    ResetRoleSalon,
    ResetRoleBP
};

@interface EKResetPhoneNumberViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) ResetRole signInRole;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapResetButton:(id)sender;

@end
