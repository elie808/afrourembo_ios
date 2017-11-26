//
//  EKOrdersPaymentsViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/24/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKOrdersPaymentsViewController.h"

static NSString * const kCell = @"ordersCollectionCellID";

@implementation EKOrdersPaymentsViewController {
    NSMutableArray<ClientBooking *> *_ordersArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _ordersArray = [NSMutableArray new];
    
    self.emptyOrdersView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y,
                                          self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    self.emptyOrdersView.hidden = NO;
    [self.view addSubview:self.emptyOrdersView];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Customer getBookingsForUser:[EKSettings getSavedCustomer].token
                       withBlock:^(NSArray<ClientBooking *> *customerObj) {

                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           
                           if (customerObj.count > 0) {
                               
                               self.emptyOrdersView.hidden = YES;
                               
                               _ordersArray = [NSMutableArray arrayWithArray:customerObj];
                               [self.collectionView reloadData];
                           }
                           
                       } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                          
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                       }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _ordersArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClientBooking *order = [_ordersArray objectAtIndex:indexPath.row];
    
    EKCartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellIndexPath = indexPath;
    [cell configureCellWithOrder:order];
    
    if (order.reviewed) { cell.actionButton.hidden = YES; } else { cell.actionButton.hidden = NO; }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - EKCartCollectionViewCellDelegate

- (void)didTapEditButtonAtIndex:(NSIndexPath *)indexPath {
    
    NSLog(@"TAP ATO");
//    Booking *booking = [_bookings objectAtIndex:indexPath.row];
//    
//    [[RLMRealm defaultRealm] beginWriteTransaction];
//    [[RLMRealm defaultRealm] deleteObject:booking.reservation];
//    [[RLMRealm defaultRealm] deleteObject:booking];
//    [[RLMRealm defaultRealm] commitWriteTransaction];
//    
//    if (_bookings.count > 0) {
//        
//        self.bottomBar.hidden = NO;
//        self.emptyCartView.hidden = YES;
//        
//    } else {
//        
//        self.bottomBar.hidden = YES;
//        self.emptyCartView.hidden = NO;
//    }
//    
//    [self.collectionView reloadData];
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
