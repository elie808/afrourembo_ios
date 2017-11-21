//
//  EKSearchFilterViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKFilterSearchViewController.h"

@implementation EKFilterSearchViewController {
    BOOL _filterViewVisible; // keep track if filter tableView is visible or not. Animate accordingly
    
    CGRect _categoryTableFinalFrame;
    CGRect _subCategoryTableFinalFrame;
    CGRect _hiddenFrame;
    CGFloat _animationDuration;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSourceArray = [NSArray new];
    self.categoryDataSource = @[@"Best weaving & extensions", @"Category 2", @"Category 3"];
    self.subCategoryDataSource = [NSMutableArray arrayWithArray:@[@"SubCategory 1", @"SubCategory 2", @"SubCategory 3"]];
    
    
    _animationDuration = 0.3;
    _hiddenFrame = CGRectMake(-500, self.tableView.frame.origin.y, self.view.frame.size.width/2, self.view.frame.size.height);
    _categoryTableFinalFrame = CGRectMake(0, self.tableView.frame.origin.y, self.view.frame.size.width/2, self.view.frame.size.height);
    _subCategoryTableFinalFrame = CGRectMake(self.view.frame.size.width/2, self.tableView.frame.origin.y,
                                             self.view.frame.size.width/2, self.view.frame.size.height);
    
    self.categoryTableView.frame    = _hiddenFrame;
    self.subCategoryTableView.frame = _hiddenFrame;
    
    [self.view addSubview:self.subCategoryTableView];
    [self.view addSubview:self.categoryTableView];
    
    [self hideFilterTableViewsWithAnimation:NO];
}

#pragma mark - Actions

- (IBAction)didTapFilterButton:(id)sender {
    
    if (_filterViewVisible) {
        [self hideFilterTableViewsWithAnimation:YES];
    } else {
        [self showFilterTableViewsWithAnimation:YES];
    }
}

#pragma mark - Helpers

- (void)hideFilterTableViewsWithAnimation:(BOOL)animated {
    
    if (animated) {
        
        [UIView animateWithDuration:_animationDuration
                         animations:^{
                     
                             self.subCategoryTableView.frame = self.categoryTableView.frame;
                             
                         } completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:_animationDuration
                                              animations:^{
                                                  
                                                  self.categoryTableView.frame = _hiddenFrame;
                                                  self.subCategoryTableView.frame = _hiddenFrame;
                                                  
                                              } completion:^(BOOL finished) {
                                                  
                                                  self.categoryTableView.hidden = YES;
                                                  self.subCategoryTableView.hidden = YES;
                                                  
                                                  _filterViewVisible = NO;
                                              }];
                         }];

    } else {
        
        self.categoryTableView.hidden = YES;
        self.subCategoryTableView.hidden = YES;
        
        _filterViewVisible = NO;
    }
}

- (void)showFilterTableViewsWithAnimation:(BOOL)animated {
    
    self.categoryTableView.hidden = NO;
    self.subCategoryTableView.hidden = NO;
    
    if (animated) {
        
        [UIView animateWithDuration:_animationDuration
                         animations:^{
                     
                             self.categoryTableView.frame = _categoryTableFinalFrame;
                             
                         } completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:_animationDuration
                                              animations:^{
                                                  
                                                  self.subCategoryTableView.frame = _subCategoryTableFinalFrame;
                                                  
                                              } completion:^(BOOL finished) {
                                                  
                                                  _filterViewVisible = YES;
                                              }];
                         }];
        
    } else {
        
        _filterViewVisible = YES;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kCompanyProfile]) {
        
    }
}

#pragma mark - Helpers

@end
