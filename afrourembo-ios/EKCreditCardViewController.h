//
//  EKCreditCardViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/15/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKDatePickerViewController.h"
#import "EKTextFieldTableViewCell.h"
#import "NSDate+Helpers.h"

@interface EKCreditCardViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, EKDatePickerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

// viewModel
@property (nonatomic, strong) NSString *_cardNumber;
@property (nonatomic, strong) NSString *_MMYY;
@property (nonatomic, strong) NSString *_fullName;
@property (nonatomic, strong) NSString *_CVV;

- (BOOL)validateData;

@end
