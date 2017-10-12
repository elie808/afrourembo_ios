//
//  EKSettingsBPViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSettingsBPViewController.h"

static NSString * const kWelcomeSegue  = @"bpSettingsToWelcomeVC";

@implementation EKSettingsBPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[
                    @"Check my public profile",
                    @"Explore services",
                    @"Profile information",
                    @"Business information",
                    @"Manage photos",
                    @"My services",
                    @"Availability",
                    @"Social accounts",
                    @"Billing information",
                    @"Notifications",
                    @"Export financial data",
                    @"Share app",
                    @"Rate us",
                    @"Terms & conditions",
                    @"Privacy policy",
                    @"About",
                    @"Feedback"
                    ];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

#pragma mark - Actions

- (IBAction)didTapLogOutButton:(id)sender {
    
    [EKSettings deleteSavedVendor];
    [self performSegueWithIdentifier:kWelcomeSegue sender:nil];
}

@end
