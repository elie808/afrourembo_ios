//
//  EKRoleViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKBusinessModelViewController.h"
#import "EKSignInViewController.h"

@interface EKRoleViewController : UIViewController

- (IBAction)didTapSignInCustomer:(id)sender;
- (IBAction)didTapSignInSalon:(id)sender;
- (IBAction)didTapSignInBP:(id)sender;

- (IBAction)didTapSignupCustomer:(id)sender;
- (IBAction)didTapSignupSalon:(id)sender;
- (IBAction)didTapSignupBP:(id)sender;

- (IBAction)didTapBPWorkAlone:(id)sender;
- (IBAction)didTapBPWorkSalon:(id)sender;

@end
