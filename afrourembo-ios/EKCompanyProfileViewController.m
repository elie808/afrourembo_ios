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
    /*
     @property NSString *mainImageName;
     @property NSNumber *stars;
     @property NSNumber *price;
     @property NSNumber *photoCount;
     @property NSString *userImageName;
     @property NSString *userName;
     @property NSString *address;
     
     //TODO: Encapsulate into object ?
     @property CGFloat longitude;
     @property CGFloat latitude;
     
     //TODO: CHANGE STRUCTURE. POSSIBLY HAVE A SEPARATE TIME OBJECT
     @property NSArray *timesArray;
     
     @property NSArray<Service*> *servicesArray;
     */
    
    /*
     @property NSString *reviewTitle;
     @property NSNumber *reviewStars;
     @property NSString *reviewAuthor;
     @property NSString *reviewText;
     @property NSDate *reviewDate;
     
     //TODO: Replace with professional NSObject
     @property NSString *reviewProfessional; // reviewed professional
     @property NSString *reviewProfessionalImage; // reviewed professional profile image
     */

    Service *service1 = [Service new];
    service1.name = @"Service 1 title";
    service1.price = 40;
    service1.time = 69;
    
    Service *service2 = [Service new];
    service2.name = @"Service 2 title";
    service2.price = 10;
    service2.time = 20;
    
    Review *review1 = [Review new];
    review1.reviewTitle = @"Review 1 title";
    review1.reviewStars = @3;
    review1.reviewAuthor = @"James Bond";
    review1.reviewText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis posuere viverra. Donec in efficitur nisi, ut faucibus ante. Duis sed facilisis orci. Phasellus sit amet leo iaculis, efficitur metus ut, fermentum ex.";
    review1.reviewTitle = @"Review 1 title";
    review1.reviewDate = @"Friday 13, 2017";
    review1.reviewProfessional = @"Mathew McCormick";
    review1.reviewProfessionalImage = @"dummy_male2";
    
    //------
    
    self.salon = [Salon new];
    self.salon.userName = @"LE SALON";
    self.salon.servicesArray = @[service1, service2];
    
    self.salon.reviewsArray = @[review1];
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
