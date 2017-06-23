//
//  EKSalonAddressViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/20/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKSalonInfoViewController.h"
#import "Address.h"
#import <MapKit/MapKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface EKSalonAddressViewController : UIViewController <MKMapViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIImageView *pinImageView;

- (IBAction)didTapDone:(id)sender;

@end
