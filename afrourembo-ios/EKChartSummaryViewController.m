//
//  EKChartSummaryViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/31/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKChartSummaryViewController.h"

@implementation EKChartSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:kDashboardNotification
                                               object:nil];

//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [Dashboard getDashboardOfVendor:[EKSettings getSavedVendor].token
//                          withBlock:^(NSArray<Dashboard *> *dashboardItems) {
//                              
//                              [MBProgressHUD hideHUDForView:self.view animated:YES];
////                              [self zabre:dashboardItems];
//                              
//                          } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
//                              
//                              [MBProgressHUD hideHUDForView:self.view animated:YES];
//                              [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
//                          }];
}

- (void)zabre:(NSArray *)dashboardItems {
    
    NSDate *todayDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    
    for (Dashboard *dashObj in dashboardItems) {
     
//        if (dashObj.startDate dateIs)
        
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

- (void)receivedNotification:(NSNotification *) notification {

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
