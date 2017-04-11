//
//  EKDiscoverMapViewController+MapDelegate.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDiscoverMapViewController+MapDelegate.h"

#define ONEPIN_ZOOM_FACTOR 1.8
#define PINS_ZOOM_FACTOR 100.0

#define METERS_PER_MILE 1609.344

static NSString *kSalonAnnotation = @"salonLocations";

@implementation EKDiscoverMapViewController (MapDelegate)

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:kSalonAnnotation];
        
        if (annotationView == nil) {
            
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kSalonAnnotation];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"annotation"]; //here we use a nice image instead of the default pins
            
        } else {
            
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - Map UI

- (void)clearAllPins {
    
    id userLocation = [self.mapView userLocation];
    [self.mapView removeAnnotations:[self.mapView annotations]];
    
    if (userLocation != nil) {
        [self.mapView addAnnotation:userLocation]; // will cause user location pin to blink
    }
}

- (void)placeVenuePin {
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = self.venueCoordinates;
    annotation.title = @"";
    
    // Set pin on map
    [self.mapView addAnnotation:annotation];
    
    // zoom to pin Location
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.venueCoordinates, ONEPIN_ZOOM_FACTOR * METERS_PER_MILE, ONEPIN_ZOOM_FACTOR * METERS_PER_MILE);
    
    [self.mapView setRegion:viewRegion animated:YES];
}

@end
