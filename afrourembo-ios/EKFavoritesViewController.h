//
//  EKFavoritesViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "Favorite.h"
#import "EKSettings.h"
#import "EKConstants.h"
#import "EKFavoritesTableViewCell.h"
#import "EKCompanyProfileViewController.h"
#import "Customer+API.h"
#import "Professional+API.h"
#import "UIViewController+Helpers.h"

@interface EKFavoritesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *emptyFavoritesView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
