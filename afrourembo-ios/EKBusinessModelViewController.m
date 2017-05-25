//
//  EKBusinessModelViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBusinessModelViewController.h"

static CGFloat const kRowHeight = 220;

static NSString * const kCentralizedCell = @"centralizedModelCell";
static NSString * const kDecentralizedCell = @"decentralizedModelCell";

@implementation EKBusinessModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Business Model";
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCentralizedCell forIndexPath:indexPath];
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDecentralizedCell forIndexPath:indexPath];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kRowHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (self.BusinessModelUser == BusinessModelUserIndependentBP) {
        
        [self performSegueWithIdentifier:@"businessModelToServiceVC" sender:nil];
        
    } else {
     
        [self performSegueWithIdentifier:@"businessModelToSalonSelectVC" sender:nil];
    }
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
