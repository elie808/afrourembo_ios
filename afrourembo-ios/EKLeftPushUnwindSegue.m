//
//  EKLeftPushUnwindSegue.m
//  saudi-waftakher-ios
//
//  Created by Elie El Khoury on 2/2/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKLeftPushUnwindSegue.h"

@implementation EKLeftPushUnwindSegue

- (void)perform {
    
    UIViewController *sideMenuVC = self.sourceViewController;
//    UIViewController *mainVC = self.destinationViewController;
    
//    [sideMenuVC.view.superview insertSubview:mainVC.view aboveSubview:sideMenuVC.view];

    // Start here. sideMenu with no translation
    sideMenuVC.view.transform = CGAffineTransformMakeTranslation(0, 0);
    
    [UIView animateWithDuration:kLeftPushAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         // End here. sideMenu's X is translated by its width to the left (make negative, to have right to left animation)
                         sideMenuVC.view.transform = CGAffineTransformMakeTranslation(-sideMenuVC.view.frame.size.width,0);
                     }
                     completion:^(BOOL finished) {
                         
                         // After animation is done, pop sideMenu off the Views stack
                         [sideMenuVC dismissViewControllerAnimated:YES completion:nil];
                     }];
}

@end
