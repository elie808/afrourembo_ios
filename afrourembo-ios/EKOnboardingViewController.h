//
//  EKOnboardingViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/15/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EAIntroView/EAIntroView.h>

@interface EKOnboardingViewController : UIViewController <EAIntroDelegate>

@property(nonatomic,weak) IBOutlet EAIntroView *introView;

- (IBAction)didTapSignUpButton:(id)sender;

@end
