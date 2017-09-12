//
//  EKProfessionalAddressViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EKProfessionalInfoViewController.h"

#import "Address.h"

#import "UIViewController+Helpers.h"

#import <MapKit/MapKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface EKProfessionalAddressViewController : UIViewController <MKMapViewDelegate, UISearchBarDelegate>

@property (assign, nonatomic) CLLocationCoordinate2D passedCoords;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIImageView *pinImageView;

- (IBAction)didTapDone:(id)sender;

@end
