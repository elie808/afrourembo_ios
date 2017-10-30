//
//  EKClientDetailsViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKClientDetailsViewController.h"

static NSString * const kCell = @"clientDetailsCell";

@implementation EKClientDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.customerNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.passedCustomer.fName, self.passedCustomer.lName];
    self.customerVisitsLabel.text = @"";
    self.customerPhoneLabel.text = self.passedCustomer.phone;
    self.customerEmailLabel.text = self.passedCustomer.email;
    
    [self.customerProfilePicImageView yy_setImageWithURL:[NSURL URLWithString:self.passedCustomer.profilePicture]
                                             placeholder:[UIImage imageNamed:@"icPlaceholder"]
                                                 options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation
                                              completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Actions

- (IBAction)didTapCallButton:(id)sender {
    [self call:self.passedCustomer.phone];
}

- (IBAction)didTapSMSButton:(id)sender {
    [self sms:self.passedCustomer.phone];
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
