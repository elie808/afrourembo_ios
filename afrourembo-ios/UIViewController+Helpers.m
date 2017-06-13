//
//  UIViewController+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/13/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "UIViewController+Helpers.h"

@implementation UIViewController (Helpers)

- (void)showMessage:(NSString *)message withTitle:(NSString *)title completionBlock:(ActionSheetUnwindBlock)block {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title
                                                                         message:message
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (block)
            block(action);
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

@end
