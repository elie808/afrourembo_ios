//
//  EKRoleViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKRoleViewController.h"

static NSString * const kCustomerSignUpSegue = @"roleCustomerToSignUpCustomer";

@implementation EKRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select your role";
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
