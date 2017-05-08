//
//  EKExploreViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKDiscoverMapViewController.h"
#import "EKExploreCollectionViewCell.h"
#import "EKImageTextTableViewCell.h"
#import "Service.h"

@interface EKExploreViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *sideMenuDataSource;

@property (strong, nonatomic) IBOutlet UITableView *sideMenuTableView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)didTapSideMenuButton:(UIBarButtonItem *)sender;
- (IBAction)unwindToExploreVC:(UIStoryboardSegue *)segue;

@end
