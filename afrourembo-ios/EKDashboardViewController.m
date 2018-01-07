//
//  EKDashboardViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDashboardViewController.h"

//static NSInteger const kViewCount = 3;

@implementation EKDashboardViewController {
    NSUInteger _index;
    NSArray <Dashboard *> *_dashboardItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dashboardItems = [NSArray new];
    _index = 0;
    
    /*
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
     */
    
    if ([EKSettings getSavedVendor]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Dashboard getDashboardOfVendor:[EKSettings getSavedVendor].token
                              withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                  
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  
                              } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                              }];
        
    } else if ([EKSettings getSavedSalon]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Dashboard getDashboardOfSalon:[EKSettings getSavedSalon].token
                             withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                 
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 
                             } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                             }];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKSalesSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SummaryCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0: {
            
            cell.cellLeftTitleLabel.text = @"Total sales";
            cell.cellLeftValueLabel.text = @"KES 619"; //[NSString stringWithFormat:@"KES %ld", (long)_summary.totalSalesValue];
            cell.cellRightTitleLabel.text = @"Total books";
            cell.cellRightValueLabel.text = @"69"; //[NSString stringWithFormat:@"%ld", (long)_summary.totalBookingsValue];
            
        } break;
            
        case 1: {
            
            cell.cellLeftTitleLabel.text = @"Month sales";
            cell.cellLeftValueLabel.text = @"KES 619"; //[NSString stringWithFormat:@"KES %ld", (long)_summary.monthlySalesValue];
            cell.cellRightTitleLabel.text = @"Month books";
            cell.cellRightValueLabel.text = @"19"; //[NSString stringWithFormat:@"%ld", (long)_summary.monthlyBookingsValue];
            
        } break;
            
        default: break;
    }
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"section text placeholder";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Page View Controller Data Source
/*
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
            ////// _dashboardItems
//            [vc.tableView reloadData];
            return vc;
            
        } break;
            
        default: return nil; break;
    }
}
*/

#pragma mark - Actions
/*
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
 */

#pragma mark - Helpers 

- (void)zabre:(NSArray *)dashboardItems {
    
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    
    for (Dashboard *dashObj in dashboardItems) {
        
        // if (dashObj.startDate dateIs) { }
    }
    
    NSMutableArray <ChartDataEntry*> *dataEntries2 = [NSMutableArray new];
    
    ChartDataEntry *data1 = [[ChartDataEntry alloc] initWithX:1 y:1];
    [dataEntries2 addObject:data1];
    
    ChartDataEntry *data2 = [[ChartDataEntry alloc] initWithX:2 y:2];
    [dataEntries2 addObject:data2];
    
    ChartDataEntry *data3 = [[ChartDataEntry alloc] initWithX:3 y:3];
    [dataEntries2 addObject:data3];
    
    LineChartDataSet *lineDataSet = [[LineChartDataSet alloc] initWithValues:dataEntries2 label:@"LEGEND DESCRIPTION"];
    LineChartData *lineData = [[LineChartData alloc] initWithDataSet:lineDataSet];
    
    self.revenueGraph.data = lineData;
}

- (void)configureWithDashboardItems:(NSArray<Dashboard *> *)dashboardItemsArray {
    
    _dashboardItems = dashboardItemsArray;
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kDashboardNotification
//                                                        object:nil
//                                                      userInfo:[NSDictionary dictionaryWithObject:dashboardItemsArray
//                                                                                           forKey:kDashObjKey]];
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
