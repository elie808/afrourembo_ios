//
//  EKCheckoutSuccessViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/8/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCheckoutSuccessViewController.h"

@implementation EKCheckoutSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // hide back button
    self.navigationItem.hidesBackButton = YES;
    
    // hide navigation bar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
