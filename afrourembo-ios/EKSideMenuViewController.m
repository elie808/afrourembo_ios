//
//  EKSideMenuViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSideMenuViewController.h"

static NSString * const  kSideMenuCell = @"sideMenuCell";
static NSString * const kUnwindSegue = @"sideMenuToExploreVC";

@implementation EKSideMenuViewController {
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundView.alpha = 0;
    
    _dataSourceArray = @[ @{@"icExploreActive"  : @"Explore"},
                          @{@"icCartActive"     : @"Cart"},
                          @{@"icPaymentsActive" : @"Orders"},
                          @{@"icGiftActive"     : @"Gifts"},
                          @{@"icSettingsActive" : @"Settings"}
                          ];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Animate to a dark backgroundView after the view has entered the window
    [UIView animateWithDuration:kLeftPushAnimationDuration
                          delay:kLeftPushAnimationDuration
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.backgroundView.alpha = 0.6;
                     }
                     completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKImageTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSideMenuCell forIndexPath:indexPath];
    
    NSString *imageName = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *textValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
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

#pragma mark - Actions

- (IBAction)didTapBackgroundVIew:(UITapGestureRecognizer *)gesture {
    [self performSegueWithIdentifier:kUnwindSegue sender:self];
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
