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
 
    NSMutableArray <BarChartDataEntry*> *dataEntries = [NSMutableArray new];
    
    BarChartDataEntry *dataEntry1 = [[BarChartDataEntry alloc] initWithX:1 y:1];
    [dataEntries addObject:dataEntry1];
    
    BarChartDataEntry *dataEntry2 = [[BarChartDataEntry alloc] initWithX:2 y:2];
    [dataEntries addObject:dataEntry2];
    
    BarChartDataEntry *dataEntry3 = [[BarChartDataEntry alloc] initWithX:3 y:3];
    [dataEntries addObject:dataEntry3];
    
    BarChartDataSet *chartDataSet = [[BarChartDataSet alloc] initWithValues:dataEntries label:@"LEGEND DESCRIPTION"];
    BarChartData *chartData = [[BarChartData alloc] initWithDataSet:chartDataSet];
    
    self.graph.data = chartData;
    
    /////
    
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
