//
//  EKRatingViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 11/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKRatingViewController.h"

static NSString * const KUnwind = @"unwindToOrders";

@implementation EKRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.serviceNameLabel.text = self.passedBooking.service;
    self.salonNameLabel.text = self.passedBooking.actorBusinessName;
    self.professionalNameLabel.text = self.passedBooking.professionalBusinessName;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

#pragma mark - Actions

- (IBAction)didTapSubmit:(id)sender {
    
    //    self.ratingSlider.value = 0;
    //    self.reviewTextField.text = @"";
    
    [self performSegueWithIdentifier:KUnwind sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:KUnwind]) {
        
    }
}

@end
