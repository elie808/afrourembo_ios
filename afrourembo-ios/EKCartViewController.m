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

static NSString * const kSignUpSegue = @"cartVCToSignUpVC";
static NSString * const kWebViewSegue = @"cartVCtoWebVC";

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
    
    [self initializeLayout];
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
    
    if (_bookings.count > 0) {
        
        self.bottomBar.hidden = NO;
        self.emptyCartView.hidden = YES;
        
    } else {
        
        self.bottomBar.hidden = YES;
        self.emptyCartView.hidden = NO;
    }
    
    [self.collectionView reloadData];
}

#pragma mark - Actions



- (IBAction)didTapCheckoutButton:(UIButton *)button {

    // filter Reservation objects out of Booking objects in the dataSource
    NSMutableArray *reservationsArray = [NSMutableArray new];
    for (Booking *bookingObj in _bookings) {
        
        [reservationsArray addObject:[Booking convertBookingObj:bookingObj]];
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Reservation postUserReservations:reservationsArray
                              forUser:[EKSettings getSavedCustomer].token
                            withBlock:^(Reservation *reservation) {

                                Payment *paymentObj = [Payment new];
                                paymentObj.descriptionText = @"Some Booking description here";
                                paymentObj.currency = @"USD";
                                
//                                float total = 0.0;
//                                for (Booking *bookingObj in _bookings) {
//                                    
//                                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//                                    f.numberStyle = NSNumberFormatterDecimalStyle;
//                                    NSNumber *bookingCost = [f numberFromString:bookingObj.bookingCost];
//
//                                    total = total + [bookingCost floatValue];
//                                }
//                                paymentObj.orderTotal = [NSNumber numberWithFloat:total];
                                
                                paymentObj.orderTotal = @20;
                                
                                paymentObj.fName = [EKSettings getSavedCustomer].fName;
                                paymentObj.lName = [EKSettings getSavedCustomer].lName;
                                paymentObj.email = [EKSettings getSavedCustomer].email;
                                paymentObj.mobile = [EKSettings getSavedCustomer].phone;
                                paymentObj.bookingID = reservation.bookingId;
                                
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                
//                                [self performSegueWithIdentifier:kWebViewSegue sender:paymentObj];
                                
                                //TODO: REMOVE BELOW CODE WHEN PAYMENT WEBPAGE RE-ENABLED
                                ///-----------------------///
                                // if booking succesful, remove all cached cart items
                                for (Booking *bookingObj in _bookings) {
                                    [[RLMRealm defaultRealm] beginWriteTransaction];
                                    [[RLMRealm defaultRealm] deleteObject:bookingObj.reservation];
                                    [[RLMRealm defaultRealm] deleteObject:bookingObj];
                                    [[RLMRealm defaultRealm] commitWriteTransaction];
                                }
                                
                                [self.collectionView reloadData];
                                [self performSegueWithIdentifier:kSuccessSegue sender:nil];
                                ///-----------------------///
                            }
                           withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                               
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               [self handleVendorAvailabilityErrors:error errorMessage:errorMessage statusCode:statusCode];
                           }];
}

#pragma mark - Navigation

- (IBAction)unwindToCartVC:(UIStoryboardSegue *)segue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kWebViewSegue]) {
        
        if (sender && [sender isKindOfClass:[Payment class]]) {
            EKPaymentGatewayViewController *vc = segue.destinationViewController;
            vc.paymentObj = (Payment*)sender;
        }
    }
    
    if ([segue.identifier isEqualToString:kSuccessSegue]) {
        
    }
}

#pragma mark - Helpers

- (void)initializeLayout {
    
    self.emptyCartView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.emptyCartView];
    self.emptyCartView.hidden = YES;
    
    self.bottomBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bottomBar.layer.shadowOpacity = 0.3;
    self.bottomBar.layer.shadowRadius = 1;
    self.bottomBar.layer.shadowOffset = CGSizeMake(0, -3.5f);
    
    if (_bookings.count > 0) {
        self.bottomBar.hidden = NO;
        self.emptyCartView.hidden = YES;
    } else {
        self.bottomBar.hidden = YES;
        self.emptyCartView.hidden = NO;
    }
}

- (void)handleVendorAvailabilityErrors:(NSError *)error errorMessage:(NSString *)errorMessage statusCode:(NSInteger) statusCode {
    
    if (statusCode == 401) { // invalid token
        
        [self showLoginDialog:^(UIAlertAction *action, NSString *emailString, NSString *passString) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            [Customer loginCustomer:emailString
                           password:passString
                          withBlock:^(Customer *customerObj) {
                              
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              [EKSettings saveCustomer:customerObj];
                          }
                         withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                             
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             [self showMessage:errorMessage withTitle:@"There is something wrong"
                               completionBlock:nil];
                         }];
            
        } andSignUpBlock:^(UIAlertAction *action) {
            
            [EKSettings deleteBookingsForCustomer:[EKSettings getSavedCustomer]];
            [EKSettings deleteSavedCustomer];
            [self performSegueWithIdentifier:kSignUpSegue sender:nil];
        }];
        
    } else {
        
        [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
    }
}

@end
