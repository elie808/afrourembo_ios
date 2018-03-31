//
//  EKOrdersPaymentsViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/24/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKOrdersPaymentsViewController.h"

static NSString * const kCell = @"ordersCollectionCellID";
static NSString * const kRatingSegue = @"ordersPaymentsToRatingVC";

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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Customer getBookingsForUser:[EKSettings getSavedCustomer].token
                       withBlock:^(NSArray<ClientBooking *> *customerObj) {
                           
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           
                           if (customerObj.count > 0) {
                               
                               self.emptyOrdersView.hidden = YES;
                               
                               _ordersArray = [NSMutableArray arrayWithArray:customerObj];
                               
                               // sort orders by dates
                               [_ordersArray sortUsingComparator:^NSComparisonResult(ClientBooking *obj1, ClientBooking *obj2){
                                   return [obj2.date compare:obj1.date];
                               }];
                               
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
        
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - EKCartCollectionViewCellDelegate

- (void)didTapEditButtonAtIndex:(NSIndexPath *)indexPath {
    
    ClientBooking *order = [_ordersArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kRatingSegue sender:order];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kRatingSegue]) {
        
        if (sender && [sender isKindOfClass:[ClientBooking class]]) {
            
            EKRatingViewController *vc = segue.destinationViewController;
            vc.passedBooking = (ClientBooking*)sender;
        }
    }
}

- (IBAction)unwindToOrdersVC:(UIStoryboardSegue *)segue {}

@end
