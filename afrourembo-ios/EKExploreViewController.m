//
//  EKExploreViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKExploreViewController.h"

static NSString * const kExploreCell = @"exploreCollectionCell";

static NSString * const kSideMenuSegue  = @"exploreVcToSideMenuVC";
static NSString * const kSearchSegue    = @"exploreToDiscoverSearch";
static NSString * const kDiscoverSegue  = @"exploreToDiscover";

@implementation EKExploreViewController {
    NSArray *_dataSourceArray;
    BOOL _sideMenuOpen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sideMenuDataSource = @[ @{@"icExploreNormal"  : @"Explore"},
                                 @{@"icCartNormal"     : @"Cart"},
                                 @{@"icPaymentsNormal" : @"Orders"},
                                 @{@"icGiftNormal"     : @"Gifts"},
                                 @{@"icSettingsNormal" : @"Settings"}
                                 ];
    
    _sideMenuOpen = NO;
    self.sideMenuTableView.frame = CGRectMake(-self.view.frame.size.width, 0,
                                              self.view.frame.size.width/1.5, self.view.frame.size.height);
    [self.view addSubview:self.sideMenuTableView];
    
    // add drop shadow
    self.sideMenuTableView.clipsToBounds = NO;
    self.sideMenuTableView.layer.masksToBounds = NO;
    [self.sideMenuTableView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.sideMenuTableView.layer setShadowOffset:CGSizeMake(-10, 10)];
    [self.sideMenuTableView.layer setShadowRadius:10.0];
    [self.sideMenuTableView.layer setShadowOpacity:0.6];

    
    //TODO: REMOVE AFTER TESTING
    _dataSourceArray = [self createStubs];
    [self.collectionView reloadData];
}

- (NSArray *)createStubs {
    
    Service *service1 = [Service new];
    service1.serviceTitle = kService1;
    service1.serviceImage = @"dummy_portrait1";
    
    Service *service2 = [Service new];
    service2.serviceTitle = kService2;
    service2.serviceImage = @"dummy_portrait2";
    
    Service *service3 = [Service new];
    service3.serviceTitle = kService3;
    service3.serviceImage = @"dummy_portrait3";
    
    Service *service4 = [Service new];
    service4.serviceTitle = kService4;
    service4.serviceImage = @"dummy_portrait4";
    
    return @[service1, service2, service3, service4, service1, service2, service3, service4, service1, service2, service3, service4];
}

#pragma mark - UICollectionViewLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(1, 2, 1, 2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = (collectionView.bounds.size.width - 8) / 2 ;
    CGFloat cellHeight = cellWidth * 0.75;
    
    return CGSizeMake(cellWidth, cellHeight);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Service *service = [_dataSourceArray objectAtIndex:indexPath.row];
    
    EKExploreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kExploreCell forIndexPath:indexPath];
    cell.cellTitleLabel.text = service.serviceTitle;
    cell.cellImageView.image = [UIImage imageNamed:service.serviceImage];

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    Service *service = [_dataSourceArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kDiscoverSegue sender:service];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kDiscoverSegue]) {
        
        EKDiscoverMapViewController *vc = segue.destinationViewController;
        vc.title = ((Service*)sender).serviceTitle;
        vc.passedService = (Service*)sender;
    }
    
    if ([segue.identifier isEqualToString:kSearchSegue]) {
        
    }
}

- (IBAction)didTapSideMenuButton:(UIBarButtonItem *)sender {
    
    CGRect sideMenuFrame = CGRectZero;
    
    if (_sideMenuOpen) {
        
        sideMenuFrame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width/1.5, self.view.frame.size.height);
        
    } else {
        
        sideMenuFrame = CGRectMake(0, 0, self.view.frame.size.width/1.5, self.view.frame.size.height);
    }
    
    _sideMenuOpen = !_sideMenuOpen;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.sideMenuTableView.frame = sideMenuFrame;
                     }];
}

- (IBAction)unwindToExploreVC:(UIStoryboardSegue *)segue {
    
}

@end
