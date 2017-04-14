//
//  EKNavigationViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKNavigationViewController.h"

@interface EKNavigationViewController ()

@end

@implementation EKNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"icBack"]
                                   style:UIBarButtonItemStylePlain
                                   target:nil
                                   action:nil];
    
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
