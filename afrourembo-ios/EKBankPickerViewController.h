//
//  EKBankPickerViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/24/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bank.h"

@protocol EKBankPickerDelegate <NSObject>
- (void)didPickBank:(Bank *)bank;
@end

@interface EKBankPickerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSArray<Bank *> *dataSource;
@property (strong, nonatomic) NSString *unwindSegue;
@property (strong, nonatomic) id<EKBankPickerDelegate> delegate;

@end
