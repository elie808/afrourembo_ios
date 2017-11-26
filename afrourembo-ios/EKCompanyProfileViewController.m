//
//  EKCompanyProfileViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyProfileViewController.h"
#import "EKCompanyProfileViewController+TableView.h"

@implementation EKCompanyProfileViewController {
    NSString *_vendorID;
    NSString *_vendorType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reviewsArray = [NSMutableArray new];
    self.staffArray = [NSMutableArray new];

    if (self.passedProfessional) {
        
        _vendorID = self.passedProfessional.professionalID;
        _vendorType = kProfessionalType;
        
        [self getReviewsForVendor:_vendorID ofType:_vendorType];
        
    } else if (self.passedSalon) {
        
        _vendorID = self.passedSalon.salonID;
        _vendorType = kSalonType;
        
        [self getStaff];
    }
    
    [self configureCarousel];
}

#pragma mark - Helpers

- (void)configureCarousel {
    
    if (self.passedProfessional) {
        
        NSMutableArray *picLinksArray = [NSMutableArray new];
        for (Pictures *pic in self.passedProfessional.portfolio) { [picLinksArray addObject:pic.picture]; }
        
        [self.carousel configureWithVenueImages:picLinksArray];
        
    } else if (self.passedSalon) {
        
        NSMutableArray *picLinksArray = [NSMutableArray new];
        for (Pictures *pic in self.passedSalon.portfolio) { [picLinksArray addObject:pic.picture]; }
        
        [self.carousel configureWithVenueImages:picLinksArray];
    }
}

- (void)getReviewsForVendor:(NSString *)vendorID ofType:(NSString *)vendorType {

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Review getReviewsForVendor:vendorID
                         ofType:vendorType
                      withToken:self.passedCustomer.token
                      withBlock:^(NSArray<Review *> *reviewsArray) {
    
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          if (reviewsArray.count > 0) {
                              self.reviewsArray = [NSMutableArray arrayWithArray:reviewsArray];
                              [self.tableView reloadData];
                          }
                      }
                     withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                     }];
}

- (void)getStaff {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Salon getStaffForSalon:self.passedSalon.salonID
                forCustomer:[EKSettings getSavedCustomer].token
                  withBlock:^(NSArray<Professional *> *staffArray) {

                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      [self.staffArray addObjectsFromArray:staffArray];
                      [self.tableView reloadData];
                      
                  } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                      
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                 }];
}

- (void)call:(NSString *)phoneNumber {
    
    NSString *unspacedPhoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", unspacedPhoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneNumberURL]) {
        
        [[UIApplication sharedApplication] openURL:phoneNumberURL];
        
    } else {
        
    }
}

#pragma mark - Actions

- (IBAction)didTapFavoriteButton:(id)sender {
    
    [Customer postFavorite:_vendorID vendorType:_vendorType withToken:[EKSettings getSavedCustomer].token
                 withBlock:^(NSArray<Favorite *> *favoriteObj) {
                     [self showMessage:@"Added to favorites!" withTitle:@"Success" completionBlock:nil];
                 } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                     [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                 }];
    
//    [Customer deleteFavorite:_vendorID
//                   withToken:[EKSettings getSavedCustomer].token
//                   withBlock:^(NSArray<Favorite *> *favoriteObj) {
//                       [self showMessage:@"Removed from favorites!" withTitle:@"Success" completionBlock:nil];
//                   } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
//                      [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
//                  }];
    
}

- (IBAction)didTapInstagramButton:(id)sender {
    
}

- (IBAction)didTapFacebookButton:(id)sender {
    
}

- (IBAction)didTapTwitterButton:(id)sender {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kBookingSegue]) {
        
        EKBookingViewController *vc = [segue destinationViewController];
        
        if (sender && [sender isKindOfClass:[Service class]]) {
            vc.passedService = (Service *)sender;
        }
        
        if (self.passedProfessional) {
        
            vc.professionalsDataSource = @[self.passedProfessional];
            vc.salonId = @"-1";
            vc.salonName = @"-1";
            
        } else if (self.passedSalon) {
            
            vc.professionalsDataSource = @[self.passedSalon.selectedProfessional];
            vc.salonId = self.passedSalon.salonID;
            vc.salonName = self.passedSalon.name;
        }
    }
}

@end
