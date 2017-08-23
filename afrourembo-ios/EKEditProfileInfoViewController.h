//
//  EKEditProfileInfoViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/24/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EKTextFieldTableViewCell.h"
#import "Customer.h"
#import "EKSettings.h"

#import "Customer+API.h"
#import "ProfilePicture+API.h"

#import "UIImage+Helpers.h"
#import "UIViewController+Helpers.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface EKEditProfileInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) Customer *passedUser;

@property (strong, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapChageProfilePicture:(id)sender;
- (IBAction)didTapSubmitButton:(id)sender;

@end
