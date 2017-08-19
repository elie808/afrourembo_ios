//
//  UIViewController+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/13/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionSheetUnwindBlock)(UIAlertAction *action);

typedef void (^ActionSheetLogin)(UIAlertAction *action, NSString *emailString, NSString *passString);
typedef void (^ActionSheetSignUp)(UIAlertAction *action);

@interface UIViewController (Helpers)

- (void)showMessage:(NSString *)message withTitle:(NSString *)title completionBlock:(ActionSheetUnwindBlock)block;
- (void)showLoginDialog:(ActionSheetLogin)signInBlock andSignUpBlock:(ActionSheetSignUp)signUpBlock;

@end
