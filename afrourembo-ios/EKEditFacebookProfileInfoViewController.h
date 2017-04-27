//
//  EKEditProfileInformationViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextFieldTableViewCell.h"

@interface EKEditFacebookProfileInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *changeProfilePicButton;

@end
