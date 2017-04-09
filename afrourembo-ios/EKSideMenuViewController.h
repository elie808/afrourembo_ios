//
//  EKSideMenuViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKImageTextTableViewCell.h"
#import "EKConstants.h"

@interface EKSideMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapBackgroundVIew:(UITapGestureRecognizer *)gesture;

@end
