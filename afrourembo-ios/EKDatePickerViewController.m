//
//  EKDatePickerViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/17/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKDatePickerViewController.h"

@implementation EKDatePickerViewController {
    NSArray *_months;           // datasource
    NSArray<NSNumber*> *_years; // datasource
    
    NSString *_selectedMonth;
    NSString *_selectedYear;
 
    NSDate *_selectedDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _months = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    _years = [NSArray arrayWithArray:[self createYearsDataSource]];
    
    // initialize default selection
    _selectedYear = [NSString stringWithFormat:@"%ld", (long)_years[0].integerValue];
    _selectedMonth = @"1";
    
    _selectedDate = [NSDate date];
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
    
    switch (component) {
     
        case 0: return _months.count; break;
        case 1: return _years.count; break;
        default: return 0; break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (component) {
            
        case 0: return _months[row]; break;
        case 1: return [NSString stringWithFormat:@"%ld", (long)_years[row].integerValue]; break;
        
        default: return @""; break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    switch (component) {
            
        case 0: _selectedMonth = [NSString stringWithFormat:@"%ld", row + 1]; break;
        case 1: _selectedYear = [NSString stringWithFormat:@"%ld", (long)_years[row].integerValue]; break;
            
        default: break;
    }
}

#pragma mark - Actions

/// only use if using a DatePicker instead of a generic UIPickerView, since the delegate methods won't work for a Date Picker
- (IBAction)didChangeValue:(UIDatePicker *)sender {
    
    _selectedDate = sender.date;
    
}

- (IBAction)didTapDone:(UIButton *)sender {
    
    if (self.pickerView) {
    
        NSString *str = [NSString stringWithFormat:@"%@/%@", _selectedMonth, _selectedYear]; //@"3/15/2012 9:15 PM";
        
        NSDateFormatter *formatter = [NSDate dateFormatter:DateFormatDigitMonthYear];
        
        _selectedDate = [formatter dateFromString:str];
    }
    
    if (self.delegate) {
        
        [self.delegate didPickDate:_selectedDate];
        [self performSegueWithIdentifier:@"doneSegue" sender:nil];
    }
}

- (IBAction)didTapCancel:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"cancelSegue" sender:nil];
}

#pragma mark - Helpers

- (NSArray *)createYearsDataSource {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger currentYear = [components year];
    
    NSMutableArray *tempYears = [NSMutableArray new];
    
    for (NSInteger i = currentYear; i < currentYear+30; i++) {
        [tempYears addObject:[NSNumber numberWithInteger:i]];
    }
    
    return [NSArray arrayWithArray:tempYears];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.backgroundView.alpha = 0;
}

@end
