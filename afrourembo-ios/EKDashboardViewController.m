//
//  EKDashboardViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDashboardViewController.h"

static NSInteger const kViewCount = 3;

@implementation EKDashboardViewController {
    NSUInteger _index;
    NSArray <Dashboard *> *_dashboardItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dashboardItems = [NSArray new];
    _index = 0;
    
    // Create PageViewController
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    self.pageViewController.dataSource = self;
    
    EKSalesSummaryViewController *startingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"content1"];
//    startingViewController.summaryDataSource = _summaryObj;
    [self.pageViewController setViewControllers:@[startingViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([EKSettings getSavedVendor]) {
     
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Dashboard getDashboardOfVendor:[EKSettings getSavedVendor].token
                              withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                  
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  
                                  _dashboardItems = dashboardItems;
                                  
                                  [[NSNotificationCenter defaultCenter] postNotificationName:kDashboardNotification
                                                                                      object:nil
                                                                                    userInfo:[NSDictionary dictionaryWithObject:dashboardItems forKey:kDashObjKey]];
                                  
                              } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                  
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                              }];
        
    } else if ([EKSettings getSavedSalon]) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Dashboard getDashboardOfSalon:[EKSettings getSavedSalon].token
                             withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                 
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 
                                 _dashboardItems = dashboardItems;
                                 
                                 [[NSNotificationCenter defaultCenter] postNotificationName:kDashboardNotification
                                                                                     object:nil
                                                                                   userInfo:[NSDictionary dictionaryWithObject:dashboardItems forKey:kDashObjKey]];
                                 
                             } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                            }];
        
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSLog(@"\n");
    NSLog(@"ViewBEFORE - Index: %lu", (unsigned long)_index);
    
    if (_index > 0) {
        _index--;
        NSLog(@"Index-- %lu", (unsigned long)_index);
    } else {
        NSLog(@"ViewBEFORE - RETURN NIL");
        return nil;
    }
    
    return [self viewControllerAtIndex:_index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSLog(@"\n");
    NSLog(@"ViewAFTER - Index: %lu", (unsigned long)_index);

    if (_index < kViewCount - 1) {//view count - 1
        _index++;
        NSLog(@"Index++ %lu", (unsigned long)_index);
    } else {
        NSLog(@"ViewAFTER - RETURN NIL");
        return nil;
    }
    
    return [self viewControllerAtIndex:_index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
//    if ((index > 1) || (index == NSNotFound)) {
//        return nil;
//    }
    
    NSLog(@"SUPPLY VIEW AT INDEX: %lu", (unsigned long)index);
    
    switch (index) {
            
        case 0: {
            
            EKSalesSummaryViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"content1"];
            vc.dataSource = _dashboardItems;
            return vc;
            
        } break;
            
        case 1: {
          
            EKChartSummaryViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"content2"];
//            vc.view.backgroundColor = [UIColor redColor];
            return vc;
            
        } break;
        
        case 2: {
            
            EKServicesChartViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"content3"];
            return vc;
            
        } break;
            
        default: return nil; break;
    }
}

#pragma mark - Actions

- (IBAction)didTapFilterButton:(UIBarButtonItem *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log out ?"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *Logout = [UIAlertAction actionWithTitle:@"Log out"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                       [self performSegueWithIdentifier:@"dashboardToWelcomeVC" sender:nil];
                                                   }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {}];
    
    [alertController addAction:Logout];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:^{}];
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
