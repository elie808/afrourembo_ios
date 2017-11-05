//
//  EKExploreViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKDiscoverMapViewController.h"
#import "EKEditProfileInfoViewController.h"
#import "EKExploreCollectionViewCell.h"
#import "EKImageTextTableViewCell.h"
#import "Category.h"
#import "Category+API.h"
#import "Service.h"
#import "Customer.h"
#import "EKSettings.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYWebImage/YYWebImage.h>

@interface EKExploreViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *sideMenuDataSource;
@property (strong, nonatomic) Customer *passedCustomer;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideMenuButton;
@property (strong, nonatomic) IBOutlet UITableView *sideMenuTableView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)animateSideMenu;

- (IBAction)didTapSideMenuButton:(UIBarButtonItem *)sender;
- (IBAction)unwindToExploreVC:(UIStoryboardSegue *)segue;

@end
