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
     @property NSString *serviceTitle;
     @property NSString *serviceImage;
     
     @property NSString *serviceGroup;
     @property CGFloat servicePrice;
     @property CGFloat serviceLaborTime; //in minutes
     */

    Service *service1 = [Service new];
    service1.serviceTitle = @"Service 1 title";
    service1.servicePrice = 40;
    service1.serviceLaborTime = 69;
    
    Service *service2 = [Service new];
    service2.serviceTitle = @"Service 2 title";
    service2.servicePrice = 10;
    service2.serviceLaborTime = 20;
    
    self.salon = [Salon new];
    self.salon.userName = @"LE SALON";
    self.salon.servicesArray = @[service1, service2];
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
