//
//  EKClientDetailsViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>

#import "Customer.h"

@interface EKClientDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Customer *passedCustomer;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIImageView *customerProfilePicImageView;
@property (strong, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *customerVisitsLabel;
@property (strong, nonatomic) IBOutlet UILabel *customerPhoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *customerEmailLabel;

- (IBAction)didTapCallButton:(id)sender;
- (IBAction)didTapSMSButton:(id)sender;

@end
