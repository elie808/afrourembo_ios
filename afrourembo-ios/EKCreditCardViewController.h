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
#import "EKSettings.h"
#import "NSDate+Helpers.h"

@interface EKCreditCardViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, EKDatePickerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

// viewModel
@property (nonatomic, strong) NSString *_cardNumber;
@property (nonatomic, strong) NSString *_MMYY;  // use for UI/display purposes
@property (nonatomic, strong) NSString *_MM;    // use for posting to server
@property (nonatomic, strong) NSString *_YY;    // use for posting to server
@property (nonatomic, strong) NSString *_firstName;
@property (nonatomic, strong) NSString *_lastName;
@property (nonatomic, strong) NSString *_CVV;
@property (nonatomic, strong) NSString *_phone;
@property (nonatomic, strong) NSString *_address;
@property (nonatomic, strong) NSString *_postalCode;

- (BOOL)validateData;

@end
