//
//  EKExploreViewController+SideMenuTableView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/8/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKExploreViewController+SideMenuTableView.h"

static NSString * const  kSideMenuCell = @"sideMenuCell";

@implementation EKExploreViewController (SideMenuTableView)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sideMenuDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKImageTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSideMenuCell forIndexPath:indexPath];
    
    NSString *imageName = [[(NSDictionary *)[self.sideMenuDataSource objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *textValue = [[(NSDictionary *)[self.sideMenuDataSource objectAtIndex:indexPath.row] allValues] firstObject];
    
    cell.cellImageView.image = [UIImage imageNamed:imageName];
    cell.cellTextLabel.text = textValue;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 52.0;
}

@end
