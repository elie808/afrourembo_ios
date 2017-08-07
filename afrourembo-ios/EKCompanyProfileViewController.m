//
//  EKCompanyProfileViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyProfileViewController.h"
#import "EKCompanyProfileViewController+TableView.h"

static NSString * const kSalonType        = @"salon";
static NSString * const kProfessionalType = @"professional";

@implementation EKCompanyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reviewsArray = [NSMutableArray new];

    [self configureCarousel];
    
    [self getReviews];
}

#pragma mark - Helpers

- (void)configureCarousel {
    
    if (self.professional) {
        
        NSMutableArray *picLinksArray = [NSMutableArray new];
        for (Pictures *pic in self.professional.portfolio) { [picLinksArray addObject:pic.picture]; }
        
        [self.carousel configureWithVenueImages:picLinksArray];
        
    } else if (self.salon) {
        
    }
}

- (void)getReviews {
    
    NSString *vendorID;
    NSString *vendorType;
    
    if (self.professional) {
        
        vendorID = self.professional.professionalID;
        vendorType = kProfessionalType;
        
    } else if (self.salon) {
        
        vendorID = self.salon.salonID;
        vendorType = kSalonType;
    }

    [Review getReviewsForVendor:vendorID
                         ofType:vendorType
                      withToken:self.passedCustomer.token
                      withBlock:^(NSArray<Review *> *reviewsArray) {
                          
                          if (reviewsArray.count > 0) {
                              self.reviewsArray = [NSMutableArray arrayWithArray:reviewsArray];
                              [self.tableView reloadData];
                          }
                      }
                     withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                         
                         [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                     }];
}

#pragma mark - Actions

- (IBAction)didTapInstagramButton:(id)sender {
    
}

- (IBAction)didTapFacebookButton:(id)sender {
    
}

- (IBAction)didTapTwitterButton:(id)sender {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
