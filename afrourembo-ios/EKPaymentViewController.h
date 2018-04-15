//
//  EKPaymentViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKPaymentViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end
