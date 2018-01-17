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

    if ([EKSettings getSavedVendor]) {
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Dashboard getDashboardOfVendor:[EKSettings getSavedVendor].token
                              withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                  
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self configureChildrenWith:dashboardItems];
                                  
                              } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                 
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                  
                             }];
        
        [Professional getClientsForProfessional:[EKSettings getSavedVendor].token
                                      withBlock:^(NSArray<Customer *> *customersArray) {

                                          [self configureClientsVC:customersArray];
                                          
                                      } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {

                                          [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                      }];
        
    } else if ([EKSettings getSavedSalon]) {
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Dashboard getDashboardOfSalon:[EKSettings getSavedSalon].token
                             withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                 
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 [self configureChildrenWith:dashboardItems];
                                 
                             } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                 
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                             }];
        
        [Professional getClientsForSalon:[EKSettings getSavedSalon].token
                               withBlock:^(NSArray<Customer *> *customersArray) {

                                   [self configureClientsVC:customersArray];
                                
                               } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                   
                                   [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                               }];
        
        [Salon getJoinRequestsForSalon:[EKSettings getSavedSalon].token
                             withBlock:^(NSArray<JoinSalonRequest *> *joinRequestsArray) {
                                 
                                 if (joinRequestsArray.count > 0) {
                                 
                                     [[self.tabBar.items objectAtIndex:kSettingsVCIndex]
                                      setBadgeValue:[NSString stringWithFormat:@"%lu", (unsigned long)joinRequestsArray.count]];
                                 }
                                 
                             } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                 
                                 [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                             }];
        
    }
}

#pragma mark - Helpers

- (void)configureChildrenWith:(NSArray <Dashboard*> *)dashboardItems {
    
    if ([[[self viewControllers] objectAtIndex:kTodayVCIndex] isKindOfClass:[EKTodayViewController class]] ) {
        
        // kept to display a tab controller badge
        EKTodayViewController *vc = [[self viewControllers] objectAtIndex:kTodayVCIndex];
        [vc configureWithDashboardItems:dashboardItems];
    }
    
    if ([[[self viewControllers] objectAtIndex:kScheduleVCIndex] isKindOfClass:[EKScheduleMonthlyViewController class]] ) {
        
        // kept to display a tab controller badge
        EKScheduleMonthlyViewController *vc = [[self viewControllers] objectAtIndex:kScheduleVCIndex];
        [vc configureWithDashboardItems:dashboardItems];
    }
    
    if ([[[self viewControllers] objectAtIndex:kDashboardVCIndex] isKindOfClass:[EKDashboardViewController class]] ) {

        // useless
//        EKDashboardViewController *vc = [[self viewControllers] objectAtIndex:kDashboardVCIndex];
//        [vc configureWithDashboardItems:dashboardItems];
    }
    
    if ([[[self viewControllers] objectAtIndex:kSettingsVCIndex] isKindOfClass:[EKSettingsBPViewController class]] ) {
        
//        EKSettingsBPViewController *vc = [[self viewControllers] objectAtIndex:kSettingsVCIndex];
    }
}

- (void)configureClientsVC:(NSArray<Customer *> *)customersArray {
    
//    if ( [[[self viewControllers] objectAtIndex:kClientsVCIndex]
//          isKindOfClass:[UINavigationController class]] ) {
//        
//        UINavigationController *navController = [[self viewControllers] objectAtIndex:kClientsVCIndex];
//        
//        EKClientsViewController *vc = (EKClientsViewController *)([navController viewControllers][0]);
//        [vc configureWithDashboardItems:customersArray];
//    }
}

/*
- (void)handleVendorAvailabilityErrors:(NSError *)error errorMessage:(NSString *)errorMessage statusCode:(NSInteger) statusCode {
    
    if (statusCode == 401) { // invalid token
        
        [self showLoginDialog:^(UIAlertAction *action, NSString *emailString, NSString *passString) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [Customer loginCustomer:emailString
                           password:passString
                          withBlock:^(Customer *customerObj) {
                              
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              [EKSettings saveCustomer:customerObj];
                          }
                         withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                             
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [self showMessage:errorMessage withTitle:@"There is something wrong"
                               completionBlock:nil];
                         }];
            
        } andSignUpBlock:^(UIAlertAction *action) {
            
            [EKSettings deleteBookingsForCustomer:[EKSettings getSavedCustomer]];
            [EKSettings deleteSavedCustomer];
            [self performSegueWithIdentifier:kSignUpSegue sender:nil];
        }];
        
    } else {
        
        [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
    }
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
