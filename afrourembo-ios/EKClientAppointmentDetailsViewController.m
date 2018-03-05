//
//  EKClientAppointmentDetailsViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 1/18/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKClientAppointmentDetailsViewController.h"

@implementation EKClientAppointmentDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.clientProfilePictureImageView yy_setImageWithURL:[NSURL URLWithString:self.passedAppointment.clientProfilePicture]
                                                   options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    self.clientNameLabel.text = self.passedAppointment.clientName;
    self.serviceNameLabel.text = self.passedAppointment.serviceDescription;
    self.clientPhoneNumberLabel.text = self.passedAppointment.clientPhone;
    self.noteLabel.text = self.passedAppointment.serviceNote;
}

#pragma mark - Actions

- (IBAction)didTapPhoneButton:(UIButton *)sender {
    [self call:self.passedAppointment.clientPhone];
}

- (IBAction)didTapSMSButton:(UIButton *)sender {
    [self sms:self.passedAppointment.clientPhone];
}

#pragma mark - Helpers

- (void)call:(NSString *)phoneNumber {
    
    NSString *unspacedPhoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", unspacedPhoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneNumberURL]) {
        
        [[UIApplication sharedApplication] openURL:phoneNumberURL];
        
    } else {
        
    }
}

- (void)sms:(NSString *)phoneNumber {
    
    NSString *unspacedPhoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *messageURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", unspacedPhoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:messageURL]) {
        
        [[UIApplication sharedApplication] openURL:messageURL];
        
    } else {
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
