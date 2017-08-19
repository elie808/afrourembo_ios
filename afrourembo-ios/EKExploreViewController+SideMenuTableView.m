//
//  EKExploreViewController+SideMenuTableView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/8/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKExploreViewController+SideMenuTableView.h"

static NSString * const  kSideMenuCell = @"sideMenuCell";

static NSString * const kDiscoverSegue  = @"exploreToDiscover";

static NSString * const kCartSegue  = @"sideMenuToCartVC";
static NSString * const kWelcomeSegue  = @"sideMenuToWelcomeVC";

//@{@"icExploreNormal"  : @"Explore"},
//@{@"icCartNormal"     : @"Cart"},
//@{@"icPaymentsNormal" : @"Orders"},
//@{@"icGiftNormal"     : @"Gifts"},
//@{@"icSettingsNormal" : @"Settings"}

@implementation EKExploreViewController (SideMenuTableView)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sideMenuDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKImageTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSideMenuCell forIndexPath:indexPath];
    
    NSString *imageName = [[(NSDictionary *)[self.sideMenuDataSource objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *textValue = [[(NSDictionary *)[self.sideMenuDataSource objectAtIndex:indexPath.row] allValues] firstObject];
    
    cell.cellImageView.image = [UIImage imageNamed:imageName];
    cell.cellTextLabel.text = textValue;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            
        case 0: [self animateSideMenu]; break; // Explore
            
        case 1: [self performSegueWithIdentifier:kCartSegue sender:nil]; break; // Cart
            
        case 2:  break; // Orders
            
        case 3:  break; // Gifts
            
        case 4: break; // Settings
            
        default: break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 52.0;
}

#pragma mark - Actions

- (IBAction)didTapLogoutButton:(id)sender {
    
    [EKSettings deleteBookingsForCustomer:[EKSettings getSavedCustomer]]; //has to be called before deleteSavedCustomer
    [EKSettings deleteSavedCustomer];
    
    [self performSegueWithIdentifier:kWelcomeSegue sender:nil];
}

@end
