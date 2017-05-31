//
//  EKSignInViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextFieldTableViewCell.h"
#import "Customer+API.h"

typedef NS_ENUM(NSUInteger, SignInRole) {
    SignInRoleCustomer,
    SignInRoleSalon,
    SignInRoleBP
};

@interface EKSignInViewController : UIViewController

@property (assign, nonatomic) SignInRole signInRole;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapSignInButton:(id)sender;

@end
