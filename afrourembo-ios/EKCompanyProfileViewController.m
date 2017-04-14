//
//  EKCompanyProfileViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyProfileViewController.h"

static NSString * const kServicesCell       = @"companyServicesCell";
static NSString * const kReviewsCell        = @"companyReviewsCell";
static NSString * const kProfessionalsCell  = @"companyProfessionalsCell";
static NSString * const kContactsCell       = @"companyContactsCell";

@implementation EKCompanyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    switch (section) {
            
        case 0: return 3; break; // Services
            
        case 1: return 2; break; // Reviews
            
        case 2: return 1; break; // Professionals
            
        case 3: return 3; break; // Contacts
            
        default: return 0; break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
            
        case 0: { // Services
            
            EKCompanyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kServicesCell forIndexPath:indexPath];
            
            return cell;
            
        } break;
        
        case 1: { // Reviews
            
            EKCompanyReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReviewsCell forIndexPath:indexPath];
            
            return cell;
            
        } break;
            
        case 2: { // Professionals
        
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfessionalsCell forIndexPath:indexPath];
            
            return cell;
            
        } break;
            
        case 3: { // Contacts
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactsCell forIndexPath:indexPath];
            
            return cell;
            
        } break;
            
        default: return nil; break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
            
        // Services
        case 0: return 82.0; break;
            
        // Reviews
        case 1: {
            
            if (indexPath.row == 0) return 350;
            
            return 220.0;
            
        } break;
            
        // Services
        case 3: return 72.0; break;
            
        default: return 44.0; break;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

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
