//
//  EKConfirmPhoneNumberViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKResetPhoneNumberViewController.h"
#import "EKTextFieldTableViewCell.h"
#import "UIViewController+Helpers.h"
#import "EKSettings.h"
#import "Customer+API.h"
#import "ProfessionalLogin+API.h"
#import "SalonLogin+API.h"
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSUInteger, PhoneConfirmRole) {
    PhoneConfirmRoleCustomer,
    PhoneConfirmRoleSalon,
    PhoneConfirmRoleBP
};

@interface EKConfirmPhoneNumberViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) PhoneConfirmRole signInRole;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapConfirmButton:(id)sender;

@end
