//
//  EKLeftPushSegue.m
//  saudi-waftakher-ios
//
//  Created by Elie El Khoury on 2/2/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKLeftPushSegue.h"

@implementation EKLeftPushSegue

- (void)perform {
    
    UIViewController *src = self.sourceViewController;
    UIViewController *dst = self.destinationViewController;
    
    [src.view.superview insertSubview:dst.view aboveSubview:src.view];
    dst.view.transform = CGAffineTransformMakeTranslation(-src.view.frame.size.width, 0);
    
    [UIView animateWithDuration:kLeftPushAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         dst.view.transform = CGAffineTransformMakeTranslation(0,0);
                     }
                     completion:^(BOOL finished) {
                         [src presentViewController:dst animated:NO completion:nil];
                     }];
}

@end
