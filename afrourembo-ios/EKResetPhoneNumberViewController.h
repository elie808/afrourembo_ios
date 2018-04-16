//
//  EKResetPhoneNumberViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/8/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKExploreViewController.h"
#import "SalonLogin+API.h"
#import "EKTextFieldTableViewCell.h"
#import "EKSettings.h"
#import "UIViewController+Helpers.h"
#import "UITextField+Helpers.h"
#import "NSString+Helpers.h"
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSUInteger, ResetRole) {
    ResetRoleCustomer,
    ResetRoleSalon,
    ResetRoleBP
};

@interface EKResetPhoneNumberViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (assign, nonatomic) ResetRole signInRole;
@property (strong, nonatomic) NSString *passedPhoneNumber;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapResetButton:(id)sender;

@end
