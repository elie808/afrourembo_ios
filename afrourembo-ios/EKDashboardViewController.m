//
//  EKDashboardViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDashboardViewController.h"

//static NSInteger const kViewCount = 3;

@implementation DashboardUIModel
@end

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
                                  [self computeStatsFromItems:dashboardItems];
                                  
                              } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                              }];
        
    } else if ([EKSettings getSavedSalon]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Dashboard getDashboardOfSalon:[EKSettings getSavedSalon].token
                             withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                                 
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 [self computeStatsFromItems:dashboardItems];
                                 
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
            cell.cellLeftValueLabel.text = [NSString stringWithFormat:@"KES %ld", (long)self.UIModel.totalSales];
            cell.cellRightTitleLabel.text = @"Total books";
            cell.cellRightValueLabel.text = [NSString stringWithFormat:@"%ld", (long)self.UIModel.totalBookings];
            
        } break;
            
        case 1: {
            
            cell.cellLeftTitleLabel.text = @"Month sales";
            cell.cellLeftValueLabel.text = [NSString stringWithFormat:@"KES %ld", (long)self.UIModel.monthlySales];
            cell.cellRightTitleLabel.text = @"Month books";
            cell.cellRightValueLabel.text = [NSString stringWithFormat:@"%ld", (long)self.UIModel.monthlyBookings];
            
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

- (void)computeStatsFromItems:(NSArray <Dashboard *> *)dashboardItems {

    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    NSDate *monthAgo = [todayDate dateBySubtractingMonths:1];
    
    self.UIModel = [DashboardUIModel new];
    self.UIModel.totalBookings = dashboardItems.count;
    self.UIModel.totalSales = ((NSNumber *)[[dashboardItems valueForKey:@"price"] valueForKeyPath: @"@sum.self"]).integerValue;
    
    for (Dashboard *dashObj in dashboardItems) {

        // dashObj.startDate is later in time than date
        if ( [dashObj.startDate compare:monthAgo] == NSOrderedDescending) {
            self.UIModel.monthlySales   = self.UIModel.monthlySales + dashObj.price.integerValue;
            self.UIModel.monthlyBookings = self.UIModel.monthlyBookings + 1;
        }
    }

    NSMutableArray <BarChartDataEntry*> *dataEntries = [NSMutableArray new];
    
    for (int i = 0; i < 7; i ++) {

//        [dashObj.startDate weekday]
        
        BarChartDataEntry *dataEntry = [[BarChartDataEntry alloc] initWithX:i y:i*i];
        [dataEntries addObject:dataEntry];
    }
    
    BarChartDataSet *barDataSet = [[BarChartDataSet alloc] initWithValues:dataEntries label:@"Legend here"];
    BarChartData *barData = [[BarChartData alloc] initWithDataSet:barDataSet];

    self.revenueGraph.data = barData;
    
//    [self.revenueGraph setDrawBordersEnabled:NO];
//    [self.revenueGraph setDrawGridBackgroundEnabled:NO];
//    [self.revenueGraph setGridBackgroundColor:[UIColor redColor]];
    
    [self.tableView reloadData];
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
