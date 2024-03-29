//
//  EKSignupBPViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EKRoleViewController.h"

#import "EKTextFieldTableViewCell.h"

#import "Professional.h"
#import "EKSalonInfoViewController.h"

#import "Professional+API.h"
#import "ProfilePicture+API.h"
#import "UIViewController+Helpers.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSUInteger, SignUpRole) {
    SignUpRoleSalon,
    SignUpRoleBP
};

@interface EKSignupBPViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (assign, nonatomic) SignUpRole signUpRole;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapChageProfilePicture:(id)sender;
- (IBAction)didTapSignUpButton:(id)sender;
- (IBAction)didTapFacebookSignUpButton:(id)sender;

@end
