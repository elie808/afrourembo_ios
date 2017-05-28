//
//  EKDashboardViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKDashboardViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
