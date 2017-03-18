//
//  EKSplashViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/15/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSplashViewController.h"

static NSString * const kWelcomeSegue = @"splashToWelcome";

@implementation EKSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration: 2.0
                          delay: 2.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         
                     } completion:^(BOOL finished) {
                         
                         [self performSegueWithIdentifier:kWelcomeSegue sender:nil];
                     }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kWelcomeSegue]) {
        
    }
}

@end
