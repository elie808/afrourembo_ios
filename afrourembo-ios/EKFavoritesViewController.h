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
#import "EKFavoritesTableViewCell.h"
#import "Customer+API.h"
#import "UIViewController+Helpers.h"

@interface EKFavoritesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *emptyFavoritesView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
