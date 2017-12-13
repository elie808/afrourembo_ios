//
//  EKDiscoverMapViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EKCompanyProfileViewController.h"
#import "EKSalonListTableViewCell.h"
#import "EKSalonListCollectionViewCell.h"
#import "EKAnnotation.h"
#import "Customer.h"
#import "Day.h"
#import "Service.h"
#import "Salon.h"
#import "Explore+API.h"
#import <YYWebImage/YYWebImage.h>

static NSString * const kCompanyProfile = @"discoverMapToCompanyProfileVC";

@interface EKDiscoverMapViewController : UIViewController <UISearchControllerDelegate, UISearchBarDelegate, MKMapViewDelegate>

@property (strong, nonatomic) Customer *passedCustomer;
@property (strong, nonatomic) Service *passedService;

/// used to keep track of collectionViews scrolling positions/offsets
@property (strong, nonatomic) NSMutableDictionary *contentOffsetDictionary;

@property (strong, nonatomic) NSMutableArray *dataSourceArray;

/// store Pro/Salon list, to enable filtering tableView dataSource for oneCell display
@property (strong, nonatomic) NSMutableArray *venuesList;

// keep track if tableView is visible or not. Animate toggleButton accordingly
@property (assign, atomic) BOOL listViewVisible;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *toggleButton;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) CLLocationCoordinate2D venueCoordinates;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapPresentListButton:(UIButton *)sender;

/// Show/Hide list tableView in "one cell" layout, on top of map
- (void)animateOneCellList:(BOOL)show;

- (void)showHideList;

@end
