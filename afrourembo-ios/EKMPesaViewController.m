//
//  EKMPesaViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/15/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKMPesaViewController.h"

@implementation EKMPesaViewController {
    
    UITextField *_activeTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.cellTitleLabel.text = @"Phone number";
            cell.cellTextField.placeholder = @"+254000000";
            cell.cellTextField.keyboardType = UIKeyboardTypePhonePad;
            cell.cellTextField.text = self.phoneNumber;
            cell.cellTextField.tag = 0;
            [self addKeyboadToolbarTo:cell.cellTextField];
            break;
            
        case 1:
            cell.cellTitleLabel.text = @"M-PESA pin";
            cell.cellTextField.placeholder = @"XXXX";
            cell.cellTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.cellTextField.text = self.MPesaPin;
            cell.cellTextField.tag = 1;
            [self addKeyboadToolbarTo:cell.cellTextField];
            break;
            
        default: break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITextField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    _activeTextField = textField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // Prevent crashing undo bug
    if (range.length + range.location > textField.text.length) {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    switch (textField.tag) {
            
        case 0: // Phone number
            self.phoneNumber = textField.text;
            return YES;
            break;
            
        case 1: // MPesa pin
            self.MPesaPin = textField.text;
            return newLength <= 4; break;
            
        default: return YES; break;
    }
}

#pragma mark - Actions

- (void)addKeyboadToolbarTo:(UITextField *)textField {
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(diTapToolbarDoneButton) ];
    
    
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    
    textField.inputAccessoryView = keyboardToolbar;
}

- (IBAction)diTapToolbarDoneButton {
    
    if (_activeTextField && _activeTextField.isFirstResponder) {
        [_activeTextField resignFirstResponder];
    }
}

#pragma mark - Helpers

- (BOOL)validateData {
    
    //    _cardNumber;
    //    _MMYY;
    //    _fullName;
    //    _CVV;
    
    return YES;
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
