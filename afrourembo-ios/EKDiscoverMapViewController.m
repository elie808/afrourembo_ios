//
//  EKDiscoverMapViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDiscoverMapViewController.h"
#import "EKDiscoverMapViewController+MapDelegate.h"

@implementation EKDiscoverMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.titleView = self.searchBar;
    
    self.venueCoordinates = CLLocationCoordinate2DMake(33.888630, 35.495480);
    
    [self placeVenuePin];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
