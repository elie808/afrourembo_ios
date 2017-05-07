//
//  EKScheduleMonthlyViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/28/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKScheduleMonthlyViewController.h"

@interface EKScheduleMonthlyViewController ()

@end

@implementation EKScheduleMonthlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
//    self.calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    // Do other updates here
    [self.view layoutIfNeeded];
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
