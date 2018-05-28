//
//  EKSettingsBPViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKCompanyProfessionalCollectionViewCell.h"
#import "EKSettings.h"
#import "EKConstants.h"

#import "EKAvailabilityViewController.h"
#import "EKSalonInfoViewController.h"
#import "EKSalonSelectViewController.h"
#import "EKProfessionalInfoViewController.h"
#import "EKBPPaymentInfoTableViewController.h"

#import <YYWebImage/YYWebImage.h>

// UI menu items
static NSString * const kProfile  = @"Profile information";
static NSString * const kBusinessInfo   = @"Business information";
static NSString * const kSalonInfo      = @"Business information "; // DO NOT REMOVE SPACE AT THE END...MAJOREST OF HACKS RIGHT HERE!!
static NSString * const kManagePhotos   = @"Manage photos";
static NSString * const kServices = @"My services";
static NSString * const kAvailability = @"Availability";
static NSString * const kStaff        = @"Staff management";
static NSString * const kBankInfo     = @"Bank info";
static NSString * const kSalonBankInfo = @"Bank info";
static NSString * const kStaffPayment = @"Staff Payment";

// Segues
static NSString * const kWelcomeSegue   = @"bpSettingsToWelcomeVC";
static NSString * const kBusinessSegue  = @"settingsToProfileInfoVC";
static NSString * const kSalonInfoSegue = @"settingsToSalonInfoVC";
static NSString * const kGallerySegue   = @"settingsToGalleryVC";
static NSString * const kAvailabilitySegue = @"settingsToAvailabilityVC";
static NSString * const kAddServicesSegue  = @"settingsToAddServicesVC";
static NSString * const kProfileSegue   = @"settingsToEditProfileVC";
static NSString * const kStaffSegue     = @"bpSettingsToManageStaffVC";
static NSString * const kSalonListSegue    = @"settingsToSelectSalonVC";
static NSString * const kProPaymentInfoSegue = @"settingsToPaymentInfoVC";
static NSString * const kSalonPaymentInfoSegue = @"settingsToSalonPaymentInfoVC";
static NSString * const kStaffPaymentSegue = @"settingsToStaffPaymentVC";


@interface EKSettingsBPViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *tableViewDataSource;
@property (strong, nonatomic) NSArray *collectionViewDataSource;

- (IBAction)didTapLogOutButton:(id)sender;
- (IBAction)unwindToBpSettingsVC:(UIStoryboardSegue *)segue;

@end
