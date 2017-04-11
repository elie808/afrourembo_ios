//
//  EKDiscoverMapViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EKDiscoverMapViewController : UIViewController <UISearchControllerDelegate, UISearchBarDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (assign, nonatomic) CLLocationCoordinate2D venueCoordinates;

@end
