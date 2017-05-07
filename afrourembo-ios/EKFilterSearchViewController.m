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
    
    self.dataSourceArray = [self createStubs];
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
    salon.latitude = -1.271536; //33.883630;
    salon.longitude = 36.845736; //35.495480;
    salon.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM"];
    
    Salon *salon1 = [Salon new];
    salon1.mainImageName = @"dummy_portrait2";
    salon1.stars = @2;
    salon1.price = @300;
    salon1.photoCount = @100;
    salon1.userImageName = @"dummy_male1";
    salon1.userName = @"James Lipton";
    salon1.address = @"More of Muindi Mbingu St.";
    salon1.latitude = -1.291536;
    salon1.longitude = 36.825736;
    salon1.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM", @"1:30 PM", @"Tue", @"8:20 AM", @"12:55 PM"];
    
    Salon *salon3 = [Salon new];
    salon3.mainImageName = @"dummy_portrait3";
    salon3.stars = @5;
    salon3.price = @30;
    salon3.photoCount = @10;
    salon3.userImageName = @"dummy_male2";
    salon3.userName = @"James Earl Lipton";
    salon3.address = @"Muindi Mbingu St.";
    salon3.latitude = -1.331536;
    salon3.longitude = 36.805736;
    salon3.timesArray = @[@"Today", @"9:00 AM"];
    
    Salon *salon4 = [Salon new];
    salon4.mainImageName = @"dummy_portrait5";
    salon4.stars = @5;
    salon4.price = @300;
    salon4.photoCount = @10;
    salon4.userImageName = @"dummy_male1";
    salon4.userName = @"Twinning Matumbo";
    salon4.address = @"Konakri Mbingu St.";
    salon4.latitude = -1.391536;
    salon4.longitude = 36.905736;
    salon4.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM", @"1:30 PM", @"Tue", @"8:20 AM", @"12:55 PM"];
    
    return @[salon, salon1, salon3, salon4];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
