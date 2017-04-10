//
//  EKSalonListViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalonListViewController.h"

static NSString * const  kTableViewCell = @"salonListCell";
static NSString * const  kCollectionViewCell = @"yellowSalonListInCellCollectionViewCell";
static NSString * const  kDayCollectionViewCell = @"whiteSalonListInCellCollectionViewCell";

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
    
    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    Salon *salon = [_dataSourceArray objectAtIndex:index];
    
    return salon.timesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 4 == 0) {
        
        EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDayCollectionViewCell forIndexPath:indexPath];
        
        NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
        Salon *salon = [_dataSourceArray objectAtIndex:index];
        cell.cellTextLabel.text = [salon.timesArray objectAtIndex:indexPath.row];
        
        return cell;
        
    } else {

        EKSalonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
        
        NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
        Salon *salon = [_dataSourceArray objectAtIndex:index];
        cell.cellTextLabel.text = [salon.timesArray objectAtIndex:indexPath.row];
        
        return cell;
    }
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
    salon.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM"];
    
    Salon *salon1 = [Salon new];
    salon1.mainImageName = @"dummy_portrait2";
    salon1.stars = @3;
    salon1.price = @300;
    salon1.photoCount = @100;
    salon1.userImageName = @"dummy_male1";
    salon1.userName = @"James Lipton";
    salon1.address = @"More of Muindi Mbingu St.";
    salon1.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM", @"1:30 PM", @"Tue", @"8:20 AM", @"12:55 PM"];
    
    Salon *salon3 = [Salon new];
    salon3.mainImageName = @"dummy_portrait3";
    salon3.stars = @3;
    salon3.price = @30;
    salon3.photoCount = @10;
    salon3.userImageName = @"dummy_male2";
    salon3.userName = @"James Earl Lipton";
    salon3.address = @"Muindi Mbingu St.";
    salon3.timesArray = @[@"Today", @"9:00 AM"];
    
    return @[salon, salon1, salon3];
}

@end
