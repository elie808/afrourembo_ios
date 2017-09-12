//
//  EKProfileInformationViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/18/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextFieldTableViewCell.h"

@interface EKProfileInfoFacebookViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)unwindToFbProfile:(UIStoryboardSegue *)segue;

@end
