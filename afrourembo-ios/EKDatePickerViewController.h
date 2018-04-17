//
//  EKDatePickerViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/17/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKDatePickerDelegate <NSObject>
- (void)didPickDate:(NSDate *)date;
@end

@interface EKDatePickerViewController : UIViewController

@property (strong, nonatomic) id<EKDatePickerDelegate> delegate;

@end
