//
//  EKEditProfileBPViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 11/17/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EKTextFieldTableViewCell.h"

#import "Professional.h"
#import "EKSettings.h"

#import "Professional+API.h"
#import "Salon+API.h"
#import "ProfilePicture+API.h"
#import "UIImage+Helpers.h"
#import "UIViewController+Helpers.h"

#import <YYWebImage/YYWebImage.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface EKEditProfileBPViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapChageProfilePicture:(id)sender;
- (IBAction)didTapUpdateProfileButton:(id)sender;

@end
