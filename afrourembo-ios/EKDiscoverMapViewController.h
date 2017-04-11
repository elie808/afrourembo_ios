//
//  EKDiscoverMapViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EKSalonListTableViewCell.h"
#import "EKSalonListCollectionViewCell.h"
#import "Salon.h"

@interface EKDiscoverMapViewController : UIViewController <UISearchControllerDelegate, UISearchBarDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) CLLocationCoordinate2D venueCoordinates;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSourceArray;
@property (strong, nonatomic) NSMutableDictionary *contentOffsetDictionary; // used to keep track of collectionViews scrolling positions/offsets

@end
