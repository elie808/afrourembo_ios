//
//  EKVendorTabBarViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 12/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKVendorTabBarViewController.h"

@implementation EKVendorTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Dashboard getDashboardOfSalon:[EKSettings getSavedSalon].token
                         withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                             
                             if ([[[self viewControllers] objectAtIndex:kTodayVCIndex] isKindOfClass:[EKTodayViewController class]] ) {
                                 
                                 EKTodayViewController *vc = [[self viewControllers] objectAtIndex:kTodayVCIndex];
                                 [vc configureWithDashboardItems:dashboardItems];
                             }
                             
                             if ([[[self viewControllers] objectAtIndex:kScheduleVCIndex] isKindOfClass:[EKScheduleMonthlyViewController class]] ) {
                                 EKScheduleMonthlyViewController *vc = [[self viewControllers] objectAtIndex:kScheduleVCIndex];
                             }
                             
                             if ([[[self viewControllers] objectAtIndex:2] isKindOfClass:[EKDashboardViewController class]] ) {
                                 EKDashboardViewController *vc = [[self viewControllers] objectAtIndex:2];
                             }
                             
                             if ([[[self viewControllers] objectAtIndex:4] isKindOfClass:[EKSettingsBPViewController class]] ) {
                                 EKSettingsBPViewController *vc = [[self viewControllers] objectAtIndex:4];
                             }
                             
                         } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                             
                             [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                         }];
    
    
    // TODO: EKClientsViewController is embedded in a navigationController. Handle accordingly.
    
    
//    if ([EKSettings getSavedVendor]) {
//        
//        [Professional getClientsForProfessional:[EKSettings getSavedVendor].token
//                                      withBlock:^(NSArray<Customer *> *customersArray) {
//                                          
//                                      } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
//                                          
//                                          [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
//                                      }];
//        
//    } else if ([EKSettings getSavedSalon]) {
//        
//        [Professional getClientsForSalon:[EKSettings getSavedSalon].token
//                               withBlock:^(NSArray<Customer *> *customersArray) {
//                                   
//                              
//                                   
//                               } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
//                                   
//                                   [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
//                               }];
//    }
    
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
