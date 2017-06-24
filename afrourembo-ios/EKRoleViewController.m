//
//  EKRoleViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKRoleViewController.h"

static NSString * const kCustomerSignInSegue = @"roleToSignInCustomer";
static NSString * const kSalonSignInSegue    = @"roleToSignInSalon";
static NSString * const kBPSignInSegue       = @"roleToSignInBP";

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

///// SIGN IN ROLES

- (IBAction)didTapSignInCustomer:(id)sender {
    [self performSegueWithIdentifier:kCustomerSignInSegue sender:nil];
}

- (IBAction)didTapSignInSalon:(id)sender {
    [self performSegueWithIdentifier:kSalonSignInSegue sender:nil];
}

- (IBAction)didTapSignInBP:(id)sender {
    [self performSegueWithIdentifier:kBPSignInSegue sender:nil];
}

///// SIGN UP ROLES

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

    //-- sign in
    
    if ([segue.identifier isEqualToString:kCustomerSignInSegue]) {
        EKSignInViewController *vc = segue.destinationViewController;
        vc.signInRole = SignInRoleCustomer;
    }
    
    if ([segue.identifier isEqualToString:kSalonSignInSegue]) {
        EKSignInViewController *vc = segue.destinationViewController;
        vc.signInRole = SignInRoleSalon;
    }
    
    if ([segue.identifier isEqualToString:kBPSignInSegue]) {
        EKSignInViewController *vc = segue.destinationViewController;
        vc.signInRole = SignInRoleBP;
    }
    
    //-- business model | No longer redirects to Business Model VCs. Keeping it as is, while higher power decide
    
    if ([segue.identifier isEqualToString:kWorkAloneBP]) {
//        EKBusinessModelViewController *vc = segue.destinationViewController;
//        vc.BusinessModelUser = BusinessModelUserIndependentBP;
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        vc.passedProfessional = self.passedProfessional;
    }
    
    if ([segue.identifier isEqualToString:kWorkInSalonBP]) {
//        EKBusinessModelViewController *vc = segue.destinationViewController;
//        vc.BusinessModelUser = BusinessModelUserWorksInSalonBP;
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        vc.passedProfessional = self.passedProfessional;
    }
}

@end
