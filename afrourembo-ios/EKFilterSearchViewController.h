//
//  EKSearchFilterViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "Salon.h"
#import "EKSalonListTableViewCell.h"
#import "EKSalonListCollectionViewCell.h"
#import "EKFilterSearchTableViewCell.h"

@interface EKFilterSearchViewController : UIViewController <UISearchControllerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *categoryDataSource;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (strong, nonatomic) NSMutableArray *subCategoryDataSource;
@property (weak, nonatomic) IBOutlet UITableView *subCategoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSourceArray;
@property (strong, nonatomic) NSMutableDictionary *contentOffsetDictionary; // used to keep track of collectionViews scrolling positions/offsets

- (void)showFilterTableViewsWithAnimation:(BOOL)animated;
- (void)hideFilterTableViewsWithAnimation:(BOOL)animated;

- (IBAction)didTapFilterButton:(id)sender;

@end
