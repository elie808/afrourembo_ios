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
    _dataSourceArray = @[@"", @"", @"", @""];
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
    
    cell.backgroundColor = [UIColor brownColor];
    
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
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
    
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

@end
