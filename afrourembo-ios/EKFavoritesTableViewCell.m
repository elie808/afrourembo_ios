//
//  EKFavoritesTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKFavoritesTableViewCell.h"

@implementation EKFavoritesTableViewCell

- (void)configureCellWithFavorite:(Favorite *)favObj {
    
    self.cellVendorNameLabel.text = favObj.businessName;
    self.cellRatingImageView.image = [UIImage imageForStars:favObj.rating];
    self.cellAddressLabel.text = favObj.address;
    self.cellRatingsBasedOnLabel.text = [NSString stringWithFormat:@"(%@)", favObj.ratingBasedOn];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
