//
//  EKServicesChartViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKServicesChartViewController.h"

static NSString * const kCellID = @"servicesChartCell";

@implementation ServicesUIModel
@end

@implementation EKServicesChartViewController {
    NSMutableArray *_allDashboardItems; //used to hold the API response, so we can manipulate them later
    NSMutableArray *_servicesDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allDashboardItems = [NSMutableArray new];
    _servicesDataSource = [NSMutableArray new];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Dashboard getDashboardOfVendor:[EKSettings getSavedVendor].token
                          withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                              
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              
                              [_allDashboardItems addObjectsFromArray:dashboardItems];
                              
                              [_servicesDataSource removeAllObjects];
                              [_servicesDataSource addObjectsFromArray:[self filterDashboardArray:dashboardItems forDate:7]]; // week
                              [self.tableView reloadData];
                              
                          } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                              
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                          }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _servicesDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ServicesUIModel *model = [_servicesDataSource objectAtIndex:indexPath.row];
    
    EKSalesSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    cell.cellLeftValueLabel.text = model.serviceName;
    cell.cellRightValueLabel.text = [NSString stringWithFormat:@"%ld", (long)model.serviceCount];
    
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

#pragma mark - Actions

- (IBAction)didChangeSegmentedValue:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
            
        case 0: {
            
            [_servicesDataSource removeAllObjects];
            [_servicesDataSource addObjectsFromArray:[self filterDashboardArray:_allDashboardItems forDate:7]]; // week
            [self.tableView reloadData];
            
        } break;
            
        case 1: {
            
            [_servicesDataSource removeAllObjects];
            [_servicesDataSource addObjectsFromArray:[self filterDashboardArray:_allDashboardItems forDate:30]]; // month
            [self.tableView reloadData];
            
        } break;
            
        case 2: {
            
            [_servicesDataSource removeAllObjects];
            [_servicesDataSource addObjectsFromArray:[self filterDashboardArray:_allDashboardItems forDate:365]]; // year
            [self.tableView reloadData];
            
        } break;
            
        default: break;
    }
}

#pragma mark - Helpers

/// take the full response, and populate the UI model by service count, according to the provided filter date (forDate param)
- (NSArray *)filterDashboardArray:(NSArray <Dashboard*> *)dashboardItems forDate:(NSInteger)days {
    
    NSMutableArray *returnArray = [NSMutableArray new];
    NSMutableArray *allServices = [NSMutableArray new];
    
    // date to filter all services by
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    NSDate *date = [todayDate dateBySubtractingDays:days];
    
    // only exctract services with the right start date (a week/month/year ago)
    for (Dashboard *dashItem in dashboardItems) {
        // dashItem.startDate is later in time than date
        if ( [dashItem.startDate compare:date] == NSOrderedDescending) {
            [allServices addObject:dashItem.service];
        }
    }
    
    // a list of all unique services (no duplicates). Will be used below as filtering keys for the allServices list
    NSSet *uniqueServices = [NSSet setWithArray:[allServices valueForKeyPath:@"@distinctUnionOfObjects.self"]];
    
    // count the occurence of each service
    for (NSString *serviceName in uniqueServices) {
        
        NSInteger occurrences = [[allServices indexesOfObjectsPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
            return [obj isEqual:serviceName];}] count];

        ServicesUIModel *model = [ServicesUIModel new];
        model.serviceName = serviceName;
        model.serviceCount = occurrences;
        
        [returnArray addObject:model];
    }
    
    return [NSArray arrayWithArray:returnArray];
}

@end
