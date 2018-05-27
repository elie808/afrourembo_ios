//
//  EKSalonStaffTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKSalonStaffTableViewCell.h"

@implementation EKSalonStaffTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configureWith:(StaffPayment *)staff {
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", staff.professional.fName, staff.professional.lName];
    self.priceLabel.text = [NSString stringWithFormat:@"%ld %@", (long)staff.price, staff.currency];
    
    [self.profileImageView yy_setImageWithURL:[NSURL URLWithString:staff.professional.profilePicture]
                                             placeholder:[UIImage imageNamed:@"icPlaceholder"]
                                                 options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation
                                              completion:nil];
}

@end
