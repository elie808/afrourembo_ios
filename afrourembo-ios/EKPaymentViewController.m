//
//  EKPaymentViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKPaymentViewController.h"
#import "EKCreditCardViewController.h"
#import "EKMPesaViewController.h"


@implementation EKPaymentViewController {
    NSUInteger _index;
    NSArray *_vcDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _index = 0;
    
    // Create PageViewController
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.view.frame = CGRectMake(0, 46, self.view.frame.size.width, self.view.frame.size.height-46);
    self.pageViewController.dataSource = self;
    
    EKMPesaViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"mpesa_view"];
    EKCreditCardViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"creditCard_view"];
    
    _vcDataSource = @[vc1, vc2];
        
    [self.pageViewController setViewControllers:@[_vcDataSource.firstObject]
                                      direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (_index > 0 && _index < _vcDataSource.count-1) {
        _index--;
    } else {
        return nil;
    }
    
    return [self viewControllerAtIndex:_index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    if (_index < _vcDataSource.count-1) {
        _index++;
    } else {
        return nil;
    }
    
    return [self viewControllerAtIndex:_index];
}


- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    //    if ((index > 1) || (index == NSNotFound)) {
    //        return nil;
    //    }

//    switch (index) {
//            
//        case 0: {
//            
////            EKSalesSummaryViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"content1"];
////            vc.dataSource = _dashboardItems;
//            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mpesa_view"];
//            return vc;
//            
//        } break;
//            
//        case 1: {
//            
//            // EKChartSummaryViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"content2"];
//            // vc.view.backgroundColor = [UIColor redColor];
//            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"creditCard_view"];
//            return vc;
//            
//        } break;
//            
//        default: return nil; break;
//    }
    
    self.segmentedControl.selectedSegmentIndex = index;
    
    return _vcDataSource[index];
}

- (IBAction)didChangeSegmented:(UISegmentedControl *)sender {
    
//    if (sender.selectedSegmentIndex == 0) {
//        _index = 0;
//    } else {
//        _index = 1;
//    }
    
    _index = sender.selectedSegmentIndex;
    
    [self.pageViewController setViewControllers:@[_vcDataSource[sender.selectedSegmentIndex]]
                                      direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
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
