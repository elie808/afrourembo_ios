//
//  EKSalonListViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalonListViewController.h"

static NSString * const  kTableViewCell = @"salonListCell";
static NSString * const  kCollectionViewCell = @"salongListInCellCollectionViewCell";

@implementation EKSalonListViewController {
    NSArray *_dataSourceArray;
    NSArray *_collectionDataSourceArray;
    NSMutableDictionary *_contentOffsetDictionary; // used to keep track of collectionViews scrolling positions/offsets
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contentOffsetDictionary = [NSMutableDictionary new];
    _dataSourceArray = [self createStubs];
    _collectionDataSourceArray = @[@"", @"", @"", @"", @"", @"", @"", @"", @"", @""];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKSalonListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell forIndexPath:indexPath];
    
    Salon *salon = [_dataSourceArray objectAtIndex:indexPath.row];
    
    [cell configureCellWithSalon:salon];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(EKSalonListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // keep track in which cell the collectionView is, to properly manage it's dataSource and display correctly
    cell.collectionView.collectionIndexPath = indexPath;
    [cell.collectionView reloadData];
    
    NSInteger index = cell.collectionView.collectionIndexPath.row;
    CGFloat horizontalOffset = [_contentOffsetDictionary[[@(index) stringValue]] floatValue];
    
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(EKSalonListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat horizontalOffset = cell.collectionView.contentOffset.x;
    NSInteger index = cell.collectionView.collectionIndexPath.row;
    _contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionDataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    cell.cellTextLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    Salon *salon1 = [Salon new];
    salon1.mainImageName = @"dummy_portrait2";
    salon1.stars = @3;
    salon1.price = @300;
    salon1.photoCount = @100;
    salon1.userImageName = @"dummy_male1";
    salon1.userName = @"James Lipton";
    salon1.address = @"More of Muindi Mbingu St.";
    
    Salon *salon3 = [Salon new];
    salon3.mainImageName = @"dummy_portrait3";
    salon3.stars = @3;
    salon3.price = @30;
    salon3.photoCount = @10;
    salon3.userImageName = @"dummy_male2";
    salon3.userName = @"James Earl Lipton";
    salon3.address = @"Muindi Mbingu St.";
    
    return @[salon, salon1, salon3];
}

@end
