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

    self.cellMainImageView.image = [UIImage imageNamed:salon.mainImageName];
    
    self.cellStarImageView.image = [self imageForStars:@3];
    self.cellPriceLabel.text = [NSString stringWithFormat:@"$%@+", salon.price];
    self.cellPhotoCountLabel.text = [NSString stringWithFormat:@"%@ Photo(s)", salon.photoCount];
    
    self.cellUserImageView.image = [UIImage imageNamed:salon.userImageName];
    self.cellUserNameLabel.text = salon.userName;
    self.cellAddressLabel.text = salon.address;
}

- (UIImage *)imageForStars:(NSNumber *)numberOfStars {
    
    return [UIImage imageNamed:@""];
}

@end
