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

    if ([EKSettings getSavedVendor]) {
        
        self.tableViewDataSource = @[
                                     kProfile,
                                     kBusinessInfo,
                                     kManagePhotos,
                                     kServices,
                                     kAvailability
                                     ];
        
        self.collectionViewDataSource = [NSArray arrayWithArray:[EKSettings getSavedVendor].partOf];
        
    } else if ([EKSettings getSavedSalon]) {
    
        self.tableView.tableHeaderView = nil;
        
        self.tableViewDataSource = @[
                                     kProfile,
                                     kSalonInfo,
                                     kManagePhotos,
                                     kStaff
                                     ];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self.tabBarController.tabBar.items objectAtIndex:kSettingsVCIndex] setBadgeValue:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kSalonListSegue]) {
        
        UINavigationController *navController = [segue destinationViewController];
        EKSalonSelectViewController *vc = (EKSalonSelectViewController *)([navController viewControllers][0]);
        vc.passedProfessional = [EKSettings getSavedVendor];
        vc.unwindSegue = @"unwindFromSalonListToBPSettingsVC";
    }
    
    if ([segue.identifier isEqualToString:kSalonInfoSegue]) {
        
        UINavigationController *navController = [segue destinationViewController];
        EKSalonInfoViewController *vc = (EKSalonInfoViewController *)([navController viewControllers][0]);
        vc.unwindSegueID = @"unwindFromSalonInfoToBPSettingsVC";
    }
    
    if ([segue.identifier isEqualToString:kBusinessSegue]) {
     
        UINavigationController *navController = [segue destinationViewController];
        EKProfessionalInfoViewController *vc = (EKProfessionalInfoViewController *)([navController viewControllers][0]);
        vc.barButton.title = @"Done";
        vc.unwindSegueID = @"unwindToBpSettingsVC";
    }

    if ([segue.identifier isEqualToString:kAddServicesSegue]) {
    
        UINavigationController *navController = [segue destinationViewController];
        EKAddServiceViewController *vc = (EKAddServiceViewController *)([navController viewControllers][0]);
        vc.barButton.title = @"Done";
        vc.passedProfessional = [EKSettings getSavedVendor];
        vc.unwindSegueID = @"unwindAddServicesToBPSettings";
    }
    
    if ([segue.identifier isEqualToString:kGallerySegue]) {
        
    }
    
    if ([segue.identifier isEqualToString:kAvailabilitySegue]) {
        
        UINavigationController *navController = [segue destinationViewController];
        EKAvailabilityViewController *vc = (EKAvailabilityViewController *)([navController viewControllers][0]);
        vc.isInEditMode = YES;
        vc.passedProfessional = [EKSettings getSavedVendor];
    }
    
    if ([segue.identifier isEqualToString:kStaffSegue]) {
        
    }
}

- (IBAction)unwindToBpSettingsVC:(UIStoryboardSegue *)segue {}

#pragma mark - Actions

- (IBAction)didTapLogOutButton:(id)sender {
    
    [EKSettings deleteSavedVendor];
    [EKSettings deleteSavedSalon];
    [self performSegueWithIdentifier:kWelcomeSegue sender:nil];
}

@end
