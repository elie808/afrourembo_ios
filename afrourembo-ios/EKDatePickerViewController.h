//
//  EKDatePickerViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/17/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Helpers.h"

@protocol EKDatePickerDelegate <NSObject>
- (void)didPickDate:(NSDate *)date;
@end

@interface EKDatePickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSString *unwindSegue; //unused for now
@property (strong, nonatomic) id<EKDatePickerDelegate> delegate;

@end
