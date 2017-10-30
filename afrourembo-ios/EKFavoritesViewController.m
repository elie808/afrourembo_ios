//
//  EKFavoritesViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKFavoritesViewController.h"

static NSString * const kFavCell = @"favoriteCell";

@implementation EKFavoritesViewController {
    NSMutableArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSourceArray = [NSMutableArray new];
    
    self.emptyFavoritesView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y,
                                            self.tableView.frame.size.width, self.tableView.frame.size.height);
    self.emptyFavoritesView.hidden = NO;
    [self.view addSubview:self.emptyFavoritesView];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Customer getFavoritesForUser:[EKSettings getSavedCustomer].token
                        withBlock:^(NSArray<Favorite *> *favoriteObj) {
                          
                            if (favoriteObj.count > 0) {
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                self.emptyFavoritesView.hidden = YES;
                                _dataSourceArray = [NSMutableArray arrayWithArray:favoriteObj];
                                [self.tableView reloadData];
                            }
                            
                        } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                       }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Favorite *favObj = [_dataSourceArray objectAtIndex:indexPath.row];
    
    EKFavoritesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFavCell forIndexPath:indexPath];
    [cell configureCellWithFavorite:favObj];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
