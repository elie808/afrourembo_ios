//
//  EKCompanyProfileViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKCompanyServiceTableViewCell.h"
#import "EKCompanyReviewTableViewCell.h"
#import "EKCompanyProfessionalTableViewCell.h"
#import "EKCompanyContactTableViewCell.h"

#import "EKInCellCollectionView.h"
#import "EKCompanyProfessionalCollectionViewCell.h"

#import "Customer.h"
#import "Professional.h"
#import "Review.h"
#import "Salon.h"
#import "Service.h"

#import "EKCarousel.h"
#import "Review+API.h"
#import "UIViewController+Helpers.h"

#import <YYWebImage/YYWebImage.h>

@interface EKCompanyProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet EKCarousel *carousel;

@property (strong, nonatomic) Customer *passedCustomer;
@property (strong, nonatomic) Salon *salon;
@property (strong, nonatomic) Professional *professional;

@property (strong, nonatomic) NSMutableArray *reviewsArray;

- (IBAction)didTapInstagramButton:(id)sender;
- (IBAction)didTapFacebookButton:(id)sender;
- (IBAction)didTapTwitterButton:(id)sender;

@end
