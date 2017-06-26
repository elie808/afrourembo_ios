//
//  EKSignupViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/18/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextFieldTableViewCell.h"
#import "Customer+API.h"
#import "EKEditProfileInfoViewController.h"
#import "UIViewController+Helpers.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface EKSignupViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *fbLoginButton;

- (IBAction)didTapSignUpButton:(id)sender;
- (IBAction)didTapFBSignUpButton:(id)sender;

@end
