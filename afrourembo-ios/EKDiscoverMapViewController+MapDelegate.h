//
//  EKDiscoverMapViewController+MapDelegate.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDiscoverMapViewController.h"
#import <MapKit/MapKit.h>

@interface EKDiscoverMapViewController (MapDelegate)

- (void)placeVenuePin;
- (void)clearAllPins;

@end
