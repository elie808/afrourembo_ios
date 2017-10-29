//
//  EKFavoritesTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"
#import "UIImage+Helpers.h"

@interface EKFavoritesTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *cellVendorNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *cellRatingImageView;
@property (strong, nonatomic) IBOutlet UILabel *cellAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellRatingsBasedOnLabel;

- (void)configureCellWithFavorite:(Favorite *)favObj;

@end
