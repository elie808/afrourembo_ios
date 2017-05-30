//
//  EKChartSummaryViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/31/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts.Swift;

@interface EKChartSummaryViewController : UIViewController

@property (strong, nonatomic) IBOutlet BarChartView *graph;
@property (strong, nonatomic) IBOutlet LineChartView *revenueGraph;

- (IBAction)didChangeSegmentedValue:(UISegmentedControl *)sender;

@end
