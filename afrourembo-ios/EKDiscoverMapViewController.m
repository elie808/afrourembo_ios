//
//  EKDiscoverMapViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDiscoverMapViewController.h"
#import "EKDiscoverMapViewController+MapDelegate.h"
#import "EKDiscoverMapViewController+TableView.h"

@implementation EKDiscoverMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.contentOffsetDictionary = [NSMutableDictionary new];
    self.dataSourceArray = [self createStubs];
    
    self.venueCoordinates = CLLocationCoordinate2DMake(33.888630, 35.495480);
    
    
    self.navigationItem.titleView = self.searchBar;
    
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

#pragma mark - Helpers

//TODO: REMOVE AFTER TESTING
- (NSArray *)createStubs {
    
    Salon *salon = [Salon new];
    salon.mainImageName = @"dummy_portrait1";
    salon.stars = @5;
    salon.price = @30;
    salon.photoCount = @10;
    salon.userImageName = @"dummy_male1";
    salon.userName = @"Adele Hampton";
    salon.address = @"Muindi Mbingu St.";
    salon.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM"];
    
    Salon *salon1 = [Salon new];
    salon1.mainImageName = @"dummy_portrait2";
    salon1.stars = @3;
    salon1.price = @300;
    salon1.photoCount = @100;
    salon1.userImageName = @"dummy_male1";
    salon1.userName = @"James Lipton";
    salon1.address = @"More of Muindi Mbingu St.";
    salon1.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM", @"1:30 PM", @"Tue", @"8:20 AM", @"12:55 PM"];
    
    Salon *salon3 = [Salon new];
    salon3.mainImageName = @"dummy_portrait3";
    salon3.stars = @3;
    salon3.price = @30;
    salon3.photoCount = @10;
    salon3.userImageName = @"dummy_male2";
    salon3.userName = @"James Earl Lipton";
    salon3.address = @"Muindi Mbingu St.";
    salon3.timesArray = @[@"Today", @"9:00 AM"];
    
    return @[salon, salon1, salon3, salon3, salon1];
}

@end
