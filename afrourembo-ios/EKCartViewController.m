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
//    NSMutableArray *_dataSourceArray;
    RLMResults<Booking *> *_bookings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([EKSettings getSavedCustomer].email.length > 0) {
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"bookingOwner = %@", [EKSettings getSavedCustomer].email];
        _bookings = [Booking objectsWithPredicate:pred];
        
        [self.collectionView reloadData];
    }
    
    self.bottomBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bottomBar.layer.shadowOpacity = 0.3;
    self.bottomBar.layer.shadowRadius = 1;
    self.bottomBar.layer.shadowOffset = CGSizeMake(0, -3.5f);
    
    if (_bookings.count > 0) { self.bottomBar.hidden = NO; } else { self.bottomBar.hidden = YES; }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _bookings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Booking *booking = [_bookings objectAtIndex:indexPath.row];
    
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
    
    Booking *booking = [_bookings objectAtIndex:indexPath.row];
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteObject:booking.reservation];
    [[RLMRealm defaultRealm] deleteObject:booking];
    [[RLMRealm defaultRealm] commitWriteTransaction];
    
    [self.collectionView reloadData];
    
    if (_bookings.count > 0) { self.bottomBar.hidden = NO; } else { self.bottomBar.hidden = YES; }
}

#pragma mark - Actions

- (IBAction)didTapCheckoutButton:(UIButton *)button {
    
    if ([EKSettings getSavedCustomer].token.length > 0) {
        
        // filter Reservation objects out of Booking objects in the dataSource
        NSMutableArray *reservationsArray = [NSMutableArray new];
        for (Booking *bookingObj in _bookings) {
            [reservationsArray addObject:bookingObj.reservation];
        }
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Reservation postUserReservations:reservationsArray
                                  forUser:[EKSettings getSavedCustomer].token
                                withBlock:^(Reservation *reservation) {
                                    
                                    for (Booking *bookingObj in _bookings) {
                                        [[RLMRealm defaultRealm] beginWriteTransaction];
                                        [[RLMRealm defaultRealm] deleteObject:bookingObj.reservation];
                                        [[RLMRealm defaultRealm] deleteObject:bookingObj];
                                        [[RLMRealm defaultRealm] commitWriteTransaction];
                                    }
                                    
                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                    [self performSegueWithIdentifier:kSuccessSegue sender:nil];
                                }
                               withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                   
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                               }];
        
    } else {
        
        //TODO: Sign in popup
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kSuccessSegue]) {
        
    }
}

@end
