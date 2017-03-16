//
//  EKWelcomeViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/15/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKWelcomeViewController.h"

static NSString * const kOnboardingSegue = @"welcomeNewUserToOnboarding";
static NSString * const kSignInSegue = @"welcomeSignInToSignIn";

@implementation EKWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)didTapNewUserButton:(id)sender {
    
    [self performSegueWithIdentifier:kOnboardingSegue sender:nil];
}

- (IBAction)didTapSignInButton:(id)sender {
    
    [self performSegueWithIdentifier:kSignInSegue sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kOnboardingSegue]) {
        
    }
    
    if ([segue.identifier isEqualToString:kSignInSegue]) {
        
    }
}

@end
