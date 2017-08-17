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

- (void)showLoginDialog:(ActionSheetLogin)signInBlock andSignUpBlock:(ActionSheetSignUp)signUpBlock; {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You are not signed in"
                                                                   message:@"Sign in or create a new account"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"email";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"password";
    }];
    
    if (signInBlock) {
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Sign in" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                    
                                                    if (alert.textFields.count > 0) {
                                                        
                                                        UITextField *emailTextField = [alert.textFields firstObject];
                                                        UITextField *passwordTextField = [alert.textFields objectAtIndex:1];
                                                        
                                                        if (signInBlock)
                                                            signInBlock(action, emailTextField.text, passwordTextField.text);
                                                    }
                                                }]];
    }
    
    if (signUpBlock) {
    
        [alert addAction:[UIAlertAction actionWithTitle:@"Sign up" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    
                                                    if (signUpBlock)
                                                        signUpBlock(action);
                                                }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
