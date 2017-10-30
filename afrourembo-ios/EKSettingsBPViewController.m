//
//  EKSettingsBPViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSettingsBPViewController.h"

@implementation EKSettingsBPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableViewDataSource = @[
//                    @"Check my public profile",
//                    @"Explore services",
//                    @"Profile information",
//                    @"Business information",
//                    @"Manage photos",
//                    @"My services",
//                    @"Availability",
//                    @"Social accounts",
//                    @"Billing information",
//                    @"Notifications",
//                    @"Export financial data",
//                    @"Share app",
//                    @"Rate us",
//                    @"Terms & conditions",
//                    @"Privacy policy",
//                    @"About",
//                    @"Feedback"
//                    ];

    self.tableViewDataSource = @[
//                                 kProfile,
                                 kBusinessInfo,
                                 kManagePhotos
//                                 kServices,
//                                 kAvailability
                                 ];
    
    self.collectionViewDataSource = @[];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kBusinessSegue]) {
     
        UINavigationController *navController = [segue destinationViewController];
        EKProfessionalInfoViewController *vc = (EKProfessionalInfoViewController *)([navController viewControllers][0]);
        vc.barButton.title = @"Done";
        vc.unwindSegueID = @"unwindToBpSettingsVC";
    }
    
    if ([segue.identifier isEqualToString:kGallerySegue]) {
        
    }
}

- (IBAction)unwindToBpSettingsVC:(UIStoryboardSegue *)segue {}

#pragma mark - Actions

- (IBAction)didTapLogOutButton:(id)sender {
    
    [EKSettings deleteSavedVendor];
    [self performSegueWithIdentifier:kWelcomeSegue sender:nil];
}

@end
