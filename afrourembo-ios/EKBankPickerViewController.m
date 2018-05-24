//
//  EKBankPickerViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/24/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKBankPickerViewController.h"

@implementation EKBankPickerViewController {
    Bank *_selectedBank;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.dataSource && self.dataSource.count > 0) {
        _selectedBank = self.dataSource[0];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Animate to a dark backgroundView after the view has entered the window
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.backgroundView.alpha = 0.6;
                     }
                     completion:nil];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    Bank *bnk = _dataSource[row];
    
    return bnk.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    _selectedBank = self.dataSource[row];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.backgroundView.alpha = 0;
}

#pragma mark - Actions

- (IBAction)didTapDone:(UIButton *)sender {
    
    if (self.delegate) {

        [self.delegate didPickBank:_selectedBank];
        [self performSegueWithIdentifier:@"doneUnwind" sender:nil];
    }
}

- (IBAction)didTapCancel:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"cancelUnwind" sender:nil];
}


@end
