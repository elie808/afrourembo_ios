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
#import "EKCompanyProfessionalCollectionViewCell.h"

#import "EKInCellCollectionView.h"
#import "EKBookingViewController.h"

#import "Customer.h"
#import "Professional.h"
#import "Review.h"
#import "Salon.h"
#import "Service.h"

#import "EKConstants.h"
#import "EKCarousel.h"
#import "Review+API.h"
#import "Salon+API.h"
#import "UIViewController+Helpers.h"

#import "MWPhotoBrowser.h"
#import <YYWebImage/YYWebImage.h>

static NSString * const kBookingSegue     = @"companyProfileVCToBookingVC";

@interface EKCompanyProfileViewController : UIViewController <MWPhotoBrowserDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet EKCarousel *carousel;
@property (strong, nonatomic) IBOutlet UILabel *photoCountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *starsImageView;

@property (strong, nonatomic) Customer *passedCustomer;
@property (strong, nonatomic) Salon *passedSalon;
@property (strong, nonatomic) Professional *passedProfessional;

@property (strong, nonatomic) NSMutableArray *reviewsArray;
@property (strong, nonatomic) NSMutableArray *staffArray;

- (IBAction)didTapFavoriteButton:(id)sender;
- (IBAction)didTapInstagramButton:(id)sender;
- (IBAction)didTapFacebookButton:(id)sender;
- (IBAction)didTapTwitterButton:(id)sender;

- (void)getReviewsForVendor:(NSString *)vendorID ofType:(NSString *)vendorType;

/// make phone calls
- (void)call:(NSString *)phoneNumber;

@end
