//
//  EKRoleViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKRoleViewController.h"

static NSString * const kCustomerSignUpSegue = @"roleToSignUpCustomer";
static NSString * const kSalonSignUpSegue    = @"roleToSignUpSalon";
static NSString * const kBPSignUpSegue       = @"roleToSignUpBP";

static NSString * const kWorkAloneBP     =  @"aloneRoleVCToBusinessModelVC";
static NSString * const kWorkInSalonBP   =  @"salonRoleVCToBusinessModelVC";

@implementation EKRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select your role";
}

#pragma mark - Actions

- (IBAction)didTapSignupCustomer:(id)sender {
    [self performSegueWithIdentifier:kCustomerSignUpSegue sender:nil];
}

- (IBAction)didTapSignupSalon:(id)sender {
    [self performSegueWithIdentifier:kSalonSignUpSegue sender:nil];
}

- (IBAction)didTapSignupBP:(id)sender {
    [self performSegueWithIdentifier:kBPSignUpSegue sender:nil];
}

///// For BP flow

- (IBAction)didTapBPWorkAlone:(id)sender {

    [self performSegueWithIdentifier:kWorkAloneBP sender:nil];
}

- (IBAction)didTapBPWorkSalon:(id)sender {
    [self performSegueWithIdentifier:kWorkInSalonBP sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EKBusinessModelViewController *vc = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:kWorkAloneBP]) {
        vc.BusinessModelUser = BusinessModelUserIndependentBP;
    }
    
    if ([segue.identifier isEqualToString:kWorkInSalonBP]) {
        vc.BusinessModelUser = BusinessModelUserWorksInSalonBP;
    }
}

@end
