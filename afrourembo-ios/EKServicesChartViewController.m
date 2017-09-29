//
//  EKServicesChartViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKServicesChartViewController.h"

static NSString * const kCellID = @"servicesChartCell";

@implementation EKServicesChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Dashboard getDashboardOfVendor:[EKSettings getSavedVendor].token
                          withBlock:^(NSArray<Dashboard *> *dashboardItems) {
                              
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              
                              NSLog(@"\n \n %@", [dashboardItems valueForKeyPath:@"service"]);
                              
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKSalesSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    cell.cellLeftValueLabel.text = @"Hair";
    cell.cellRightValueLabel.text = @"10";
    
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
            
        case 0: NSLog(@"segment 0"); break;
        case 1: NSLog(@"segment 1"); break;
        case 2: NSLog(@"segment 2"); break;
            
        default: break;
    }
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
