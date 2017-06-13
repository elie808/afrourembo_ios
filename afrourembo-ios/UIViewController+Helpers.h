//
//  UIViewController+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/13/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionSheetUnwindBlock)(UIAlertAction *action);

@interface UIViewController (Helpers)

- (void)showMessage:(NSString *)message withTitle:(NSString *)title completionBlock:(ActionSheetUnwindBlock)block;

@end
