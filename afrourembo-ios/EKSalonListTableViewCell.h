//
//  EKSalonListTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKInCellCollectionView.h"
#import "Professional.h"
#import "Salon.h"
#import "UIImage+Helpers.h"
#import "NSString+Helpers.h"
#import <YYWebImage/YYWebImage.h>

@interface EKSalonListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *cellMainImageView;
@property (strong, nonatomic) IBOutlet UIImageView *cellStarImageView;
@property (strong, nonatomic) IBOutlet UILabel *cellNumberOfReviewsLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellPhotoCountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *cellUserImageView;
@property (strong, nonatomic) IBOutlet UILabel *cellUserNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellAddressLabel;
@property (strong, nonatomic) IBOutlet UIImageView *cellIsMobileImageView;

@property (strong, nonatomic) IBOutlet EKInCellCollectionView *collectionView;

- (void)configureCellWithSalon:(Salon *)salon;
- (void)configureCellWithProfessional:(Professional *)profObj;

@end
