//
//  EKDiscoverMapViewController+MapDelegate.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDiscoverMapViewController+MapDelegate.h"

#define ONEPIN_ZOOM_FACTOR 2.5
#define PINS_ZOOM_FACTOR 25.0

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
            annotationView.image = [UIImage imageNamed:@"icPinNormal"]; //here we use a nice image instead of the default pins
            
        } else {
            
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[EKAnnotation class]]) {
        
        NSLog(@"TAP TAP TAP TAP: %@", ((EKAnnotation*) view.annotation).salonObj.userName);
    }
}

#pragma mark - Map UI

- (void)clearAllPins {
    
    id userLocation = [self.mapView userLocation];
    [self.mapView removeAnnotations:[self.mapView annotations]];
    
    if (userLocation != nil) {
        [self.mapView addAnnotation:userLocation]; // will cause user location pin to blink
    }
}

- (void)placeVenuePins:(NSArray *)dataSource {

    NSMutableArray *pinsArray = [NSMutableArray array];
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(0, 0);
    
    for (Salon *salonObj in dataSource) {
        
        // Create Pin object
        EKAnnotation *annotation = [[EKAnnotation alloc] init];
        coords = CLLocationCoordinate2DMake(salonObj.latitude, salonObj.longitude);
        annotation.coordinate = coords;
        annotation.title = salonObj.userName;
        annotation.salonObj = salonObj;
        
        [pinsArray addObject:annotation];
    }
    
    // Set pin on map
    [self.mapView addAnnotations:pinsArray];
    
    // zoom to pin Location
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coords, PINS_ZOOM_FACTOR * METERS_PER_MILE,
                                                                       PINS_ZOOM_FACTOR * METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
}

@end
