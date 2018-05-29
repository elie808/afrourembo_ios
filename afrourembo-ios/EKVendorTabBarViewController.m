//
//  EKVendorTabBarViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 12/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKVendorTabBarViewController.h"

static NSString * const kBankPaymentInfoSegue = @"vendorTabCtrlToBPPaymentInfoVC";
static NSString * const kEditSalonPaymentInfoSegue = @"vendorTabCtrlToSalonPaymentInfoVC";

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([EKSettings getSavedVendor]) {
        
        [Professional getProfileForProfessional:[EKSettings getSavedVendor].token
                                      withBlock:^(Professional *professionalObj) {
                                          
                                          [EKSettings updateSavedProfessional:professionalObj];
                                          
                                          //TODO: Check paymentInfoComplete flag value
                                          if (!professionalObj.paymentInfoComplete) {
                                              NSLog(@"\n \n \n \n \n \n !!!!!!! PAYMENT INFO INCOMPLETE !!!!!!! \n \n \n \n \n \n");
                                              [self performSegueWithIdentifier:kBankPaymentInfoSegue sender:nil];
                                          } else {
                                              NSLog(@"\n \n \n \n \n \n !!!!!!! PAYMENT COMPLETE :) !!!!!!! \n \n \n \n \n \n");
                                          }
                                          
                                      } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                          
                                      }];

        
    } else if ([EKSettings getSavedSalon]) {
        
        [Salon getProfileForSalon:[EKSettings getSavedSalon].token
                        withBlock:^(Salon *salonObj) {
                            
                            //TODO: Check paymentInfoComplete flag value
                            if (!salonObj.paymentInfoComplete) {
                                NSLog(@"\n \n \n \n \n \n !!!!!!! PAYMENT INFO INCOMPLETE !!!!!!! \n \n \n \n \n \n");
                                [self performSegueWithIdentifier:kEditSalonPaymentInfoSegue sender:nil];
                            }
                            
                        } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                            
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kBankPaymentInfoSegue]) {
        
        UINavigationController *navController = [segue destinationViewController];
        EKBPPaymentInfoTableViewController *vc = (EKBPPaymentInfoTableViewController *)([navController viewControllers][0]);
        vc.passedProfessional = [EKSettings getSavedVendor];
        vc.unwindSegueID = @"unwindBankInfoToBPSettings";
    }
    
    if ([segue.identifier isEqualToString:kEditSalonPaymentInfoSegue]) {
        
        UINavigationController *navController = [segue destinationViewController];
        EKBPPaymentInfoTableViewController *vc = (EKBPPaymentInfoTableViewController *)([navController viewControllers][0]);
        vc.passedSalon = [EKSettings getSavedSalon];
        vc.unwindSegueID = @"unwindBankInfoToBPSettings";
    }
}

@end
