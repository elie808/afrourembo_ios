//
//  EKProfessionalAddressViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKProfessionalAddressViewController.h"

static CLLocationDistance const kZoomDistance = 500;

static NSString * const kKenyaRegion = @"kenya";
static NSString * const kUnwindSegue = @"unwindToProfessionalInfo";

@implementation EKProfessionalAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pinImageView.frame = CGRectMake(0,0, 26, 39);
    self.pinImageView.center = self.mapView.center;
    [self.view addSubview:self.pinImageView];
    
    // set to Nairobi coordinates by default
    CGFloat latitude = -1.280424;
    CGFloat longitude = 36.816311;
    
    if (self.passedCoords.latitude && self.passedCoords.longitude) {
        latitude = self.passedCoords.latitude;
        longitude = self.passedCoords.longitude;
    }
    
    CLLocationCoordinate2D noLocation = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, kZoomDistance, kZoomDistance);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
}

// REVERSE LOOKUP FROM STRING
/*
*/

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    [self.searchBar resignFirstResponder];
    
    NSLog(@"CENTER: %f %f", [mapView centerCoordinate].latitude, [mapView centerCoordinate].longitude);
}

#pragma mark - UISeachBar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];

    // should be some address, state, and zip
    NSString *searchText = [NSString stringWithFormat:@"%@  nairobi kenya", searchBar.text];

    NSLog(@"SEARCH: %@", searchText);
    
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
                                          region.center = [(CLCircularRegion *)placemark.region center];
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
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSLog(@"SERCH TEXT: %@", searchText);
}

#pragma mark - Actions

- (IBAction)didTapDone:(id)sender {
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:[self.mapView centerCoordinate].latitude
                                                longitude:[self.mapView centerCoordinate].longitude];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[[CLGeocoder alloc]init] reverseGeocodeLocation:loc
                                   completionHandler:^(NSArray *placemarks, NSError *error) {
                                       
                                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                                       
                                       if (placemark) {
                                           
                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                           NSLog(@"placemark %@",placemark);
                                           
                                           //String to hold address
                                           NSString *completeAddress = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                                           
                                           NSLog(@"addressDictionary %@", placemark.addressDictionary);
                                           
                                           //                                           NSLog(@"placemark %@",placemark.region);
                                           //                                           NSLog(@"placemark %@",placemark.country);  // Give Country Name
                                           //                                           NSLog(@"placemark %@",placemark.locality); // Extract the city name
                                           //
                                           //                                           NSLog(@"location %@",placemark.name);
                                           //                                           NSLog(@"location %@",placemark.postalCode);
                                           //                                           NSLog(@"location %@",placemark.subLocality);
                                           //                                           NSLog(@"location %@",placemark.location);
                                           
                                           // Print the complete location
                                           NSLog(@"I am currently at %@", completeAddress);
                                           
                                           Address *addressObj = [Address new];
                                           //                                           addressObj.addressCoords = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude,
                                           //                                                                                                 placemark.location.coordinate.longitude);
                                           addressObj.addressCoords = CLLocationCoordinate2DMake([self.mapView centerCoordinate].latitude,
                                                                                                 [self.mapView centerCoordinate].longitude);
                                           addressObj.addressString = completeAddress;
                                           
                                           [self performSegueWithIdentifier:kUnwindSegue sender:addressObj];
                                           
                                       } else {
                                           
                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                           NSLog(@"Could not locate");
                                       }
                                   }
     ];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kUnwindSegue]) {
        
        Address *addressObj = [Address new];
        addressObj = (Address *)sender;
        
        EKProfessionalInfoViewController *vc = segue.destinationViewController;
        vc.address = addressObj.addressString;
        vc.addressCoords = CLLocationCoordinate2DMake(addressObj.addressCoords.latitude, addressObj.addressCoords.longitude);
    }
}

@end
