//
//  EKCartViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCartViewController.h"

static NSString * const kSuccessSegue = @"cartToSuccessVC";
static NSString * const kCartCell = @"cartCollectionCellID";

@implementation EKCartViewController {
    NSMutableArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _dataSourceArray = [NSMutableArray arrayWithArray:[self createStubs]];
    _dataSourceArray = [NSMutableArray new];
    
    self.bottomBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bottomBar.layer.shadowOpacity = 0.3;
    self.bottomBar.layer.shadowRadius = 1;
    self.bottomBar.layer.shadowOffset = CGSizeMake(0, -3.5f);
}

- (NSArray *)createStubs {
    
    Booking *booking1 = [Booking new];
    booking1.bookingTitle = @"Haircut & Beard Trim";
    booking1.bookingCost = @"$250";
    booking1.bookingVendor = @"McLaren Barbershop";
    booking1.practionner = @"Johanna Mullins";
    booking1.bookingDate = @"Tue, 23 Nov, 2017";
    booking1.bookingTime = @"12:30 PM";
    booking1.bookingDescription = @"The virtual realm is uncharted territory for many designers. In the last few years, we’ve witnessed an explosion in virtual reality (VR) hardware and.";
    
    Booking *booking2 = [Booking new];
    booking2.bookingTitle = @"Nail Polish";
    booking2.bookingCost = @"$120";
    booking2.bookingVendor = @"Very Hip Barbershop";
    booking2.practionner = @"Mansa Musa";
    booking2.bookingDate = @"Mon, 23 Jan, 2017";
    booking2.bookingTime = @"09:05 AM";
    booking2.bookingDescription = @"";
//    booking2.bookingDescription = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis posuere viverra. Donec in efficitur nisi, ut faucibus ante. Duis sed facilisis orci. Phasellus sit amet leo iaculis, efficitur metus ut, fermentum ex.";
    
    Booking *booking3 = [Booking new];
    booking3.bookingTitle = @"Skin Care";
    booking3.bookingCost = @"$1000";
    booking3.bookingVendor = @"McLaren Barbershop";
    booking3.practionner = @"Bob Muller";
    booking3.bookingDate = @"Tue, 24 Dec, 2017";
    booking3.bookingTime = @"06:23 PM";
    booking3.bookingDescription = @"";
//    booking3.bookingDescription = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis posuere viverra. Donec in efficitur nisi, ut faucibus ante. Duis sed facilisis orci. Phasellus sit amet leo iaculis, efficitur metus ut, fermentum ex.";
    
    return @[booking1, booking2, booking3];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Booking *booking = [_dataSourceArray objectAtIndex:indexPath.row];
    
    EKCartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCartCell forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellIndexPath = indexPath;
    [cell configureCellWithBooking:booking];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - EKCartCollectionViewCellDelegate

- (void)didTapEditButtonAtIndex:(NSIndexPath *)indexPath {
    NSLog(@"TAPPING CELL AT ROW: %@", indexPath);
}

#pragma mark - Actions

- (IBAction)didTapCheckoutButton:(UIButton *)button {
 
    [self performSegueWithIdentifier:kSuccessSegue sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kSuccessSegue]) {
        
    }
}

@end
