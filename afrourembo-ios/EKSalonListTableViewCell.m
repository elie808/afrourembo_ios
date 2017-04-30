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
    
    self.cellStarImageView.image = [self imageForStars:salon.stars];
    self.cellPriceLabel.text = [NSString stringWithFormat:@"$%@+", salon.price];
    self.cellPhotoCountLabel.text = [NSString stringWithFormat:@"%@ Photo(s)", salon.photoCount];
    
    self.cellUserImageView.image = [UIImage imageNamed:salon.userImageName];
    self.cellUserNameLabel.text = salon.userName;
    self.cellAddressLabel.text = salon.address;
}

- (UIImage *)imageForStars:(NSNumber *)numberOfStars {
    
    switch ([numberOfStars integerValue]) {
        
        case 0: return [UIImage imageNamed:@"0star"]; break;
        case 1: return [UIImage imageNamed:@"1star"]; break;
        case 2: return [UIImage imageNamed:@"2star"]; break;
        case 3: return [UIImage imageNamed:@"3star"]; break;
        case 4: return [UIImage imageNamed:@"4star"]; break;
        case 5: return [UIImage imageNamed:@"5star"]; break;
            
        default: return [UIImage imageNamed:@"0star"]; break;
    }
}

@end
