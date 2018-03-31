//
//  EKSalonListTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalonListTableViewCell.h"

@implementation EKSalonListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCellWithSalon:(Salon *)salon {

    self.cellUserNameLabel.text = salon.name;
    self.cellAddressLabel.text = salon.address;
    self.cellStarImageView.image = [UIImage imageForStars:salon.rating];
    self.cellNumberOfReviewsLabel.text = [NSString stringWithFormat:@"%@ Review(s)", salon.ratingBasedOn];
    
    [self.cellUserImageView yy_setImageWithURL:[NSURL URLWithString:salon.profilePicture]
                                   placeholder:[UIImage imageNamed:@"icPlaceholder"]
                                       options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation
                                    completion:nil];
    
    self.cellPhotoCountLabel.text = [NSString numberOfPhotosForCount:salon.portfolio.count];
    
    if (salon.portfolio && salon.portfolio.count > 0) {
        
        self.cellPhotoCountLabel.text = [NSString numberOfPhotosForCount:salon.portfolio.count];
        
        Pictures *picObj = salon.portfolio[0];
        
        [self.cellMainImageView yy_setImageWithURL:[NSURL URLWithString:picObj.picture]
                                       placeholder:[UIImage imageNamed:@"brush_tableview"]
                                           options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation
                                        completion:nil];
    } else {
        
        self.cellPhotoCountLabel.text = [NSString numberOfPhotosForCount:0];
        self.cellMainImageView.image = [UIImage imageNamed:@"brush_tableview"];
    }
}

- (void)configureCellWithProfessional:(Professional *)profObj {
    
    self.cellUserNameLabel.text = [NSString stringWithFormat:@"%@ %@",profObj.fName, profObj.lName];
    self.cellStarImageView.image = [UIImage imageForStars:profObj.rating];
    self.cellNumberOfReviewsLabel.text = [NSString stringWithFormat:@"%@ Review(s)", profObj.ratingBasedOn];
    
    if (profObj.profilePicture && profObj.profilePicture.length > 0) {

        [self.cellUserImageView yy_setImageWithURL:[NSURL URLWithString:profObj.profilePicture]
                                           options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        
    } else {
        
        self.cellUserImageView.image = [UIImage imageNamed:@"icPlaceholder"];
    }
 
    if (profObj.services && profObj.services.count > 0 ) {
        
        Service *serviceObj = profObj.services[0];
        self.cellPriceLabel.text = [NSString stringWithFormat:@"%ld %@", (long)serviceObj.price, serviceObj.currency];
        
    } else {
        
        self.cellPriceLabel.text = @"N/A";
    }
    
    if (profObj.portfolio && profObj.portfolio.count > 0) {
        
        self.cellPhotoCountLabel.text = [NSString numberOfPhotosForCount:profObj.portfolio.count];
        
        Pictures *picObj = profObj.portfolio[0];
        [self.cellMainImageView yy_setImageWithURL:[NSURL URLWithString:picObj.picture]
                                           options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    } else {
        
        self.cellPhotoCountLabel.text = [NSString numberOfPhotosForCount:0];
        self.cellMainImageView.image = [UIImage imageNamed:@"brush_tableview"];
    }
    
    if (profObj.isMobile) {
        self.cellIsMobileImageView.image = [UIImage imageNamed:@"isMobile"];
    } else {
        self.cellIsMobileImageView.image = nil;
    }
}

@end
