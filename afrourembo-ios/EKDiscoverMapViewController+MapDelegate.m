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

static NSString * const kKenyaRegion = @"kenya";
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
            
            // here we use a nice image instead of the default pins.
            // display proper colored pin depending on whether we're displaying a Professional or Salon
            if ([annotation isKindOfClass:[EKAnnotation class]]) {
                
                // display pin for Professional
                if ( ((EKAnnotation *)annotation).profObj) {
                    
                    annotationView.image = [UIImage imageNamed:@"icPinNormal"];
                
                // display pin for Salon
                } else if ( ((EKAnnotation *)annotation).salonObj) {
                    
                    annotationView.image = [UIImage imageNamed:@"icPinActive"];
                }
            }
            
        } else {
            
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[EKAnnotation class]]) {

        if ( ((EKAnnotation *)view.annotation).profObj) {
            
            Professional *profObj = ((EKAnnotation*)view.annotation).profObj;
            [self.dataSourceArray removeAllObjects];
            [self.dataSourceArray addObject:profObj];
        }
        
        if ( ((EKAnnotation *)view.annotation).salonObj) {
            
            Salon *salonObj = ((EKAnnotation*)view.annotation).salonObj;
            [self.dataSourceArray removeAllObjects];
            [self.dataSourceArray addObject:salonObj];
        }

        [self.tableView reloadData];
        
        [self animateOneCellList:YES];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[EKAnnotation class]]) {
        
        [self animateOneCellList:NO];
        
        [self.dataSourceArray removeAllObjects];
        [self.dataSourceArray addObjectsFromArray:self.venuesList];
        [self.tableView reloadData];
    }
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    [self.searchBar resignFirstResponder];
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
    
    for (id venueObj in dataSource) {
    
        EKAnnotation *annotation = [[EKAnnotation alloc] init];
        
        if ([venueObj isKindOfClass:[Professional class]]) {
            
            annotation.title = ((Professional*)venueObj).business.name;
            annotation.profObj = (Professional*)venueObj;
            
            coords = CLLocationCoordinate2DMake(((Professional*)venueObj).business.latitude,
                                                ((Professional*)venueObj).business.longitude);
            annotation.coordinate = coords;
        }
        
        if ([venueObj isKindOfClass:[Salon class]]) {
            
            annotation.title = ((Salon *)venueObj).name;
            annotation.salonObj = (Salon *)venueObj;
            
            coords = CLLocationCoordinate2DMake(((Salon*)venueObj).latitude,
                                                ((Salon*)venueObj).longitude);
            annotation.coordinate = coords;
        }
        
        [pinsArray addObject:annotation];
    }
    
    // Set pin on map
    [self.mapView addAnnotations:pinsArray];
    
    // zoom to pin Location
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coords, PINS_ZOOM_FACTOR * METERS_PER_MILE,
                                                                       PINS_ZOOM_FACTOR * METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
}

#pragma mark - UISeachBar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    /*
    // should be some address, state, and zip
    NSString *searchText = [NSString stringWithFormat:@"%@ nairobi kenya", searchBar.text];
    
    CGFloat latitude = -1.280424;
    CGFloat longitude = 36.816311;
    
    CLCircularRegion *searchRegion = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(latitude, longitude)
                                                                       radius:8000.0
                                                                   identifier:kKenyaRegion];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[[CLGeocoder alloc] init] geocodeAddressString:searchText
                                           inRegion:searchRegion
                                  completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                                      
                                      if (placemarks && placemarks.count > 0) {
                                          
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          
                                          CLPlacemark *topResult = [placemarks objectAtIndex:0];
                                          MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                                          
                                          MKCoordinateRegion region = self.mapView.region;
                                          region.center = placemark.region.center;
                                          region.span.longitudeDelta /= 8.0;
                                          region.span.latitudeDelta /= 8.0;
                                          
                                          [self.mapView setRegion:region animated:YES];
                                          // [self.mapView addAnnotation:placemark];
                                          
                                      } else {
                                          
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          [self showMessage:@"We can't find the address you're searching for."
                                                  withTitle:@"Address not found"
                                            completionBlock:nil];
                                      }
                                  }];
     */

    [Explore getProfessionalsForCategory:self.passedService.name
                                andQuery:searchBar.text
                               WithBlock:^(NSArray<Professional *> *proArray) {

                                   [self.venuesList removeAllObjects];
                                   [self.dataSourceArray removeAllObjects];

                                   self.listViewVisible = NO;
                                   
                                   [self.venuesList addObjectsFromArray:proArray];
                                   [self.dataSourceArray addObjectsFromArray:proArray];
                                   
                                   [self.tableView reloadData];
                                   
                                   [self placeVenuePins:proArray];
                                   
                                   
                                   [Explore getSalonsForCategory:self.passedService.name
                                                        andQuery:searchBar.text
                                                       WithBlock:^(NSArray<Salon *> *salonArray) {
                                                           
                                                           self.listViewVisible = NO;
                                                           
                                                           [self.venuesList addObjectsFromArray:salonArray];
                                                           
                                                           [self.dataSourceArray addObjectsFromArray:salonArray];
                                                           [self.tableView reloadData];
                                                           
                                                           [self placeVenuePins:salonArray];
                                                           
                                                       } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                           [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                                       }];
                                   
                                   
                               } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                   [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                               }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if (searchText.length == 0) {

        [self showHideList];
        
        [searchBar resignFirstResponder];
        
        [Explore getProfessionalsForCategory:self.passedService.name
                                    andQuery:searchBar.text
                                   WithBlock:^(NSArray<Professional *> *proArray) {
                                       
                                       [self.venuesList removeAllObjects];
                                       [self.dataSourceArray removeAllObjects];
                                       
                                       self.listViewVisible = NO;
                                       
                                       [self.venuesList addObjectsFromArray:proArray];
                                       [self.dataSourceArray addObjectsFromArray:proArray];
                                       
                                       [self.tableView reloadData];
                                       
                                       [self placeVenuePins:proArray];
                                      
                                       
                                       [Explore getSalonsForCategory:self.passedService.name
                                                            andQuery:searchBar.text
                                                           WithBlock:^(NSArray<Salon *> *salonArray) {
                                                               
                                                               self.listViewVisible = NO;
                                                               
                                                               [self.venuesList addObjectsFromArray:salonArray];
                                                               
                                                               [self.dataSourceArray addObjectsFromArray:salonArray];
                                                               [self.tableView reloadData];
                                                               
                                                               [self placeVenuePins:salonArray];
                                                               
                                                           } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                               [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                                           }];

                                       
                                   } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                       [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                   }];
    }
}

@end
