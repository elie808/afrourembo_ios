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
    return [textField resignFirstResponder];
}

#pragma mark - Actions

- (IBAction)didTapSubmit:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Review postReviewForBooking:self.passedBooking.bookingId
                     withService:self.passedBooking.currentBookingId
                          rating:[NSNumber numberWithFloat:self.ratingSlider.value]
                       andReview:self.reviewTextField.text
                         forUser:[EKSettings getSavedCustomer].token
                       withBlock:^(Review *reviews) {
    
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [self performSegueWithIdentifier:KUnwind sender:nil];
                           
                       } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                      }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:KUnwind]) {
        
    }
}

@end
