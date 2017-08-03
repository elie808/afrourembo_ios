//
//  EKCompanyProfileViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyProfileViewController.h"
#import "EKCompanyProfileViewController+TableView.h"

@implementation EKCompanyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reviewsArray = [NSMutableArray new];
    
    Service *service1 = [Service new];
    service1.serviceName = @"Service 1 title";
    service1.price = 40;
    service1.time = 69;
    service1.currency = @"USD";
    
    Service *service2 = [Service new];
    service2.serviceName = @"Service 2 title";
    service2.price = 10;
    service2.time = 20;
    service2.currency = @"KSH";
    
    /*
    Review *review1 = [Review new];
    review1.reviewTitle = @"Review 1 title";
    review1.reviewStars = @3;
    review1.reviewAuthor = @"James Bond";
    review1.reviewText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis posuere viverra. Donec in efficitur nisi, ut faucibus ante. Duis sed facilisis orci. Phasellus sit amet leo iaculis, efficitur metus ut, fermentum ex.";
    review1.reviewTitle = @"Review 1 title";
    review1.reviewDate = @"Friday 13, 2017";
    review1.reviewProfessional = @"Mathew McCormick";
    review1.reviewProfessionalImage = @"dummy_male2";
    */
    
    [Review getReviewsForVendor:@"594a5f2ba191f90ead511ba9"
                         ofType:@"professional"
                withToken:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1OTU2NmQ4ZjU2MzcxMzEyNmZjNWFkZjIiLCJzZXNzaW9uS2V5IjoiZjNhMjBhMTAtNjBhNi0xMWU3LTkxMWYtMTE3ZWEzZDQ0NTNiIiwiY29udGV4dCI6InVzZXIiLCJpYXQiOjE0OTkxNjU1ODIsImV4cCI6MTQ5OTI1MTk4Mn0.XyyxSFLa1PP7tx2HQxMhY2r98ra0KfwPrIj5SuSGnkM"
                      withBlock:^(NSArray<Review *> *reviewsArray) {
                          
                          self.reviewsArray = [NSMutableArray arrayWithArray:reviewsArray];
                          [self.tableView reloadData];
                      }
                     withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                         
                     }];
    
    //------
    if (self.professional) {
        
        [self.headerImageView yy_setImageWithURL:[NSURL URLWithString:self.professional.profilePicture]
                                         options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    }
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
