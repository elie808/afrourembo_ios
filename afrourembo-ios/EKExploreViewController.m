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
    NSMutableArray *_dataSourceArray;
    BOOL _sideMenuOpen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureSideTableView];
    
    [self configureFavoritesButton];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Category getCategoriesWithBlock:^(NSArray *categoriesArray) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        _dataSourceArray = [NSMutableArray arrayWithArray:categoriesArray];
        [self.collectionView reloadData];

    } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark - UICollectionViewLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(1, 1.5, 1, 1.5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = (collectionView.bounds.size.width - 4) / 2 ;
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

    Category *category = [_dataSourceArray objectAtIndex:indexPath.row];
    
    EKExploreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kExploreCell forIndexPath:indexPath];
    
    cell.cellTitleLabel.text = category.name;

    NSString *imageStr = category.icon.count > 0 ? category.icon[0] : @"";
    
    [cell.cellImageView yy_setImageWithURL:[NSURL URLWithString:imageStr]
                                   options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    Service *service = [_dataSourceArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kDiscoverSegue sender:service];
}

#pragma mark - Helpers

- (void)configureSideTableView {
    
    self.sideMenuDataSource = @[ @{@"icExploreActive"  : @"Explore"},
                                 @{@"icCartActive"     : @"Cart"},
                                 @{@"icPaymentsActive" : @"Orders"},
                                 //                                 @{@"icGiftNormal"     : @"Gifts"},
                                 @{@"icSettingsActive" : @"Settings"}
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
}

- (void)configureFavoritesButton {
    
    if ( (self.passedCustomer && self.passedCustomer.token) || ([EKSettings getSavedCustomer] && [EKSettings getSavedCustomer].token) ) {
        
        self.favoritesButton.enabled = YES;
        [self.favoritesButton setTintColor:[UIColor whiteColor]];
        
    } else {
        
        self.favoritesButton.enabled = NO;
        [self.favoritesButton setTintColor:[UIColor clearColor]];
    }
}

- (void)animateSideMenu {
    
    CGRect sideMenuFrame = CGRectZero;
    UIImage *sideButtonImage;
    
    if (_sideMenuOpen) {
        
        sideButtonImage = [UIImage imageNamed:@"icMenu"];
        sideMenuFrame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width/1.5, self.view.frame.size.height);
        
    } else {
        
        sideButtonImage = [UIImage imageNamed:@"icExit"];
        sideMenuFrame = CGRectMake(0, 0, self.view.frame.size.width/1.5, self.view.frame.size.height);
    }
    
    _sideMenuOpen = !_sideMenuOpen;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.sideMenuTableView.frame = sideMenuFrame;
                     }
                     completion:^(BOOL finished) {
                         [self.sideMenuButton setImage:sideButtonImage];
                     }];
}

- (NSArray *)createStubs {
    
    /*
     Service *service1 = [Service new];
     service1.name = kService1;
     service1.icon = @"dummy_portrait1";
     
     Service *service2 = [Service new];
     service2.name = kService2;
     service2.icon = @"dummy_portrait2";
     
     Service *service3 = [Service new];
     service3.name = kService3;
     service3.icon = @"dummy_portrait3";
     
     Service *service4 = [Service new];
     service4.name = kService4;
     service4.icon = @"dummy_portrait4";
     
     return @[service1, service2, service3, service4, service1, service2, service3, service4, service1, service2, service3, service4];
     */
    
    Category *cat = [Category new];
    cat.name = kService1;
    cat.icon = @[@"dummy_portrait4"];
    
    Category *cat1 = [Category new];
    cat1.name = kService2;
    cat1.icon = @[@"dummy_portrait3"];
    
    return @[cat, cat1 ,cat];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kDiscoverSegue]) {
        
        EKDiscoverMapViewController *vc = segue.destinationViewController;
        vc.title = ((Service*)sender).name;
        vc.passedCustomer = (Customer *)[EKSettings getSavedCustomer];
        vc.passedService = (Service*)sender;
    }
    
    if ([segue.identifier isEqualToString:kSearchSegue]) {
        
    }
    
    if ([segue.identifier isEqualToString:@"sideMenuToCustomerProfileVC"]) {
        EKEditProfileInfoViewController *vc = segue.destinationViewController;
        vc.unwindToExploreVC = YES;
        vc.passedUser = [EKSettings getSavedCustomer];
    }
}

- (IBAction)didTapSideMenuButton:(UIBarButtonItem *)sender {
    
    [self animateSideMenu];
}

- (IBAction)unwindToExploreVC:(UIStoryboardSegue *)segue {
    
}

@end
