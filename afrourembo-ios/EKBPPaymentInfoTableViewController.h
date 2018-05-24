//
//  EKBPPaymentInfoTableViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/16/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKAddServiceViewController.h"
#import "Bank+API.h"
#import "Professional.h"
#import "Salon.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface EKBPPaymentInfoTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *accountNumberTextField;

@property NSString *unwindSegueID;
@property (strong, nonatomic) Professional *passedProfessional;
@property (strong, nonatomic) Salon *passedSalon;

@end
