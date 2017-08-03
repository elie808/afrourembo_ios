//
//  EKCompanyReviewTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyReviewTableViewCell.h"

@implementation EKCompanyReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureEmptyCell {

    self.cellTextView.textColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
    self.cellTextView.text = @"There are no services yet.";    
}

- (void)configureCellForReview:(Review *)reviewObj {
    
    self.cellServiceLabel.text = reviewObj.serviceName;
    self.cellProfessionalLabel.text = @"";
    self.cellCustomerNameLabel.text = [NSString stringWithFormat:@"%@ %@", reviewObj.reviewerFirstName, reviewObj.reviewerLastName];
    self.cellDateLabel.text = @"09-09-1989";
    self.cellTextView.text = reviewObj.review;
    self.cellStarsImageView.image = [UIImage imageForStars:reviewObj.rating];
    [self.cellCustomerImageView yy_setImageWithURL:[NSURL URLWithString:reviewObj.reviewerProfilePicture]
                                           options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
}

@end
