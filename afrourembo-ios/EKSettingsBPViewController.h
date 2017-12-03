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

#import "EKAvailabilityViewController.h"
#import "EKProfessionalInfoViewController.h"

#import <YYWebImage/YYWebImage.h>

static NSString * const kProfile  = @"Profile information";
static NSString * const kBusinessInfo   = @"Business information";
static NSString * const kManagePhotos   = @"Manage photos";
static NSString * const kServices = @"My services";
static NSString * const kAvailability = @"Availability";
static NSString * const kStaff        = @"Manage staff";

// Segues
static NSString * const kWelcomeSegue   = @"bpSettingsToWelcomeVC";
static NSString * const kBusinessSegue  = @"settingsToProfileInfoVC";
static NSString * const kGallerySegue   = @"settingsToGalleryVC";
static NSString * const kAvailabilitySegue = @"settingsToAvailabilityVC";
static NSString * const kAddServicesSegue  = @"settingsToAddServicesVC";
static NSString * const kProfileSegue   = @"settingsToEditProfileVC";
static NSString * const kStaffSegue     = @"bpSettingsToManageStaffVC";

@interface EKSettingsBPViewController : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *tableViewDataSource;
@property (strong, nonatomic) NSArray *collectionViewDataSource;

- (IBAction)didTapLogOutButton:(id)sender;
- (IBAction)unwindToBpSettingsVC:(UIStoryboardSegue *)segue;

@end
